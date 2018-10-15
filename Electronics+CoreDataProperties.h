//
//  Electronics+CoreDataProperties.h
//  iCart
//
//  Created by GlobalLogic on 07/03/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Electronics.h"

NS_ASSUME_NONNULL_BEGIN

@interface Electronics (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *image1;
@property (nullable, nonatomic, retain) NSString *details;

@end

NS_ASSUME_NONNULL_END
