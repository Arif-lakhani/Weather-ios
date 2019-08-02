//
//  PageViewController.m
//  Weather
//
//  Created by Lakhani, Arif on 10/11/18.
//  Copyright © 2018 Aron Beaver. All rights reserved.
//

#import "PageViewController.h"
#import "PageContentViewController.h"
#import "RootViewController.h"

@interface PageViewController ()
{
NSArray *devices;
}
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    devices=@[@"one",@"two",@"three"];
    
    // Do any additional setup after loading the view.
    

}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




@end
