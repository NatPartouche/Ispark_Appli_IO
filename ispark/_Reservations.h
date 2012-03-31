//
//  _Reservations.h
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface _Reservations : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentElement;
    NSMutableArray *reservation,*annuler;
    NSXMLParser *rssparser;
    NSMutableDictionary *dico;

}
-(void)setIDparking:(NSString *)idparking;
-(void)parseXMLFileAtURL:(NSString *)URL;
-(void)settemp:(NSString*)t;
-(BOOL)load_annuler_reservation:(NSString*)idr;
-(void)load:(NSString*)idp withtime:(NSString*)temps anduser:(NSString*)user;
-(void)loadQrcode;
-(void)save;

@end
