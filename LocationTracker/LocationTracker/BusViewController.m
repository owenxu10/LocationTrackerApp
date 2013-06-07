//
//  BusViewController.m
//  LocationTracker
//
//  Created by XUXU on 13-6-2.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "BusViewController.h"

@interface BusViewController ()
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *arrayArduino;
    NSMutableArray *arrayLongitude;
    NSMutableArray *arrayLatitude;

}


@end

@implementation BusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self showAllBus]setDelegate:self];
    [[self showAllBus]setDataSource:self];
    arrayArduino = [[NSMutableArray alloc]init];
    arrayLongitude= [[NSMutableArray alloc]init];
    arrayLatitude= [[NSMutableArray alloc]init];
    
    [arrayArduino removeAllObjects];
    [arrayLongitude removeAllObjects];
    [arrayLatitude removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/locationTracker/index.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    // NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
    //NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    
    for (NSDictionary *diction in allDataDictionary) {
        NSDictionary *arduino = [diction objectForKey:@"Arduino"];
        NSDictionary *langitude = [diction objectForKey:@"Longitude"];
         NSDictionary *latitude = [diction objectForKey:@"Latitude"];
        [arrayArduino addObject:arduino];
        [arrayLongitude addObject:langitude];
        [arrayLatitude addObject:latitude];
    }
    
    
    [[self showAllBus]reloadData];
    
}

- (IBAction)refresh:(id)sender {
    [arrayArduino removeAllObjects];
    [arrayLongitude removeAllObjects];
    [arrayLatitude removeAllObjects];
    //    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/topalbums/limit=%d/json", [number intValue]];
    //    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/locationTracker/index.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayArduino count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSNumber *numberLatitude =[arrayLatitude objectAtIndex:indexPath.row];
    NSNumber *numberLongitude = [arrayLongitude objectAtIndex:indexPath.row];
    NSString *location = [NSString stringWithFormat:@"%f, %f",
                        numberLatitude.doubleValue, numberLongitude.doubleValue];
    
    cell.textLabel.text = [arrayArduino objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = location;
    
    return cell;
}



@end