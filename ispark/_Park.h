//
//  _Park.h
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _Park : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *park;
    NSMutableString *currentElement;
    NSMutableString *nbrplace;

    NSMutableDictionary *dico;
    NSXMLParser *rssparser;
    NSString *localhost;
}
@property(nonatomic,retain)  NSMutableArray *park;
-(void)parseXMLFileAtURL:(NSString *)URL;
-(void)loadpicturesNews;
-(void)load:(NSString*)arg;
@end
