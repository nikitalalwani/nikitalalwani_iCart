//
//  SingleProductViewController.m
//  iCart
//
//  Created by Globallogic on 23/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "SingleProductViewController.h"
#import "SingleProductCell.h"
#import "CategoriesViewController.h"
#import "Cart+CoreDataProperties.h"
#import "CoreDataManager.h"
#import "ViewCartController.h"
#import "Cart.h"
#import <CoreData/CoreData.h>
#import <CoreData/NSPersistentStoreRequest.h>
#import "AppDelegate.h"
#import "PhotoViewController.h"
#import "FavoritesCollectionViewController.h"
#import "AddEntityViewController.h"

@interface SingleProductViewController ()<NSFetchedResultsControllerDelegate>
@property(strong,nonatomic)NSFetchedResultsController* fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *productResultsController;
@end

@implementation SingleProductViewController
@synthesize badge,managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    //initializing the arrays
    self.cartArray1 = [[NSMutableArray alloc]init];
    self.favoritesArray = [[NSMutableArray alloc]init];
    
    //fetching the cart entity from core data to save products that are added to cart
    self.managedObjectContext = [[CoreDataManager sharedManager] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Cart"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    // Perform Fetch
    NSError *error = nil;
    
    self.cartArray1 = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    //set the count of cart array to badge label
    badge = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 20, 20)];
    [badge setText:[NSString stringWithFormat:@"%d",(int)[[[self fetchedResultsController] fetchedObjects] count]]];
    badge.textColor = [UIColor blackColor];
    [self.cartButton addSubview:badge];
    [self fetchedResultsControllerselection1];
}
-(void)fetchedResultsControllerselection1
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *subItemEntity = [NSEntityDescription entityForName:self.sentString inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:subItemEntity];
    //add sort descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    //initialize fetchedresultscontroller
    self.productResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    //configure fetched results controller
    [self.productResultsController setDelegate:self];
    //perform Fetch
    NSError *error = nil;
    [self.productResultsController performFetch:&error];
    if (error) {
        NSLog(@"Unable to perform fetch");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}


#pragma tableview delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.productResultsController sections]count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =
    [[self.productResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell1";
    
    SingleProductCell* cell = [self.singleProductTableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[SingleProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [cell.fbButton setTag:indexPath.row];
    [cell.addToCartButton setTag:indexPath.row];
    [cell.favoriteButton setTag:indexPath.row];
    NSDictionary* dictionaryInArray = [self.productResultsController  objectAtIndexPath:indexPath];
    cell.singleProductName.text = [dictionaryInArray  valueForKey:@"name"];
    cell.singleProductPrice.text = [dictionaryInArray valueForKey:@"price"];
    NSURL* url = [NSURL URLWithString:[dictionaryInArray valueForKey:@"image"]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadPhotoTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        // 3
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.singleProductImage.image = downloadedImage;
            [self.singleProductTableView reloadData];
        });
    }];
    [downloadPhotoTask resume];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PhotoViewController *PhotoViewController = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
NSIndexPath* index = [self.productResultsController objectAtIndexPath:indexPath];
    PhotoViewController.imageString = [index valueForKey:@"image1"];
    PhotoViewController.productString = [index valueForKey:@"details"];
    [self.navigationController pushViewController:PhotoViewController animated:YES];
}

//add to cart button on cell tapped
- (IBAction)addToCartTapped:(id)sender {
    
    UIImage* imageForRemoveCart = [UIImage imageNamed:@"removefromcart"];
    [sender setBackgroundImage:imageForRemoveCart forState:UIControlStateNormal];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    NSDictionary* obj = [self.productResultsController objectAtIndexPath:indexPath];
    [self.cartArray1 addObject:obj];
    [self reloadBadgeNumber];
    [sender setEnabled:NO];
    
}


//button to share products on facebook
- (IBAction)fbButtonTapped:(id)sender {
    
    SLComposeViewController *sendData = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
NSDictionary *dict = [self.productResultsController objectAtIndexPath:indexPath]  ;
    [sendData addURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [dict valueForKey:@"image"]]]];
    [sendData setInitialText:[NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]]];
    [self presentViewController:sendData animated:YES completion:nil];
}

//favorites button
- (IBAction)favoriteButtonTapped:(id)sender {
    
    UIImage* checkImage = [UIImage imageNamed:@"stargold.png"];
    [sender setBackgroundImage:checkImage forState:UIControlStateNormal];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    NSDictionary *obj = [self.productResultsController objectAtIndexPath:indexPath];
    [self.favoritesArray addObject:obj];
    
}
//method to update badge label each time a product is added or removed
- (void)reloadBadgeNumber {
    
    if( self.cartArray1.count) {
        [badge setText:[ NSString stringWithFormat:@"%d",(int)self.cartArray1.count]];
    }
    else
    {
        [badge setText:@"0"];
        
    }
    [self saveCartToCoreData];
}
//saving the changes to core data
-(void)saveCartToCoreData
{
    self.managedObjectContext = [[CoreDataManager sharedManager] managedObjectContext];
    Cart*  cart = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:self.managedObjectContext];
    for (NSDictionary* dictionary in self.cartArray1)
    {
        self.managedObjectContext = [[CoreDataManager sharedManager] managedObjectContext];
            cart.name = [dictionary valueForKey:@"name"];
            cart.price= [dictionary valueForKey:@"price"];
            cart.image = [dictionary valueForKey:@"image"];
            NSError *error = nil;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"save error = %@",[error description]);
            
        }
    }
}

//view cart button on bottom tapped

- (IBAction)viewCartButtonTapped:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewCartController *ViewCartController = [storyboard instantiateViewControllerWithIdentifier:@"ViewCartController"];
    [self.navigationController pushViewController:ViewCartController animated:YES];
    
}

//view favorites button on bottom tapped
- (IBAction)viewFavoritesButton:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FavoritesCollectionViewController *FavoritesCollectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"FavoritesCollectionViewController"];
    FavoritesCollectionViewController.favoriteProductsArray = self.favoritesArray;
    [self.navigationController pushViewController:FavoritesCollectionViewController animated:YES];
}

//cart button on bottom tapped..It removes the entries from cart
- (IBAction)cartTapped:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    [self.cartArray1 removeObjectAtIndex:0];
    [self reloadBadgeNumber];
    [sender setTag:indexPath.row];
    [sender setEnabled:YES];
    
}




@end
