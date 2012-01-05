//
//  Info_Reservation.h
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Info_Reservation : UIViewController
{
    NSMutableDictionary *dico;
    IBOutlet UIImageView *Qrcode;
    
    IBOutlet UILabel *code;
    IBOutlet UILabel *prix;
}
- (IBAction)annuler:(id)sender;
-(void)setdico:(NSMutableDictionary*)d;
@end
