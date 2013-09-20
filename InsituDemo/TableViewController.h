//
//  TableViewController.h
//  InsituDemo
//
//  Created by smart_parking on 9/20/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface TableViewController : UITableViewController{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *resultArray;

}
@property (weak,nonatomic) AppDelegate *myDelegate;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,copy)NSMutableArray *resultArray;
@end
