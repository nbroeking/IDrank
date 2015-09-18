//
//  Information.h
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject <NSCoding>
@property long gender;
@property long weight;
@property long age;
@property bool location;
@property bool first_log;

- (id) init;

//SETTERS
- (id) set_gender: (long) my_gender;
- (id) set_weight: (long) my_weight;

//GETTERS
- (long) get_gender;
- (long) get_weight;

//METHODS
- (void) edit_information: (long) new_gender witharg2: (double) new_weight;

-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString*) archivePath;
-(void) saveData;
-(void) loadData;
@end
