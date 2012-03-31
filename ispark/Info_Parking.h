//
//  Info_Parking.h
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Info_Parking : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,NSXMLParserDelegate>
{
    NSTimer * timer;
    BOOL timeron;
    NSXMLParser *rssparser;
    NSMutableArray *dicoarray;
    NSMutableString *currentElement;
    int current_temps;
    NSMutableArray *tab_temp_reservation;
    IBOutlet UITextView *current_nbr;
    IBOutlet UITextView *textview;
    NSMutableDictionary *dico;
    NSMutableDictionary *dicotemp;

    IBOutlet UILabel *Nom;
    IBOutlet UILabel *Adresse;
    IBOutlet UIButton *Telephone;
    IBOutlet UIPickerView *picker_temp_reservation;
    IBOutlet UIImageView *logoimage;
    
}
-(void)get_place;

-(void)parseXMLFileAtURL:(NSString *)URL;
-(void)methode_get_place;
- (IBAction)reservation:(id)sender;
- (IBAction)Appeller_Telephone:(id)sender;
-(void)setparkingdico:(NSMutableDictionary*)d;
@end
