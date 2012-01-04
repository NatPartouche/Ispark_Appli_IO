//
//  Liste_Reservation.m
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "Liste_Reservation.h"
#import "Info_Reservation.h"


@implementation Liste_Reservation

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
          reservation=[[NSMutableArray alloc]init];
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight=67;
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#include "_Park.h"
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title=@"Reservations";

    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    reservation=[pref objectForKey:@"Reservations"];
    
    _Park *p=[[_Park alloc]init];
    [p load:@"all"];
    parking=p.park;
    NSLog(@"%d - %d",[reservation count],[parking count]);
   
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)setreservation:(NSMutableArray*)res
{
    reservation=res;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [reservation count];
}

#import "CellReservation.h"
#import "_Park.h"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellReservation";
    
    CellReservation *cell =(CellReservation*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        
        NSArray *to=[[NSBundle mainBundle]loadNibNamed:@"CellReservation" owner:nil options:nil ];
        for (id currentobject in to) {
            
            if ([currentobject isKindOfClass:[UITableViewCell class]]) {
                cell=(CellReservation*)currentobject;
                break;
            }
        }
        
    }  
    
    NSMutableDictionary *temp=[reservation objectAtIndex:[indexPath row]];
    NSMutableDictionary *tempparking=[self select_parking:[temp objectForKey:@"idParking"]];
    
    cell.qrcode.image=[UIImage imageWithData:[temp objectForKey:@"Qrcode"]];
    cell.ou.text=[NSString stringWithFormat:@"Place réservé à %@",[tempparking objectForKey:@"nomparking"]];
    cell.quelleheure.text=[NSString stringWithFormat:@"Arrivé dans : %@",[temp objectForKey:@"datedebut"]];
    return cell;
}



-(NSMutableDictionary*)select_parking:(NSString*)pa
{
    NSLog(@"%@",pa);
    
    for (int i=0;i<[parking count];i++)
    {
       
        if ([[[parking objectAtIndex:i]objectForKey:@"idparking"]isEqualToString:pa])
    {
        return [parking objectAtIndex:i];
    }
        
    }
    return NULL;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


-(void)save
{
    NSLog(@"save"); 
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref setObject:reservation forKey:@"Reservations"];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *temp=[reservation objectAtIndex:[indexPath row]];
    Info_Reservation *info_res=[[Info_Reservation alloc]init];
    [info_res setdico:temp];
    [self.navigationController pushViewController:info_res animated:YES];
    
}

@end
