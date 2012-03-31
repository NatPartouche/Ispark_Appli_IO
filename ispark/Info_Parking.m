//
//  Info_Parking.m
//  ispark
//
//  Created by Natanel Partouche on 17/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "Info_Parking.h"

@implementation Info_Parking

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    timeron=false;
    [timer invalidate];
    timer=nil;

}



-(void)get_place{

 
    dicoarray=[[NSMutableArray alloc]init];
    dicotemp=[[NSMutableDictionary alloc]init];
    
    NSString *localhost=[NSString stringWithString:@"http://localhost/"];
    [self parseXMLFileAtURL:[NSString stringWithFormat:@"%@API_ISPARK/Action/ActionParking.php?Action=infozone&id=%@",localhost,[dico objectForKey:@"idparking"]]];
    NSLog(@"dicoarray  : %@",[dicoarray description]);
    
    
    NSString *nbrplacereservable=[dicotemp objectForKey:@"nbrplacereservable"];
    NSString *nombreplacedisponible=[dicotemp objectForKey:@"nombreplacedisponible"];
    NSString *zonenonreservable=[dicotemp objectForKey:@"zonenonreservable"];
    NSString *zonereservable=[dicotemp objectForKey:@"zonereservable"];

    current_nbr.text=[NSString stringWithFormat:@"VIP : %@/%@ \nClassique : %@/%@",nbrplacereservable,nombreplacedisponible,zonenonreservable,zonereservable];
    
}
#pragma mark - Application's Documents directory

-(void)parseXMLFileAtURL:(NSString *)URL
{
	NSURL *xmlurl=[NSURL URLWithString:URL];
    
	rssparser=[[NSXMLParser alloc]initWithContentsOfURL:xmlurl];
	[rssparser setDelegate:self];
    [rssparser parse];
    //nombreplacedisponible
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement=[elementName copy];
    
    if ([currentElement isEqualToString:@"Reponse"]) {        
        [dicotemp setDictionary:attributeDict];
    }
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{	
    
    currentElement=[elementName copy];
    if ([currentElement isEqualToString:@"Reponse"]) {
        [dicoarray addObject:dicotemp];
    }
    
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    NSLog(@"did START doc");
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"did End doc ======= %d",[dicoarray count]);
}
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"parseError");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(get_place) userInfo:nil repeats:YES];
    
    NSLog(@"hello");
    
      logoimage.image=[UIImage imageWithData:[dico objectForKey:@"logo_image"]];
    picker_temp_reservation.hidden=YES;
    
    NSLog(@"test");
    tab_temp_reservation=[[NSMutableArray alloc]init];
    
    for (int i=0; i<6; i++) {
        NSString *string;
        if (i==0)
        {
        string=[NSString stringWithFormat:@"arivée dans %d heure",i];
        }
        else{
        string=[NSString stringWithFormat:@"arivée dans %d heures",i];
        }
        
        [tab_temp_reservation addObject:string];
    }
    
    
    // Do any additional setup after loading the view from its nib.
    textview.text=[dico description];
    Nom.text=[dico objectForKey:@"nomparking"];
    Adresse.text=[dico objectForKey:@"adresse"];
    Telephone.titleLabel.text=[dico objectForKey:@"telephone"];
}

- (void)viewDidUnload
{
    [textview release];
    textview = nil;
    [Nom release];
    Nom = nil;
    [Adresse release];
    Adresse = nil;
    [Telephone release];
    Telephone = nil;
    [picker_temp_reservation release];
    picker_temp_reservation = nil;
    [logoimage release];
    logoimage = nil;
    [current_nbr release];
    current_nbr = nil;
    [current_nbr release];
    current_nbr = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#import "_Reservations.h"
- (IBAction)reservation:(id)sender {
    
    picker_temp_reservation.hidden=NO;
    
}



- (IBAction)Appeller_Telephone:(id)sender {
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [tab_temp_reservation count];
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    current_temps=row;
    NSLog(@"current temp : %d row %d",current_temps,row);
    return [tab_temp_reservation objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"Selected Color: %@. Index of selected color: %i", [tab_temp_reservation objectAtIndex:row], row);

    NSString *title=@"Votre reservation";
    NSString *message=[NSString stringWithFormat:@"Vous avez reservé une place dans la Zone VIP de %@, vous nous avez indiquez votre %@",[dico objectForKey:@"nomparking"],[tab_temp_reservation objectAtIndex:row]];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"oui" otherButtonTitles:@"non", nil];
    [alert show];
    [alert release];
    
}
#import "Espace_Payment.h"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
	if([title isEqualToString:@"oui"])
	{
		NSLog(@"oui  was selected.");
        
        Espace_Payment *e=[[Espace_Payment alloc]init];
        [e setdico:dico];
        [e settemp:current_temps];
        [self.navigationController pushViewController:e animated:YES];
	}
	else if([title isEqualToString:@"non"])
	{
		NSLog(@"non was selected.");
        picker_temp_reservation.hidden=YES;
	}
	
}
-(void)setparkingdico:(NSMutableDictionary*)d
{
    dico=d;
}
- (void)dealloc {
    [textview release];
    [Nom release];
    [Adresse release];
    [Telephone release];
    [picker_temp_reservation release];
    [logoimage release];
    [current_nbr release];
    [current_nbr release];
    [super dealloc];
}
@end
