//
//  Login.m
//  ispark
//
//  Created by Natanel Partouche on 04/01/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "Login.h"

@implementation Login
@synthesize mail;
@synthesize motdepasse;
@synthesize login;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
#include "_Utillisateur.h"
- (IBAction)login:(id)sender {
    
    [self performSelectorInBackground:@selector(login) withObject:nil];
}

-(void)login
{
    _Utillisateur *u=[[_Utillisateur alloc]init];
    [u load:mail.text and:motdepasse.text];
    [u save];
    
}
- (void)viewDidUnload
{
    [self setMail:nil];
    [self setMotdepasse:nil];
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
    [mail release];
    [motdepasse release];
    [super dealloc];
}
@end
