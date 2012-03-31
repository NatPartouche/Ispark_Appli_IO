//
//  Info_Reservation.m
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "Info_Reservation.h"

@implementation Info_Reservation

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
#import "_Reservations.h"
- (IBAction)annuler:(id)sender {
    
    
    _Reservations *res=[[_Reservations alloc]init];
    
    if ([res load_annuler_reservation:[dico objectForKey:@"idreservation"]])
    {
        NSLog(@"idreservation = %@",[dico objectForKey:@"idreservation"]);
        NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
        NSMutableArray *reservation=[pref objectForKey:@"Reservations"];
        for (int i=0; i<[reservation count]; i++) {
            
             
            
            NSDictionary *temp=[reservation objectAtIndex:i];
                    
        if ([[temp objectForKey:@"idreservation"] isEqualToString:[dico objectForKey:@"idreservation"]])
        {
            [reservation removeObjectAtIndex:i];
            UIAlertView *a=[[UIAlertView alloc]init];
            [a show];
        }
        
        }
        
        //[pref setObject:reservation forKey:@"reservation"];
        NSLog(@"save reservation");   
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    

}

-(void)setdico:(NSMutableDictionary*)d
{
    dico=d;
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
  //  NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/API_ISPARK/Reservations/%@",[dico ]]];
 //   Qrcode=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    Qrcode.image=[UIImage imageWithData:[dico objectForKey:@"Qrcode" ]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [Qrcode release];
    Qrcode = nil;
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
    [Qrcode release];
    [super dealloc];
}
@end
