//
//  Contact.h
//  RfyTrialApp
//
//  Created by Maneesh Raswan on 9/10/14.
//  Copyright (c) 2014 Maneesh Raswan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol Contact @end

@interface Contact : JSONModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* created_at;
@property (strong, nonatomic) NSString* updated_at;

@end
