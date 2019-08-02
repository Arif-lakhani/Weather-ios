//
//  FavViewController.m
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 10/12/18.
//  Copyright © 2018 Aron Beaver. All rights reserved.
//

#import "FavViewController.h"
#import "CityFavDML.h"
//#import "MyCustomCell.h"

@interface FavViewController ()
- (IBAction)BtnReOrderAction:(id)sender;
- (IBAction)btnAddFavroite:(id)sender;
- (IBAction)btnBackHome:(id)sender;


@end

@implementation FavViewController
//@synthesize cityArray;

/*- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}*/


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // cityArray = [[NSMutableArray alloc]initWithObjects:@"Houson",@"Austin",@"Dallas",@"New York",@"Las Vegas", nil];
  //  cityArray=[[NSMutableArray init]alloc];
     cityArray = [CityFavDML fetchCities];
    NSLog(@"%@",cityArray);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    cityArray = [CityFavDML fetchCities];
    [self.tableView reloadData];

}
#pragma mark - Navigation

/*// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 #warning Incomplete implementation, return the number of sections
 return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 #warning Incomplete implementation, return the number of rows
 return _assArray.count;
 }*/
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 #warning Incomplete implementation, return the number of sections
 return 1;
 }
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 #warning Incomplete implementation, return the number of rows
     return cityArray.count;
 }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = [cityArray objectAtIndex:indexPath.row];
   
    //cell.textLabel.text = [cityArray objectAtIndex:indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
  
         [CityFavDML deleteCity:[cityArray objectAtIndex:indexPath.row]];
      [cityArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
      
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = cityArray[sourceIndexPath.row];
   [cityArray removeObjectAtIndex:sourceIndexPath.row];
    [cityArray insertObject:stringToMove atIndex:destinationIndexPath.row];
}

/*-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleInsert;
}*/


- (IBAction)btnBackHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)btnAddFavroite:(id)sender {
    [self performSegueWithIdentifier:@"Fav2Pick" sender:self];
}



- (IBAction)BtnReOrderAction:(id)sender {
    self.editing = YES;
}




@end
