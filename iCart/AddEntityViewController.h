//
//  AddEntityViewController.h
//  iCart
//
//  Created by GlobalLogic on 08/03/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AddEntityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *imageField;
@property (weak, nonatomic) IBOutlet UITextField *image1Field;
@property (weak, nonatomic) IBOutlet UITextField *detailsField;
@property (weak, nonatomic) IBOutlet UITextField *categoriesField;
@property(strong,nonatomic) NSMutableDictionary* addEntityDictionary;
@property(strong,nonatomic)NSManagedObjectContext* managedObjectContext;
- (IBAction)Save:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@end



