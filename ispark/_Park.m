//
//  _Park.m
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "_Park.h"
@implementation _Park
@synthesize park;
-(id)init_Park
{
if ([super init])
{
    park=[[NSMutableArray alloc]init];
    currentElement=[[NSMutableString alloc]init];
    localhost=[NSString stringWithString:@"http://natanelpartouche.com/API_ISPARK"];

}
    return self;
}

-(void)load:(NSString*)arg
{
  
    park=[[NSMutableArray alloc]init];
    localhost=[NSString stringWithString:@"http://natanelpartouche.com/API_ISPARK"];

    NSString *racine=[NSString stringWithFormat:@"%@/API_ISPARK/Action/ActionPark.php?Action=",localhost,arg];
    NSLog(@"racine : %@%@",racine,arg);
    [self parseXMLFileAtURL:[NSString stringWithFormat:@"%@%@",racine,arg]];
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref setObject:park forKey:@"park"];
    [localhost release];
    [racine release];
}

-(void)parseXMLFileAtURL:(NSString *)URL
{
	NSURL *xmlurl=[NSURL URLWithString:URL];
    
	rssparser=[[NSXMLParser alloc]initWithContentsOfURL:xmlurl];
	[rssparser setDelegate:self];
    [rssparser parse];
    
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement=[elementName copy];

    if ([currentElement isEqualToString:@"Parking"]) {        
        dico=[[NSMutableDictionary alloc]initWithDictionary:attributeDict];

}
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{	
    
    currentElement=[elementName copy];
    if ([currentElement isEqualToString:@"Parking"]) {
        [park addObject:dico];
    }

}


-(void)loadpicturesNews
{
    
    localhost=[NSString stringWithString:@"http://natanelpartouche.com/API_ISPARK"];

    NSString *racine=[NSString stringWithFormat:@"%@/API_ISPARK/images/",localhost];
    NSMutableArray *tempoarray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[park count]; i++) {
        NSMutableDictionary *tempdico=[[NSMutableDictionary alloc]init];
        tempdico=[park objectAtIndex:i];
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",racine,[dico objectForKey:@"logo"]]];
        
        NSLog(@"%@",url);

        NSMutableData *data=[NSData dataWithContentsOfURL:url];
        [tempdico setObject:data forKey:@"logo_image"];
        [tempoarray addObject:tempdico];
    }
    
    [park removeAllObjects];
    [park setArray:tempoarray];
    
}


#pragma mark - Application's Documents directory

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    NSLog(@"did START doc");
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"did End doc ======= %d",[park count]);
}
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"parseError");
}



@end
