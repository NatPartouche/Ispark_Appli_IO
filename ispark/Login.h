//
//  Login.h
//  ispark
//
//  Created by Natanel Partouche on 04/01/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *mail;
@property (retain, nonatomic) IBOutlet UITextField *motdepasse;
- (IBAction)login:(id)sender;
-(void)loginme;
@end
