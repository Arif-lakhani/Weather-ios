//
//  ViewController.h
//  pickerview
//
//  Created by Yogesh Patel on 01/08/17.
//  Copyright © 2017 Yogesh Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
}



@property(strong, nonatomic)NSMutableArray *arrdata;
@property(strong, nonatomic)NSMutableArray *Alabama,*Alaska;
@end

