//
//  ViewController.m
//  Weather
//
//  Created by Aron Beaver on 9/2/17.
//  Copyright © 2017 Aron Beaver. All rights reserved.
//

#import "PageViewController.h"
#import "PageContentViewController.h"
#import "RootViewController.h"
#import "OpenWeatherMapAPI.h"
#import "CityFavDML.h"

#define kUpdateInterval 3600

@interface PageContentViewController ()
{
    NSMutableArray *cities;
}
- (IBAction)btnAddFavroite:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *degreesLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *lastUpdate;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *tomorrow;
@property (weak, nonatomic) IBOutlet UILabel *dat;


@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.locationManager = [[CLLocationManager alloc] init];
    [self enableLocationServices];
    self.cityName.text=self.cityName1;
    self.wind.text=self.wind1;
    self.pressure.text=self.pressure1;
    self.humidity.text=self.humidity1;
    self.degreesLabel.text=self.temper;
    self.dat.text=self.dat1;
    self.tomorrow.text=self.tod;
    cities=[CityFavDML fetchCities];
    //PVC

    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
  //  [self.view reloadInputViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Location Services

- (void)enableLocationServices {
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self.locationManager stopUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if ([[NSDate date] timeIntervalSinceDate:self.lastUpdate] > kUpdateInterval || !self.lastUpdate) {
  
            
        
        /*[OpenWeatherMapAPI
            fetchCurrentWeatherDataForLocation:[locations lastObject]
                                    completion:^(WeatherData *weatherData) {
                                        NSLog(@"%@", weatherData);
                                        NSString *tempString = [weatherData tempString];
                                        NSString *wingData = [weatherData wind];
                                        NSString *pressData = [weatherData press];
                                        NSString *humidData = [weatherData humdity];
                                        NSString *tomoData = [weatherData tomorrow];
                                        NSString *datData = [weatherData dat];
   
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            self.degreesLabel.text = tempString;
                                            self.wind.text = @"Wind: ";
                                            self.wind.text = [self.wind.text stringByAppendingString:wingData];
                                            self.pressure.text = @"Pressure: ";
                                            self.pressure.text = [self.pressure.text stringByAppendingString:pressData];
                                            self.humidity.text = @"Humidity: ";
                                            self.humidity.text = [self.humidity.text stringByAppendingString:humidData];
                                            self.tomorrow.text = @"Tomorrow: ";
                                            self.tomorrow.text = [self.tomorrow.text stringByAppendingString:tomoData];
                                            self.dat.text = @"After 2 days: ";
                                            self.dat.text = [self.dat.text stringByAppendingString:datData];
                                            self.lastUpdate = [NSDate date];
                                            
                                        });
                                        }
                                    failure:^(NSError *error) {
                                        NSLog(@"Failed: %@",error);
                                    }
        ];*/
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self.locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                       NSLog(@"placemark.country %@",placemark.country);
                       NSLog(@"placemark.postalCode %@",placemark.postalCode);
                       NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
                       NSLog(@"placemark.locality %@",placemark.locality);
                       NSLog(@"placemark.subLocality %@",placemark.subLocality);
                       NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
                       NSString *valueToSave = placemark.locality;
                       [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"CurrentCityName"];
                       [[NSUserDefaults standardUserDefaults] synchronize];
                     //  self.cityName.text = valueToSave;
                       NSLog(@"saved city name in the key CurrentCityName");
                   }];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self.locationManager stopUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}


- (IBAction)btnActCF:(id)sender {
    int deg=self.degreesLabel.text.intValue;
    
    NSArray *tdegItems = [self.tomorrow.text componentsSeparatedByString:@": "];
    int tdeg =((NSString *)[tdegItems objectAtIndex:1]).intValue;
    
    NSArray *datdegItems = [self.dat.text componentsSeparatedByString:@": "];
    int datdeg =((NSString *)[datdegItems objectAtIndex:1]).intValue;
    //int datdeg=self.dat.text.intValue;
    
    if ([_lblCF.text isEqual:@"F"])
    {
        self.degreesLabel.text = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%0.f", ((deg - 32) * (5.0/9.0))], @"°"];

        _lblCF.text=@"C";
        self.tomorrow.text = [NSString stringWithFormat:@"%@%@%@",@"Tomorrow: ",[NSString stringWithFormat:@"%0.f", ((tdeg - 32) * (5.0/9.0))], @"°"];
        self.dat.text = [NSString stringWithFormat:@"%@%@%@",@"After 2 days: ",[NSString stringWithFormat:@"%0.f", ((datdeg - 32) * (5.0/9.0))], @"°"];
    }
    else if ([_lblCF.text isEqual:@"C"])
    {
        self.degreesLabel.text= [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%0.f",((deg * (9.0/5.0)) + 32)], @"°"];

        _lblCF.text=@"F";
        self.tomorrow.text = [NSString stringWithFormat:@"%@%@%@",@"Tomorrow: ",[NSString stringWithFormat:@"%0.f",((tdeg * (9.0/5.0)) + 32)], @"°"];
        self.dat.text = [NSString stringWithFormat:@"%@%@%@",@"After 2 days: ",[NSString stringWithFormat:@"%0.f",((datdeg * (9.0/5.0)) + 32)], @"°"];
    }
}
- (IBAction)btnAddFavroite:(id)sender {
    [self performSegueWithIdentifier:@"FavtoFav" sender:self];
}
@end
