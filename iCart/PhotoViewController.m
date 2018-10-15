//
//  PhotoViewController.m
//  iCart
//
//  Created by Globallogic on 24/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.productLabel.text = self.productString;
    NSURL* url = [NSURL URLWithString:self.imageString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadPhotoTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        // 3
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = downloadedImage;
            
            
        });
    }];
    [downloadPhotoTask resume];
}


@end
