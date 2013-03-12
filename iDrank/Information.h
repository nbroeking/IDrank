//
//  Information.h
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject <NSCoding>
@property int gender;
@property int weight;
@property int age;
@property bool location;
@property bool first_log;

- (id) init;

//SETTERS
- (id) set_gender: (int) my_gender;
- (id) set_weight: (int) my_weight;

//GETTERS
- (int) get_gender;
- (int) get_weight;

//METHODS
- (void) edit_information: (int) new_gender witharg2: (double) new_weight;

-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString*) archivePath;
-(void) saveData;
-(void) loadData;
@end
