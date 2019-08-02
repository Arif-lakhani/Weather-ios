//
//  RootViewController.h
//  Weather
//
//  Created by Rachana Kamath on 10/17/18.
//  Copyright © 2018 Aron Beaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface RootViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *PageViewController;
@property (nonatomic,strong) NSMutableArray *arrPageTitles;
@property (nonatomic,strong) NSMutableArray *arrPageImages;
@property (nonatomic,strong) NSMutableArray *windarray;
@property (nonatomic,strong) NSMutableArray *pressurearray;
@property (nonatomic,strong) NSMutableArray *humidityarray;
@property (nonatomic,strong) NSMutableArray *tommorowarray;
@property (nonatomic,strong) NSMutableArray *datarray;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

- (IBAction)btnStartAgain:(id)sender;

@end
