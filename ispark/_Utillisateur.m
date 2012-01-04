//
//  _Utillisateur.m
//  ispark
//
//  Created by Natanel Partouche on 04/01/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "_Utillisateur.h"

@implementation _Utillisateur
-(id)init
{
    if ([super init])
    {
      
    }
    return self;
}


-(void)load:(NSString*)mail and:(NSString*)mdp
{
    NSString *localhost=[NSString stringWithString:@"http://natanelpartouche.com/API_ISPARK/API_ISPARK/"];
    NSString *racine=[NSString stringWithFormat:@"%@Action/ActionUtilisateur.php?Action=authentification&mail=%@&motdepasse=%@",localhost,mail,mdp];
    NSLog(@"%@",racine);
    [self parseXMLFileAtURL:racine];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement=[elementName copy];
    
    NSLog(@"%@",elementName);

    if ([currentElement isEqualToString:@"Utilisateur"]) {
        NSLog(@"%@",[attributeDict description]);
        dico_user=[[NSMutableDictionary alloc]initWithDictionary:attributeDict]; 
    }
}

#pragma _parser
-(void)parseXMLFileAtURL:(NSString *)URL
{
	NSURL *xmlurl=[NSURL URLWithString:URL];
	rssparser=[[NSXMLParser alloc]initWithContentsOfURL:xmlurl];
	[rssparser setDelegate:self];
    [rssparser parse];    
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
}
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
}

-(void)save
{
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    
    [pref setObject:dico_user forKey:@"dico_user"];
    [pref synchronize];
}

-(NSMutableDictionary *)charge
{
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    dico_user=[pref objectForKey:@"dico_user"];
    [pref synchronize];
    return dico_user;
}
@end
