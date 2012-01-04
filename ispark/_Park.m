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
    
    //[NSString stringWithString:@"http://natanelpartouche.com/API_ISPARK/API_ISPARK/"];

}
    return self;
}

-(void)load:(NSString*)arg
{
    localhost=[NSString stringWithString:@"http://natanelpartouche.com/API_ISPARK/API_ISPARK/" ];

    park=[[NSMutableArray alloc]init];
    NSLog(@"%@",localhost);
    NSString *racine=[NSString stringWithFormat:@"%@Action/ActionPark.php?Action=",localhost];
    NSLog(@"%@%@",racine,arg);
    [self parseXMLFileAtURL:[NSString stringWithFormat:@"%@%@",racine,arg]];
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref setObject:park forKey:@"park"];
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
    //http://natanelpartouche.com/API_ISPARK/API_ISPARK/images/test.png
    
    NSLog(@"%@",[park description]);
    NSString *racine=[NSString stringWithFormat:@"%@images",localhost];
    NSMutableArray *tempoarray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[park count]; i++) {
        NSMutableDictionary *tempdico=[park objectAtIndex:i];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",racine,[tempdico objectForKey:@"logo"]]];
        NSLog(@"racine : %@",url);
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
