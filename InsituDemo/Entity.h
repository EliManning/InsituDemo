//
//  Entity.h
//  InsituDemo
//
//  Created by smart_parking on 9/20/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * populate;
@property (nonatomic, retain) NSString * url;

@end
