//
//  DetailViewController.h
//  GuiaOviedo
//
//  Created by svp on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "ControladorDetalle.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,MKMapViewDelegate,MKOverlay>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet MKMapView *mapa;
@property (strong,nonatomic)UIPopoverController *popOver;

@property(retain,nonatomic)UIPopoverController *controladorPopover;


-(IBAction)mostrar:(id)sender;
@end
