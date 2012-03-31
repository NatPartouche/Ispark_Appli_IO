//
//  _Reservations.m
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "_Reservations.h"

@implementation _Reservations


-(id)init_Park
{
    if ([super init])
    {
        reservation=[[NSMutableArray alloc]init];
        currentElement=[[NSMutableString alloc]init];
    }
    return self;
}


-(BOOL)load_annuler_reservation:(NSString*)idr
{
    
    reservation=[[NSMutableArray alloc]init];

    NSString *localhost=[NSString stringWithString:@"http://localhost/"];
    NSString *racine=[NSString stringWithFormat:@"%@API_ISPARK/Action/ActionReservation.php?Action=annuler&idreservation=%@",localhost,idr];
    NSLog(@"%@",racine);
    
    [self parseXMLFileAtURL:racine];
    if (dico)
    {
        return true;
    }
    else
    {
        return false;
    }
}
-(void)load:(NSString*)idp withtime:(NSString*)temps anduser:(NSString*)user
{
    reservation=[[NSMutableArray alloc]init];
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy-HH:mm"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    
    NSString *localhost=[NSString stringWithString:@"http://localhost/"];
    NSString *racine=[NSString stringWithFormat:@"%@/API_ISPARK/Action/ActionReservation.php?Action=faire&idParking=%@&temps=%@&datedebut=%@&idUtilisateur=%@",localhost,idp,temps,dateString,user];
    [self parseXMLFileAtURL:racine];
}
-(void)save
{
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray * temppref=[[NSMutableArray alloc]initWithArray:[pref objectForKey:@"Reservations"]];
    [temppref addObject:dico];
    NSLog(@"%@",temppref);
    [pref setObject:temppref forKey:@"Reservations"];
    [pref synchronize];
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
    
        NSLog(@"%@",elementName);
    if ([currentElement isEqualToString:@"Reservation"]) {
        dico=[[NSMutableDictionary alloc]initWithDictionary:attributeDict]; 
    }
    if ([currentElement isEqualToString:@"Reponse"]) {
        dico=[[NSMutableDictionary alloc]initWithDictionary:attributeDict]; 
    }
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{	
    
    currentElement=[elementName copy];
    
    if ([currentElement isEqualToString:@"Reservation"]) {      
        [reservation addObject:dico];
    }
   
    
}

-(void)loadQrcode
{
    
    NSString *localhost=[NSString stringWithString:@"http://localhost/"];

     NSString *string=[NSString stringWithFormat:@"%@API_ISPARK/Reservations/%@",localhost,[dico objectForKey:@"logocode"]];
    
     string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
     NSLog(@"url : %@",string);
     NSURL *url=[NSURL URLWithString:string];
     NSData *datalogo=[NSData dataWithContentsOfURL:url];
     [dico setObject:datalogo forKey:@"Qrcode"];
   
}




#pragma mark - Application's Documents directory

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    NSLog(@"did START doc");
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"did End doc ======= %d",[reservation count]);
}
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"parseError");
}


@end
