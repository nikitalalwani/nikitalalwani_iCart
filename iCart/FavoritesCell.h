//
//  FavoritesCell.h
//  iCart
//
//  Created by Globallogic on 25/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *favoriteProductName;
@property (weak, nonatomic) IBOutlet UILabel *favoriteProductPrice;

@end
