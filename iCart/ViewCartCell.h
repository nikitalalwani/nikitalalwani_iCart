//
//  ViewCartCell.h
//  iCart
//
//  Created by Globallogic on 24/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cartCellName;
@property (weak, nonatomic) IBOutlet UIImageView *cartCellImage;
@property (weak, nonatomic) IBOutlet UILabel *cartCellPrice;

@end
