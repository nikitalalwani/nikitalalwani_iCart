//
//  ViewCartController.m
//  iCart
//
//  Created by Globallogic on 24/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "ViewCartController.h"
#import "ViewCartCell.h"
#import "Cart+CoreDataProperties.h"
#import "Cart.h"
#import "SingleProductViewController.h"
#import "CoreDataManager.h"

@interface ViewCartController ()<NSFetchedResultsControllerDelegate>
@property(strong,nonatomic)NSFetchedResultsController*fetchedResultsController;

@end

@implementation ViewCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewCartTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.managedObjectContext = [[CoreDataManager sharedManager] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Cart"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    [self setEditing:YES animated:YES];
    
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    self.viewCartTableView.allowsMultipleSelectionDuringEditing = editing;
    [super setEditing:editing animated:animated];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionInfo = [self.fetchedResultsController fetchedObjects];
    return [sectionInfo count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell2";
    
    ViewCartCell *cell = [self.viewCartTableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[ViewCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    
    Cart *cart = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.cartCellName.text = cart.name;
    cell.cartCellPrice.text = cart.price;
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",cart.image]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadPhotoTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        // 3
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.cartCellImage.image = downloadedImage;
            [self.viewCartTableView reloadData];
            
        });
    }];
    [downloadPhotoTask resume];
    
    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:managedObject];
        [self.managedObjectContext save:nil];
        //[self.viewCartTableView beginUpdates];
        [self.viewCartTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        //[self.viewCartTableView endUpdates];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.viewCartTableView reloadData];
        });
    }
    [self.viewCartTableView reloadData];
    
}






@end
