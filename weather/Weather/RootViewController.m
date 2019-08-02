//
//  RootViewController.m
//  Weather
//
//  Created by Rachana Kamath on 10/17/18.
//  Copyright © 2018 Aron Beaver. All rights reserved.
//

#import "RootViewController.h"
#import "PageContentViewController.h"
#import "PageViewController.h"
#import "CityFavDML.h"
#import "OpenWeatherMapAPI.h"
#import "AppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController
/*- (void)loadView{
    [super loadView];
    _arrPageImages =@[@"1.png",@"2.png",@"3.png"];
    // _arrPageTitles= [CityFavDML fetchCities];
    _windarray=[[NSMutableArray alloc]initWithObjects:@"wind", nil];
    _arrPageTitles=@[@"Houston",@"Dallas",@"Austin"];
 
        
        
        NSString *str=[_arrPageTitles objectAtIndex:0];
        [OpenWeatherMapAPI fetchCurrentWeatherDataForLocation:str completion:^(WeatherData *weatherData) {
            NSLog(@"%@", weatherData);
            NSString *tempString = [weatherData tempString];
            NSString *wingData = [weatherData wind];
            NSString *pressData = [weatherData press];
            NSString *humidData = [weatherData humdity];
            NSString *tomoData = [weatherData tomorrow];
            NSString *datData = [weatherData dat];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //   self.degreesLabel.text = tempString;
                NSString *windnow = @"Wind: ";
                NSString *str=[windnow stringByAppendingString:wingData];
                [_windarray insertObject:str atIndex:0];
                // NSLog(@"wind for %@ is %@", wingData);
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
         ];
        
    
    
    
}*/
- (void)viewDidLoad {
    [super viewDidLoad];
    _arrPageImages =@[@"1.png",@"2.png",@"3.png"];
    // _arrPageTitles= [CityFavDML fetchCities];
    _arrPageTitles=@[@"Houston",@"Dallas",@"Austin"];
    
    

    // Do any additional setup after loading the view.
    // _arrPageTitles = @[@"ABC",@"DEF",@"XYZ"];
    
}
- (void)viewDidAppear:(BOOL)animated{
    // Create page view controller
    [super viewDidAppear:YES];

    self.PageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.PageViewController.dataSource = self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    [self addChildViewController:self.PageViewController];
    [self.view addSubview:self.PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
  //  [self viewDidLoad];
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*///PVC

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == [self.arrPageTitles count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.arrPageTitles count] == 0) || (index >= [self.arrPageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
   // AppDelegate *ap=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    AppDelegate *ap=(AppDelegate*)[[UIApplication sharedApplication] delegate];
  //  _windarray=ap.windarray;
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
  

   // pageContentViewController.imgFile = self.arrPageImages[index];
    pageContentViewController.cityName1=self.arrPageTitles[index];
   // pageContentViewController.txtTitle = self.arrPageTitles[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.wind1=ap.windarray[index];
    pageContentViewController.pressure1=ap.pressurearray[index];
    pageContentViewController.humidity1=ap.humidarray[index];
    pageContentViewController.temper=ap.temparray[index];
    pageContentViewController.tod=ap.todayarray[index];
    pageContentViewController.dat1=ap.datarray[index];
    
    NSLog(@"index is %lu and wind is %@",(unsigned long)index, ap.windarray[index]);
    return pageContentViewController;
    
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    

    
    return [self.arrPageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
