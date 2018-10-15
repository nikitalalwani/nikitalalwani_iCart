//
//  SingleProductViewController.h
//  iCart
//
//  Created by Globallogic on 23/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface SingleProductViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSMutableArray* singleProductArray;
@property (weak, nonatomic) IBOutlet UITableView *singleProductTableView;
@property(strong,nonatomic)NSManagedObjectContext* managedObjectContext;
@property(strong,nonatomic)NSMutableArray* cartArray1;
@property(strong,nonatomic)NSMutableArray* favoritesArray;
@property (strong, nonatomic)UILabel *badge;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (strong, nonatomic)NSString *sentString;



- (IBAction)viewCartButtonTapped:(id)sender;
-(IBAction)favoriteButtonTapped:(id)sender;
- (IBAction)fbButtonTapped:(id)sender;
- (IBAction)viewFavoritesButton:(id)sender;
- (IBAction)addToCartTapped:(id)sender;
- (IBAction)cartTapped:(id)sender;

@end
