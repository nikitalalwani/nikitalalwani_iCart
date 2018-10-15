//
//  ViewCartController.h
//  iCart
//
//  Created by Globallogic on 24/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCartController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *viewCartTableView;
@property(strong,nonatomic)NSMutableArray* viewCartArray;
@property(strong,nonatomic)NSManagedObjectContext* managedObjectContext;



 @end
