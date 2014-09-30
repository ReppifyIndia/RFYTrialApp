//
//  RFYMasterViewController.m
//  RfyTrialApp
//
//  Created by Maneesh Raswan on 9/10/14.
//  Copyright (c) 2014 Maneesh Raswan. All rights reserved.
//

#import "RFYMasterViewController.h"

#import "RFYDetailViewController.h"
#import "HUD.h"
#import "Contact.h"
#import "JSONModelLib.h"

#import "RFYCustomSegue.h"
#import "RFYCustomUnwindSegue.h"

@interface RFYMasterViewController () {
    NSMutableArray *_objects;
    
    NSMutableArray* _contacts;
}
@end

@implementation RFYMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}


-(void)viewDidAppear:(BOOL)animated
{
    //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Fetching Contacts"];
        
    [JSONHTTPClient getJSONFromURLWithString:@"http://localhost:3000/api/contacts.json"
              completion:^(NSArray *json, JSONModelError *err) {
                
                  _contacts = json.mutableCopy;
                  
                  //hide the loader view
                  [HUD hideUIBlockingIndicator];
                  //json fetched
                  NSLog(@"Contacts: %@", _contacts);
                  
                [self.tableView reloadData];
                  
              }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)loadContactsFromServer
{
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *contact = _contacts[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [contact objectForKey:@"name"];
                           ;
    cell.detailTextLabel.text = [contact objectForKey:@"phone"];

    //NSDate *object = _objects[indexPath.row];
    //cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_contacts removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *contact = _contacts[indexPath.row];
        // pass the id of the resource to detail controller
        [[segue destinationViewController] setDetailItem:[contact objectForKey:@"id"]];
    }*/
    
    if([segue isKindOfClass:[RFYCustomSegue class]]) {
        // Set the start point for the animation to center of the button for the animation
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *contact = _contacts[indexPath.row];
        // pass the id of the resource to detail controller
        [[segue destinationViewController] setDetailItem:[contact objectForKey:@"id"]];

        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

        ((RFYCustomSegue *)segue).originatingPoint = cell.center;
    }
    
}


- (IBAction)unwindFromViewController:(UIStoryboardSegue *)sender {
}


// We need to over-ride this method from UIViewController to provide a custom segue for unwinding
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    // Instantiate a new CustomUnwindSegue
    RFYCustomUnwindSegue *segue = [[RFYCustomUnwindSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    // Set the target point for the animation to the center of the button in this VC
    segue.targetPoint = self.tableView.center;
    return segue;
}
@end
