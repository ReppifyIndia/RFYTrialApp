//
//  RFYDetailViewController.h
//  RfyTrialApp
//
//  Created by Maneesh Raswan on 9/10/14.
//  Copyright (c) 2014 Maneesh Raswan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFYDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdDtTmLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedDtTmLabel;

@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UIButton *btnReject;


- (IBAction)btnClick:(id)sender;

@end
