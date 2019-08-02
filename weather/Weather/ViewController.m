//
//  ViewController.m
//  pickerview
//
//  Created by Yogesh Patel on 01/08/17.
//  Copyright © 2017 Yogesh Patel. All rights reserved.
//

#import "ViewController.h"
#import "CityFavDML.h"
@interface ViewController ()
{
    NSDictionary *dictionary;
        NSString *text1,*text2;
}
- (IBAction)SaveFAv:(id)sender;

@end

@implementation ViewController
- (void)viewDidLoad {

    text1=@"Alabama";
    text2=@"Alexandra City";
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AlabamaCities" ofType:@"csv"];
NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",content);
    NSMutableArray *Alabama=[content componentsSeparatedByString:@"\r\n"];
    
    _Alaska=[[NSMutableArray alloc]initWithObjects:@"Anchorage",
            @"Cordova",
            @"Fairbanks",
            @"Haines",
            @"Homer",
            @"Juneau",
            @"Ketchikan",
            @"Kodiak",
            @"Kotzebue",
            @"Nome",
            @"Palmer",
            @"Seward",
            @"Sitka",
            @"Skagway",
            @"Valdez",nil];
    

    
    // Do any additional setup after loading the view, typically from a nib.
    
   
    [super viewDidLoad];
    id objects[]={Alabama, _Alaska};
    id keys[]={@"Alabama",@"Alaska"};
    NSUInteger count = sizeof(objects) / sizeof(id);
    dictionary = [NSDictionary dictionaryWithObjects:objects
                                             forKeys:keys
                                               count:count];
    path = [[NSBundle mainBundle] pathForResource:@"States" ofType:@"csv"];
   content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",content);
    _arrdata=[content componentsSeparatedByString:@"\r\n"];
    

  
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return _arrdata.count;
    }
    if (component==1)
    {
        NSArray *a1=[[NSArray alloc]initWithArray:dictionary[text1]];
        return a1.count;
    }
    return component;
   // return arrdata.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component ==0)
    {
        return [_arrdata objectAtIndex:row];
    }
    if (component==1)
    {
        return [dictionary[text1] objectAtIndex:row];
    }
    return 0;
   // return [arrdata objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
    {
        text1=[_arrdata objectAtIndex:row];
        
        [pickerView reloadAllComponents];
    }
    if (component==1)
    {
        text2=[_Alaska objectAtIndex:row];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadCityIntoDatabase
{
  
    NSString* curWord = text2;
            [CityFavDML addFavCity:curWord ];
    
}

- (IBAction)SaveFAv:(id)sender {
    [ self loadCityIntoDatabase];
    [self dismissViewControllerAnimated:YES completion:nil];
   // [_ScoresField resignFirstResponder];
}
@end
