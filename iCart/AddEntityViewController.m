//
//  AddEntityViewController.m
//  iCart
//
//  Created by GlobalLogic on 08/03/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "AddEntityViewController.h"
#import "SingleProductViewController.h"
#import "CategoriesViewController.h"
#import "CoreDataManager.h"
@interface AddEntityViewController ()<NSFetchedResultsControllerDelegate>
@property(strong,nonatomic)NSFetchedResultsController* fetchedResultsController;
@end
@implementation AddEntityViewController
@synthesize addEntityDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.saveButton.layer.cornerRadius = 10;
}
- (IBAction)Save:(id)sender {
    addEntityDictionary = [[NSMutableDictionary alloc]init];
    [addEntityDictionary setObject:self.nameField.text forKey:@"name"];
    [addEntityDictionary setObject:self.priceField.text forKey:@"price"];
    [addEntityDictionary setObject:self.imageField.text forKey:@"image"];
    [addEntityDictionary setObject:self.image1Field.text forKey:@"image1"];
    [addEntityDictionary setObject:self.detailsField.text forKey:@"details"];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CategoriesViewController *CategoriesViewController = [storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
    CategoriesViewController.sentDict = addEntityDictionary;
    CategoriesViewController.sentString = self.categoriesField.text;
    [self.navigationController pushViewController:CategoriesViewController animated:YES];
    
}
@end
