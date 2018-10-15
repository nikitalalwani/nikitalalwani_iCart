//
//  FavoritesCollectionViewController.h
//  iCart
//
//  Created by Globallogic on 25/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesCollectionViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong,nonatomic)NSMutableArray*favoriteProductsArray;

@end
