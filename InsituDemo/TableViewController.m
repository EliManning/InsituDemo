//
//  TableViewController.m
//  InsituDemo
//
//  Created by smart_parking on 9/20/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import <CoreData/CoreData.h>
#import "Entity.h"
#import "AppDelegate.h"
@interface TableViewController ()

@end

@implementation TableViewController
@synthesize managedObjectContext ;
@synthesize resultArray;

#pragma mark init

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(![self coreDataHasEntriesForEntityName:@"Event"]){
    NSLog(@"Request API. Save to CoreData.");
    [self requestApi];
     
    }
    else{
        NSLog(@"Data already exist");
    }
    [self fetchCoreData];
    //[self deleteData];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark httprequest

- (void)requestApi{
    
    NSString *strURL =@"http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=eric0715";
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    NSError* errorInfo;
    
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:dataURL options:kNilOptions error:&errorInfo];
    
    NSArray *data = [parsedJSON objectForKey:@"geonames"];
    
    for(int i=0;i<[data count];i++){
        NSDictionary *cityInfo= [data objectAtIndex:i];
        NSString *name = [cityInfo objectForKey:@"toponymName"];
        //        NSLog(@"City Name: %@", name);
        NSString *population = [[cityInfo objectForKey:@"population"] description];
        //        NSLog(@"population: %@", population);
        NSString *wiki_url = [cityInfo objectForKey:@"wikipedia"];
        //        NSLog(@"Wikipedia url: %@", wiki_url);
        
        [self writeToCoreData:name population:population wiki_url:wiki_url];
        
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Entity *event = (Entity *)[resultArray objectAtIndex:indexPath.row];
   
    cell.textLabel.text  = event.name;
    cell.detailTextLabel.text = event.populate;// Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Entity *event = [resultArray objectAtIndex:indexPath.row];
    NSLog(@" Wikipedia: %@", event.url);
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailBoard" ];
    [detailView setWiki_url:event.url];
    [self.navigationController pushViewController:detailView animated:YES];
    
}

#pragma mark - CoreData
-(void)writeToCoreData: (NSString *)name population:(NSString *)population wiki_url:(NSString *)wiki_url {
    Entity *entity = (Entity *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.myDelegate.managedObjectContext];
    
    [entity setName:name];
    [entity setPopulate:population];
    [entity setUrl:wiki_url];
    NSError *error;
    
    BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
    
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful!");
    }
}

-(void)fetchCoreData{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.myDelegate.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    resultArray= [[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (resultArray == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }

    [self.tableView reloadData];
   
}
-(void)deleteData{
    
    if ([resultArray count]==0 || resultArray ==nil) {
        return;
    }
        
    for (int i=0; i< [resultArray count]-1;i++){
    NSManagedObject *eventToDelete = [resultArray objectAtIndex:i];
    [self.myDelegate.managedObjectContext deleteObject:eventToDelete];
    [resultArray removeObjectAtIndex:i];
    }
    NSError *error;
    if (![self.myDelegate.managedObjectContext  save:&error]) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }
    else{
        NSLog(@"Delete success");
    }
}
//Check if there is entity in the database
- (BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName {
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.myDelegate.managedObjectContext];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [self.myDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Fetch error: %@", error);
    }
    if ([results count] == 0) {
        return NO;
    }
    return YES;
}


@end
