//
//  ParkingMap.m
//  ispark
//
//  Created by Natanel Partouche on 26/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "ParkingMap.h"
#import "AnnotationBonPlan.h"



@implementation ParkingMap;
@synthesize allAnnotationsArray, mapView;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - View lifecycle

-(void)loadDatas
{
    //initialisation des pins
    
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    NSMutableArray *park = [pref objectForKey:@"park"];
    
    NSLog(@"%@",[park description]);
    
    allAnnotationsArray=[[NSMutableArray alloc]init ];
    NSLog(@"%@",allAnnotationsArray);
    
    for(int i = 0; i < [park count]; i++){
        
        NSLog(@"annotation %d",i);
        NSMutableDictionary *dic = [park objectAtIndex:i];
        NSMutableString *title = [dic objectForKey:@"nomparking"];
        NSMutableString *type = [dic objectForKey:@"adresse"];
        NSMutableString *latitude = [dic objectForKey:@"latitude"];
        NSMutableString *longitude = [dic objectForKey:@"longitude"];
        CLLocationCoordinate2D location;
        location.latitude = [latitude doubleValue];
        location.longitude = [longitude doubleValue];
        NSString *imgName = @"icone.png";
        
        AnnotationBonPlan *annot = [[AnnotationBonPlan alloc] initWithTitle:title withDescription:[dic objectForKey:@"type"] withType:type withCoordinate:location andImgName:imgName];
        //annot.bonPlanImg=[self loadImages:[dic objectForKey:@"logo"]];
    
        [allAnnotationsArray addObject:annot];
        [mapView addAnnotation:annot];
    }
}

-(UIImage*)loadImages:(NSString*)logo
{
   /* NSString *host=[NSString stringWithString:@"http://localhost/"];
    NSString *string=[NSString stringWithFormat:@"%@API_ISPARK/Reponsesxml/%@",host,logo];
    */
    
    //UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
    
   // UIImage *image=[UIImage imageWithData:@"icone.png"]];
    //return image;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    
    
    // Initialisation classique d'une View
    // On veut afficher la position courante de l'utilisateur
    [mapView setShowsUserLocation:TRUE];
    // MKMapTypeStandard est un mode d'affichage parmis 3 disponibles
    // (les deux autres sont MKMapTypeSatelitte et MKMapTypeHybrid)
    [mapView setMapType:MKMapTypeStandard];
    
    // CLLocationManager permet la gestion de la position géographique de l'utilisateur
    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
    // Le fait de setter le Delegate permet d'appeler méthodes implémentées dans cette classe
    [locationManager setDelegate:self];
    // Définit l'échelle de distance à prendre en compte pour le raffraichissement de la position courante
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [locationManager startUpdatingLocation];
    
    //on centre sur paris
    MKCoordinateRegion region; 
    MKCoordinateSpan span; 
    span.latitudeDelta = 0.1; 
    span.longitudeDelta = 0.1; 
    
    CLLocationCoordinate2D newLocation; 
    
    newLocation.latitude =  48.859633;
    newLocation.longitude = 2.313652;
    
    region.span=span; 
    region.center=newLocation; 
    
    [mapView setRegion:region animated:TRUE]; 
    [mapView regionThatFits:region]; 
    
    
    [self loadDatas];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [mapView release];
    [super dealloc];
}

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[AnnotationBonPlan class]]) {
        AnnotationBonPlan *location = (AnnotationBonPlan *) annotation;
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        if ([location.type compare:@"locaux"] == NSOrderedSame) {
            annotationView.pinColor = MKPinAnnotationColorPurple;
            annotationView.canShowCallout = YES;
            annotationView.rightCalloutAccessoryView = nil;
        } else if ([location.type compare:@"partenaire"] == NSOrderedSame) {
            annotationView.pinColor = MKPinAnnotationColorRed;
            annotationView.canShowCallout = YES;
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            rightButton.tag = [allAnnotationsArray indexOfObject:location];
            [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = rightButton;
        }else {
            NSLog(@"Unknown: %@", location.type);
        }
        
        return annotationView;
    }
    
    return nil;    
}

- (void)showDetails:(id)sender{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        //UIButton *button = (UIButton*)sender;
     /*          
        
        [self.navigationController pushViewController:detailBonPlan animated:YES];
                AnnotationBonPlan *annot = [allAnnotationsArray objectAtIndex:button.tag];
                detailBonPlan.title = [annot getTitle];
                [detailBonPlan.textView setText:[annot getDescription]];
                if(annot.bonPlanImg != NULL)
                    [detailBonPlan.logoImageView setImage:annot.bonPlanImg];
                else
    [detailBonPlan.logoImageView setImage:[UIImage imageNamed:@"logoBDE@2x.png"]];
    }
      */
        
    }

}



@end
