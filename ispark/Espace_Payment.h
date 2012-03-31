//
//  Espace_Payment.h
//  ispark
//
//  Created by Natanel Partouche on 22/03/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Espace_Payment : UIViewController
{
    int temp;
 NSMutableDictionary *dico;
}
-(void)setdico:(NSMutableDictionary*)d;
-(void)settemp:(int)t;
-(void)chargerlareservation;

@end
