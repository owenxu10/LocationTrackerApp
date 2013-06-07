//Include the NewSoftSerial library to send serial commands to the cellular module.

#include "SoftwareSerial.h"
#include <TinyGPS.h>
#include <PString.h>

#define POWERPIN 4
#define GPSRATE 4800
#define BUFFSIZ 90

char at_buffer[BUFFSIZ];
char buffidx;

const char *DEVICE_ID = "Arduino";
int firstTimeInLoop = 1;
int GPRS_registered;
int GPRS_AT_ready;
int GPRS_attached;
int connectedToServer;

//Will hold the incoming character from the Serial Port.
char incoming_char=0;
char buffer[100];

String dataStr;
PString myString(buffer,sizeof(buffer));

//Create a 'fake' serial port. Pin 2 is the Rx pin, pin 3 is the Tx pin.
SoftwareSerial cell(2,3);  

//Create the GPS object
TinyGPS gps;

//LED's for testing
int redLedPin  = 11;
int blueLedPin = 12;

// Function to Blink a LED
// Parameters: lPin   - Pin of the LED
//             nBlink - Number of Times to Blink
//             msec   - Time in milliseconds between each blink

void blinkLed(int lPin, int nBlink, int msec) {
  
  if (nBlink) {
    for (int i = 0; i < nBlink; i++) {
      digitalWrite(lPin, HIGH);
      delay(msec);
      digitalWrite(lPin, LOW);
      delay(msec);
    }
  }
} // Function to Switch on a LED  // Parameters: lPin - Pin of the LED
void onLed (int lPin) {

digitalWrite(lPin, HIGH);

}

// Function to Switch off a LED
// Parameters: lPin - Pin of the LED

void offLed (int lPin) {

digitalWrite(lPin, LOW);

}

// Do system wide initialization here in this function
void setup()
{  

// LED Pin are outputs. Switch the mode

pinMode(redLedPin, OUTPUT);
pinMode(blueLedPin, OUTPUT);

/* Blink the Power LED */

blinkLed(redLedPin,3,500);
//Initialize serial ports for communication.

Serial.begin(4800);
cell.begin(9600);
//Let's get started!

Serial.println("Starting SM5100B Communication...");
delay(3000);

/* Currently GPRS is not registered and AT is not ready */ 

GPRS_registered = 0;
GPRS_attached = 0;
GPRS_AT_ready = 0;
connectedToServer = 0; 
}
/* Reads AT String from the SM5100B GSM/GPRS Module */

void readATString(void) {  
  char c;
  buffidx= 0; // start at begninning 
  while (1) {
    if(cell.available() > 0) {
      c=cell.read();
      if (c == -1) {
        at_buffer[buffidx] = '\0';
        return;
      }
      if (c == '\n') {
        continue;
      }
      if ((buffidx == BUFFSIZ - 1) || (c == '\r')){
        at_buffer[buffidx] = '\0';
        return;
      }
      at_buffer[buffidx++]= c;
    }
  }
  }

void readCGString(void) {

 char c;

 buffidx= 0; // start at begninning

 while (1) {

 if(cell.available() > 0) {

 c=cell.read();

 if (c == -1) {

 at_buffer[buffidx] = '\0';

 return;
 }

 if (c == '\n') {

 continue;

 }

 if ((buffidx == BUFFSIZ - 1) || (c == '\r')){

 at_buffer[buffidx] = '\0';

 return;

 }

 at_buffer[buffidx++]= c;

 }

 }

}

/* Processes the AT String to determine if GPRS is registered and AT is ready */

void ProcessATString() {

 if( strstr(at_buffer, "+SIND: 8") != 0 ) {

 GPRS_registered = 0;

 Serial.println("GPRS Network Not Available");

 }

 if( strstr(at_buffer, "+SIND: 11") != 0 ) {

 GPRS_registered=1;

 Serial.println("GPRS Registered");

 blinkLed(redLedPin,5,100);

 }

 if( strstr(at_buffer, "+SIND: 4") != 0 ) {

 GPRS_AT_ready=1;

 Serial.println("GPRS AT Ready");
 }

}

void checkRemoteConnection(){
 if( strstr(at_buffer, "1,1") != 0 ) {
 Serial.println("Remote connection established:");
 Serial.println(at_buffer);
 connectedToServer = 1;
 }else{
 Serial.println("...Connecting to server...");
 Serial.println(at_buffer);
 }
}

void attachGPRS(){
 if(strstr(at_buffer, "+CGATT: 1") != 0 ) {
 Serial.println("GPRS attached successfully:");
 //Serial.println(at_buffer);
 GPRS_attached = 1;
 }else{
 Serial.println("...Attaching GPRS...");
 //Serial.println(at_buffer);
 }
}

boolean dataWasReceived(){
 if( strstr(at_buffer, "STCPD: 1") == 0 ) {
 Serial.println("Data not received.");
 return false;
 }else{
 Serial.println("Data successfully received.");
 return true;
 }
}

void loop() {

/* If called for the first time, loop until GPRS and AT is ready */
 if(firstTimeInLoop) {

 firstTimeInLoop = 0;

 while (GPRS_registered == 0 || GPRS_AT_ready == 0) {

 readATString();

 ProcessATString();
 }

 // Loop until the GPRS is attached:
 while(GPRS_attached == 0){
 cell.println("AT+CGATT?");
 delay(1000);
 readATString();
 attachGPRS();
 }

 if(POWERPIN) {

 pinMode(POWERPIN, OUTPUT);

 }

 pinMode(13, OUTPUT);

 Serial.println("GPS Parser Initialized");

 digitalWrite(POWERPIN, LOW);

 delay(1000);

 Serial.println("Setting up PDP Context");

 //cell.println("AT+CGDCONT=1,\"IP\",\"isp.cingular\"");
 cell.println("AT+CGDCONT=1,\"IP\",\"embeddedworks.globalm2m.net\"");

 delay(1000);

 Serial.println("Activating PDP Context");

 cell.println("AT+CGACT=1,1");

 delay(1000);

 Serial.println("Configuring TCP connection to TCP Server");

 cell.println("AT+SDATACONF=1,\"TCP\",\"asiangroup.woobi.co.kr\",9999");

 delay(1000);

 Serial.println("Starting TCP Connection\n");

 while(connectedToServer == 0){
 cell.println("AT+SDATASTART=1,1");
 //delay(1000);
 cell.println("AT+SDATASTATUS=1");
 readATString();
 checkRemoteConnection();
 }

 onLed(redLedPin);

 } else {

 while(Serial.available()) {

 int c = Serial.read();

 if (gps.encode(c)) {

 onLed(blueLedPin);

 float flat, flon;

 unsigned long fix_age;

 gps.f_get_position(&flat,&flon,&fix_age);

 if(fix_age == TinyGPS::GPS_INVALID_AGE) {

 Serial.println("No fix detected");

 } else if (fix_age > 5000) {

 Serial.println("WARNING: Possible Stale Data!");

 } else {
   myString.print("AT+SSTRSEND=1,\"devID:");
   myString.print(DEVICE_ID);
   myString.print(",lat:");
   myString.print(flat,DEC);
   myString.print(",lon:");
   myString.print(flon,DEC);
   myString.print(",\"");
   Serial.println(myString);
   cell.println(myString);
   myString.begin();
   offLed(blueLedPin);
   delay(10000);
       }
     }
   }
 }
}
