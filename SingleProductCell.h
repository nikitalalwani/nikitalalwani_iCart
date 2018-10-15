//
//  SingleProductCell.h
//  iCart
//
//  Created by Globallogic on 23/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *singleProductImage;
@property (weak, nonatomic) IBOutlet UILabel *singleProductName;
@property (weak, nonatomic) IBOutlet UILabel *singleProductPrice;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


@end
