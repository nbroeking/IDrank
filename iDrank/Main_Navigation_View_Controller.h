//
//  Main_Navigation_View_Controller.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stat.h"
#import "Information.h"
#import "Stat.h"
#import "ListOfDrinks.h"
#import <CoreLocation/CoreLocation.h>


@interface Main_Navigation_View_Controller : UINavigationController

@property(strong, nonatomic) Information *person;
@property(strong, nonatomic) Stat *night;
@property(strong, nonatomic) NSMutableArray *historyNights;
@property(strong, nonatomic) ListOfDrinks *drinkList;



-(void) save_data;
-(void) load_data;
-(void) start_night_data;
-(void) setPersonData: (long) maleGender : (double) weight;
-(long) isReadyStart;
-(double) getPersonWeight;
-(long) getPersonSex;
-(Stat*) getStat;
-(ListOfDrinks*) getDrinkList;

-(void)resetData;


-(void)endNightData;
@end
