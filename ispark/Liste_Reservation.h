//
//  Liste_Reservation.h
//  ispark
//
//  Created by ; Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Liste_Reservation : UITableViewController
{
    NSMutableArray *reservation;
    NSMutableArray *parking;
}
-(void)setreservation:(NSMutableArray*)res;
-(void)save;
-(NSMutableDictionary*)select_parking:(NSString*)pa;


@end

