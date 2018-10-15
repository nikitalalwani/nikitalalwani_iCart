//
//  FavoritesCollectionViewController.m
//  iCart
//
//  Created by Globallogic on 25/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "FavoritesCollectionViewController.h"
#import "FavoritesCell.h"

@interface FavoritesCollectionViewController ()

@end

@implementation FavoritesCollectionViewController

static NSString * const reuseIdentifier = @"favoriteCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.favoriteProductsArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FavoritesCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary* favoriteDictionary = [self.favoriteProductsArray objectAtIndex:indexPath.row];
    cell.favoriteProductName.text = [favoriteDictionary valueForKey:@"name"];
    cell.favoriteProductPrice.text = [favoriteDictionary valueForKey:@"price"];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[favoriteDictionary valueForKey:@"image"]]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            UIImage* img = [UIImage imageWithData:data];
            cell.favoriteImageView.image = img;
            
        }];
    }] resume];
    
    return cell;
}


@end
