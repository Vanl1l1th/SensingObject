
#include "I2Cdev.h"
#include "MPU6050.h"
#include <CapacitiveSensor.h>

#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
#include "Wire.h"
#endif

MPU6050 accelgyro;

int16_t ax, ay, az;
int16_t x1, y1, z1, x2, y2, z2;

int16_t gx, gy, gz;

int touch=0;
CapacitiveSensor   cs_4_6 = CapacitiveSensor(4,6);
CapacitiveSensor   cs_4_7 = CapacitiveSensor(4,7);
CapacitiveSensor   cs_10_9 = CapacitiveSensor(10,9);
CapacitiveSensor   cs_10_11 = CapacitiveSensor(10,11);
#define OUTPUT_READABLE_ACCELGYRO

void setup() {
    // join I2C bus (I2Cdev library doesn't do this automatically)
    #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
        Wire.begin();
    #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
        Fastwire::setup(400, true);
    #endif
    Serial.begin(9600);

    accelgyro.initialize();
    ax=0; ay=0; az=0;
    // verify connection
    //Serial.println("Testing device connections...");
    //Serial.println(accelgyro.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");

    //cs_4_2.set_CS_AutocaL_Millis(0xFFFFFFFF);
}

void loop() {

    long start = millis();
    long total1 =  cs_4_6.capacitiveSensor(30);
    long total2 =  cs_4_7.capacitiveSensor(30);
    long total3 =  cs_10_9.capacitiveSensor(30);
    long total4=  cs_10_11.capacitiveSensor(30);
    if(total1>10000){touch=1;}else{touch=0;}
    
    // read raw accel/gyro measurements from device
    accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
    if(x1<ax){x1=ax;}  if(x2>ax){x2=ax;}
    if(y1<ay){y1=ay;}  if(y2>ay){y2=ay;}
    if(z1<az){z1=az;}  if(z2>az){z2=az;}
    int X=map(ax,x1,x2,0,15000); int Y=map(ay,y1,y2,0,15000); int Z=map(az,z1,z2,0,15000);
    
    #ifdef OUTPUT_READABLE_ACCELGYRO
        // display tab-separated accel/gyro x/y/z values
        Serial.print(X); Serial.print("a");
        Serial.print(Y); Serial.print("b");
        Serial.print(Z); Serial.print("c");
        Serial.print(total1);Serial.print("d");
        Serial.print(total2);Serial.print("e");
        Serial.print(total3);Serial.print("f");
        Serial.print(total4);Serial.print("g");                                                                                           ("g");
          #endif
   
    delay(10);
}
