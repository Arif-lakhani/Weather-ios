//
//  OpenWeatherMapAPI.m
//  Weather
//
//  Created by Aron Beaver on 9/3/17.
//  Copyright © 2017 Aron Beaver. All rights reserved.
//

#import "OpenWeatherMapAPI.h"
#import "Keys.h"

#import "CityFavDML.h"

@implementation OpenWeatherMapAPI

+ (OpenWeatherMapAPI *)sharedInstance {
    static OpenWeatherMapAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OpenWeatherMapAPI alloc] init];
    });
    return sharedInstance;
}

+ (void)fetchCurrentWeatherDataForLocation:(NSString *)location completion:(void(^)(WeatherData *weatherData))completion failure:(void(^)(NSError* error))failure{
    //float latitude = location.coordinate.latitude;

    //float longitude = location.coordinate.longitude;
    //NSLog(@"%f",latitude);
    //NSLog(@"%f",latitude);
  //  NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                          //  stringForKey:@"CurrentCityName"];
    NSString *savedValue=location;
    //NSLog(savedValue);
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=imperial&appid=%s",savedValue, kOpenWeatherMapAPIKey];

   // NSString *urlString;
 
    //if (v.btnCF.isSelected)// && v.lblCF.text isEqual:@"C")
    {
   // urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=houston&units=imperial&appid=%s", kOpenWeatherMapAPIKey];
        //v.lblCF.text=@"F";
    NSLog(@"F-%@", urlString);
     }
    //else if (v.btnCF.isSelected)// && [v.lblCF.text isEqual:@"F"])
  /*  {
        
        urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=houston&units=metric&appid=%s", kOpenWeatherMapAPIKey];
        v.lblCF.text=@"C";
        NSLog(@"C-%@", urlString);
    }*/
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(error) {
            failure(error);
        } else {
            WeatherData *weather = [[WeatherData alloc] initWithJSON:data];
            completion(weather);
        }
        
    }] resume];

}
+ (WeatherData *)fetchCurrentWeatherDataForLocation1:(NSString *)location {
   
    NSString *savedValue=location;
    //NSLog(savedValue);
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=imperial&appid=%s",savedValue, kOpenWeatherMapAPIKey];
    
    
    NSURL *url = [NSURL URLWithString:urlString];

    NSData *data = [NSData dataWithContentsOfURL:url];
   
           WeatherData *weather = [[WeatherData alloc] initWithJSON:data];
    
            return weather;
    
        

        
    }
    

@end
