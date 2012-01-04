//
//  _Utillisateur.h
//  ispark
//
//  Created by Natanel Partouche on 04/01/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _Utillisateur : NSObject<NSXMLParserDelegate>
{
    NSString * current_idutilisateur;
    NSString * current_value;
    NSXMLParser *rssparser;
    NSMutableString *currentElement;
    NSMutableDictionary *dico_user;
    int isuser;
}

-(void)parseXMLFileAtURL:(NSString *)URL;
-(void)load:(NSString*)mail and:(NSString*)mdp;
-(void)save;
-(NSMutableDictionary*)charge;
-(int)isuser;

@end
