//
//  DetailViewController.h
//  GuiaOviedo
//
//  Created by svp on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "miAnotacion.h"
#import "spotTiendas.h"
#import "detalleLocalizacion.h"

#define zoom_max .003
#define zoom_norm .03
#define zoom_min .12


@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,MKMapViewDelegate,MKOverlay>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet MKMapView *mapa;
@property (strong,nonatomic)UIPopoverController *popOver;

-(void)obtenerLocalizaciones;
-(void)guardarLocalizaciones:(NSDictionary*)_localizaciones;
-(IBAction)vistaSatelite:(id)sender;
-(IBAction)variarZoom:(id)sender;
@end
