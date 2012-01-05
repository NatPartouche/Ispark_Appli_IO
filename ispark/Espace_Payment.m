//
//  Espace_Payment.m
//  ispark
//
//  Created by Natanel Partouche on 22/03/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "Espace_Payment.h"

@implementation Espace_Payment

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
-(void)settemp:(int)t
{
    temp=t;
}
-(void)setdico:(NSMutableDictionary*)d{
    dico=d;
}
- (IBAction)payer:(id)sender {
    
    [self chargerlareservation];
}
#include "_Reservations.h"
#include "_Utillisateur.h"
-(void)chargerlareservation
{
    
    _Utillisateur *u=[[_Utillisateur alloc]init];
    NSMutableDictionary *tempo=[u charge];
    NSLog(@"%@",[tempo description]);
    _Reservations *res=[[_Reservations alloc]init];
    [res load:[dico objectForKey:@"idparking"] withtime:[NSString stringWithFormat:@"%d",temp] anduser:[NSString stringWithFormat:[tempo objectForKey:@"idutilisateur"]]];
        if ([res isok]==1)
    {
        self.tabBarController.selectedIndex=1;
        [res loadQrcode];
        [res save];
    }
    else
    {   
        NSString *title=[NSString stringWithString:@"Reservation Impossible"];
        NSString *message=[NSString stringWithFormat:@"La zone VIP du parking de %@ est momentanement indisponible, Reservez votre place dans un autre parking... A très bientôt!"];
        UIAlertView *a=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [a show];
        [a release];
        [self.navigationController popViewControllerAnimated:YES];
    }
    }
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"temp : %d",temp);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
}
@end
