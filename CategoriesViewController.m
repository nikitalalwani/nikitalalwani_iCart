//
//  CategoriesViewController.m
//  iCart
//
//  Created by Globallogic on 23/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoriesCell.h"
#import "Furniture+CoreDataProperties.h"
#import "Books+CoreDataProperties.h"
#import "Cart+CoreDataProperties.h"
#import "Electronics+CoreDataProperties.h"
#import "Shoes+CoreDataProperties.h"
#import "Apparels+CoreDataProperties.h"
#import "SingleProductViewController.h"
#import "MapViewController.h"
#import "CoreDataManager.h"
#import "ViewCartController.h"
#import "Electronics.h"
#import "AddEntityViewController.h"

@interface CategoriesViewController ()
@end
@implementation CategoriesViewController
@synthesize electronicsArray,furnitureArray,apparelsArray, booksArray,shoesArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"CATEGORIES";
    self.managedObjectContext = [[CoreDataManager sharedManager] managedObjectContext];
    //initializing all arrays
    electronicsArray = [[NSMutableArray alloc]init];
    furnitureArray = [[NSMutableArray alloc]init];
    apparelsArray = [[NSMutableArray alloc]init];
    shoesArray = [[NSMutableArray alloc]init];
    booksArray = [[NSMutableArray alloc]init];
    
    //add button on navigation bar
    UIBarButtonItem* add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEntityController)];
    
    self.navigationItem.rightBarButtonItem = add;
    
    //calling the appropriate save method depending on the category
    if (self.sentDict && self.sentString)
    {
        [self callAptMethod];
    }
}
-(void)callAptMethod
{
    if ([self.sentString isEqual: @"electronics"]||[self.sentString isEqual: @"Electronics"]) {
        [self saveElectronicsToCoreData];
    }
    if ([self.sentString isEqual: @"furniture"]||[self.sentString isEqual: @"Furniture"]) {
        [self saveFurnitureToCoreData];
    }
    if ([self.sentString isEqual: @"apparels"]||[self.sentString isEqual: @"Apparels"]) {
        [self saveApparelsToCoreData];
    }
    if ([self.sentString isEqual: @"shoes"]||[self.sentString isEqual: @"Shoes"]) {
        [self saveShoesToCoreData];
    }
    if ([self.sentString isEqual: @"books"]||[self.sentString isEqual: @"Books"]) {
        [self saveBooksToCoreData];
    }
    
}
#pragma core data methods
-(void)saveElectronicsToCoreData
{
    Electronics* electronics6 =[NSEntityDescription insertNewObjectForEntityForName:@"Electronics" inManagedObjectContext:self.managedObjectContext];
    electronics6.name= [self.sentDict valueForKey:@"name"];
    electronics6.image=[self.sentDict valueForKey:@"image"];
    electronics6.price=[self.sentDict valueForKey:@"price"];
    electronics6.image1 = [self.sentDict valueForKey:@"image1"];
    electronics6.details = [self.sentDict valueForKey:@"details"];
    NSError *error= nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"some Error %@",[error description]);
    }
    [electronicsArray addObject:electronics6];
}
-(void)saveFurnitureToCoreData
{
    //creating an entity and inserting it to MOC
    Furniture* furniture6 =[NSEntityDescription insertNewObjectForEntityForName:@"Furniture" inManagedObjectContext:self.managedObjectContext];
    furniture6.name= [self.sentDict valueForKey:@"name"];
    furniture6.image=[self.sentDict valueForKey:@"image"];
    furniture6.price=[self.sentDict valueForKey:@"price"];
    furniture6.image1 = [self.sentDict valueForKey:@"image1"];
    furniture6.details = [self.sentDict valueForKey:@"details"];
    NSError* error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@",[error description]);
    }
    [furnitureArray addObject:furniture6];
    
}
-(void)saveApparelsToCoreData
{
    
    Apparels* apparels6 =[NSEntityDescription insertNewObjectForEntityForName:@"Apparels" inManagedObjectContext:self.managedObjectContext];
    apparels6.name= [self.sentDict valueForKey:@"name"];
    apparels6.image=[self.sentDict valueForKey:@"image"];
    apparels6.price=[self.sentDict valueForKey:@"price"];
    apparels6.image1 = [self.sentDict valueForKey:@"image1"];
    apparels6.details = [self.sentDict valueForKey:@"details"];
    NSError* error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@",[error description]);
    }
    [apparelsArray addObject:apparels6];
}
-(void)saveShoesToCoreData
{
    Shoes* shoes6 =[NSEntityDescription insertNewObjectForEntityForName:@"Shoes" inManagedObjectContext:self.managedObjectContext];
    shoes6.name= [self.sentDict valueForKey:@"name"];
    shoes6.image=[self.sentDict valueForKey:@"image"];
    shoes6.price=[self.sentDict valueForKey:@"price"];
    shoes6.image1 = [self.sentDict valueForKey:@"image1"];
    shoes6.details = [self.sentDict valueForKey:@"details"];
    NSError* error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@",[error description]);
    }
    [shoesArray addObject:shoes6];
}
-(void)saveBooksToCoreData
{
    Books* books6 =[NSEntityDescription insertNewObjectForEntityForName:@"Books" inManagedObjectContext:self.managedObjectContext];
    books6.name= [self.sentDict valueForKey:@"name"];
    books6.image=[self.sentDict valueForKey:@"image"];
    books6.price=[self.sentDict valueForKey:@"price"];
    books6.image1 = [self.sentDict valueForKey:@"image1"];
    books6.details = [self.sentDict valueForKey:@"details"];
    NSError* error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@",[error description]);
    }
    [booksArray addObject:books6];
}
-(void)addEntityController
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddEntityViewController* AddEntityViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddEntityViewController"];
    [self.navigationController pushViewController:AddEntityViewController animated:YES];
}
#pragma tableview delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    CategoriesCell *cell = [self.categoriesTableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[CategoriesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.nameOfProduct.layer.masksToBounds = YES;
    cell.nameOfProduct.layer.cornerRadius = 20.0;
    if (indexPath.section ==0) {
        cell.nameOfProduct.text = @"Electronics";
    }
    if (indexPath.section ==1) {
        cell.nameOfProduct.text = @"Furniture";
    }
    if (indexPath.section ==2) {
        cell.nameOfProduct.text = @"Apparels";
    }
    if (indexPath.section ==3) {
        cell.nameOfProduct.text = @"Shoes";
    }
    if (indexPath.section ==4) {
        cell.nameOfProduct.text = @"Books";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    if (indexPath.section ==0) {
        
        SingleProductViewController* SingleProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleProductViewController"];
        SingleProductViewController.singleProductArray = electronicsArray;
        SingleProductViewController.sentString = @"Electronics";
        [self.navigationController pushViewController:SingleProductViewController animated:YES];
        
    }
    if (indexPath.section ==1) {
        
        SingleProductViewController* SingleProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleProductViewController"];
        SingleProductViewController.singleProductArray = furnitureArray ;
        SingleProductViewController.sentString = @"Furniture";
        [self.navigationController pushViewController:SingleProductViewController animated:YES];
    }
    if (indexPath.section ==2) {
        
        
        SingleProductViewController* SingleProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleProductViewController"];
        SingleProductViewController.singleProductArray = apparelsArray ;
        SingleProductViewController.sentString = @"Apparels";
        [self.navigationController pushViewController:SingleProductViewController animated:YES];
    }
    if (indexPath.section ==3) {
        SingleProductViewController* SingleProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleProductViewController"];
        SingleProductViewController.singleProductArray = shoesArray ;
        SingleProductViewController.sentString = @"Shoes";
        [self.navigationController pushViewController:SingleProductViewController animated:YES];
    }
    if (indexPath.section ==4) {
        SingleProductViewController* SingleProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleProductViewController"];
        SingleProductViewController.singleProductArray = booksArray;
        SingleProductViewController.sentString = @"Books";
        [self.navigationController pushViewController:SingleProductViewController animated:YES];
    }
}
- (IBAction)localStoresButtonTapped:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MapViewController* MapViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self.navigationController pushViewController:MapViewController animated:YES];
}
- (IBAction)viewCartButtonTapped:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewCartController *ViewCartController = [storyboard instantiateViewControllerWithIdentifier:@"ViewCartController"];
    [self.navigationController pushViewController:ViewCartController animated:YES];
    [ViewCartController setManagedObjectContext:[self managedObjectContext]];
}


@end
