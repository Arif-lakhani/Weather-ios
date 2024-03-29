//
//  ViewController.h
//  Weather
//
//  Created by Aron Beaver on 9/2/17.
//  Copyright © 2017 Aron Beaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface PageContentViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblCF;
@property (weak, nonatomic) IBOutlet UIButton *btnCF;
- (IBAction)btnActCF:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ivScreenImage;
@property (weak, nonatomic) IBOutlet UILabel *lblScreenLabel;

@property NSUInteger pageIndex;
@property NSString *imgFile;
@property NSString *txtTitle;
@property NSString *cityName1;
@property NSString *pressure1;
@property NSString *wind1;
@property NSString *humidity1;
@property NSString *temper;
@property NSString *tod;
@property NSString *dat1;
@end

