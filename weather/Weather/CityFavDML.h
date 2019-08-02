//
//  GuessWordDML.h
//  Hangman
//
//  Created by CSCI5737 Fall18 on 10/2/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityFavDML : NSObject

+ (NSMutableArray *)fetchCities;
+ (bool)addFavCity:(NSString *)City;
+ (bool)deleteCity:(NSString *)wordString;


@end
