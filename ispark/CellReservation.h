//
//  CellReservation.h
//  ispark
//
//  Created by Natanel Partouche on 30/03/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellReservation : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *qrcode;
@property (retain, nonatomic) IBOutlet UILabel *ou;
@property (retain, nonatomic) IBOutlet UILabel *quelleheure;

@end
