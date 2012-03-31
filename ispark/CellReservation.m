//
//  CellReservation.m
//  ispark
//
//  Created by Natanel Partouche on 30/03/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "CellReservation.h"

@implementation CellReservation
@synthesize qrcode;
@synthesize ou;
@synthesize quelleheure;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [qrcode release];
    [ou release];
    [quelleheure release];
    [super dealloc];
}
@end
