//
//  AppDelegate.h
//  InsituDemo
//
//  Created by smart_parking on 9/20/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
-(NSManagedObjectModel *)managedObjectModel;
-(NSManagedObjectContext *)managedObjectContext;
@end
