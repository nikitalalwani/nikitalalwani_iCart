//
//  CategoriesViewController.h
//  iCart
//
//  Created by Globallogic on 23/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEntityViewController.h"
#import "CoreDataManager.h"

@interface CategoriesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property(strong,nonatomic)NSManagedObjectContext* managedObjectContext;

@property (weak, nonatomic) IBOutlet UIButton *localStoresButton;
- (IBAction)localStoresButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *viewCartButton;
-(IBAction)viewCartButtonTapped:(id)sender;

@property(strong,nonatomic)NSMutableDictionary* sentDict;
@property(strong,nonatomic)NSDictionary* testDict;
@property(strong,nonatomic)NSString* sentString;
@property(retain,nonatomic) NSMutableArray* electronicsArray;
@property(strong,nonatomic)   NSMutableArray* shoesArray;
@property(strong,nonatomic)    NSMutableArray* furnitureArray;
@property(strong,nonatomic)  NSMutableArray* apparelsArray;
@property(strong,nonatomic)  NSMutableArray* booksArray;








@end
