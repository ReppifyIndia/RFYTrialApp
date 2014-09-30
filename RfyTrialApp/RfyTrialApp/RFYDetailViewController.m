//
//  RFYDetailViewController.m
//  RfyTrialApp
//
//  Created by Maneesh Raswan on 9/10/14.
//  Copyright (c) 2014 Maneesh Raswan. All rights reserved.
//

#import "RFYDetailViewController.h"
#import "HUD.h"
#import "JSONModelLib.h"
#import "Contact.h"

@interface RFYDetailViewController ()
    {
        Contact* _contact;
    }
    - (void)configureView;
@end

@implementation RFYDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
        NSString *contactURL = [NSString stringWithFormat:@"http://localhost:3000/api/contacts/%@.json",
                [self.detailItem description]];
        
        NSLog(@"URL: %@", contactURL);

        
        //show loader view
        [HUD showUIBlockingIndicatorWithText:@"Fetching Contact Details"];
        
        //fetch the feed
        [JSONHTTPClient getJSONFromURLWithString:contactURL                                               completion:^(NSDictionary *json, JSONModelError *err) {
                 
                //hide the loader view
                 [HUD hideUIBlockingIndicator];
            
                 _contact = [[Contact alloc]initWithDictionary:json error:nil];
                 
                 //json fetched
                 NSLog(@"contact Info: %@", _contact);
                 
                 self.nameLabel.text = _contact.name;
                 self.phoneLabel.text = _contact.phone;
                 self.createdDtTmLabel.text = _contact.created_at;
                 self.updatedDtTmLabel.text = _contact.updated_at;
             }];
        
        
        self.detailDescriptionLabel.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSLog(@"Btn Clicked: %p, %@", sender, [[button titleLabel] text] );
    if([[[button titleLabel] text ] isEqualToString:@"Up"]) {
        [self pyramid];
    } else if ([[[button titleLabel] text ] isEqualToString:@"Down"]) {
        [self reversePyramid];
    }
}


- (void)pyramid
{
    NSMutableString* theTotalString = [NSMutableString string];
    for (int row=0; row<10; row++) {
    
        NSMutableString* theRowString = [NSMutableString string];
        for (int col=0; col < (row*2)+1; col++) {
            // NSString to ASCII
            NSString *string = @"A";
            int asciiCode = [string characterAtIndex:0]; // 65
            
            // ASCII to NSString
            // int asciiCode = 65;
            //NSString *str = [NSString stringWithFormat:@"%c", asciiCode]; // A
            [theRowString appendString:[NSString stringWithFormat:@"%c",asciiCode+col]];
        }
        [theTotalString appendString: [NSString stringWithFormat:@"%@\n",theRowString]];
        self.detailDescriptionLabel.text = theTotalString;
        //[NSThread sleepForTimeInterval:0.06f];
    }
}

- (void)reversePyramid
{
    NSMutableString* theTotalString = [NSMutableString string];
    for (int row=9; row>=0; row--) {
        
        NSMutableString* theRowString = [NSMutableString string];
        for (int col=0; col < (row*2)+1; col++) {
            // NSString to ASCII
            NSString *string = @"A";
            int asciiCode = [string characterAtIndex:0]; // 65
            
            // ASCII to NSString
            // int asciiCode = 65;
            //NSString *str = [NSString stringWithFormat:@"%c", asciiCode]; // A
            [theRowString appendString:[NSString stringWithFormat:@"%c",asciiCode+col]];
        }
        [theTotalString appendString: [NSString stringWithFormat:@"%@\n",theRowString]];
        self.detailDescriptionLabel.text = theTotalString;
        //[NSThread sleepForTimeInterval:0.06f];
    }
}
@end
