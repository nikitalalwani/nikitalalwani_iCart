//
//  PhotoViewController.h
//  iCart
//
//  Created by Globallogic on 24/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong,nonatomic)NSString* imageString;
@property(strong,nonatomic)NSString* productString;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@end
