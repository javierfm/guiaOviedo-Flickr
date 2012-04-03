//
//  DetailViewController.h
//  GuiaOviedo
//
//  Obtenemos un Array de objetos Fotografia con url de la imagen y coordenadas
//  
//
//  Created by svp on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define GOOGLE_KEY @"AIzaSyBbTDcEqnIxUdynVLKX83x1nlFIm1RjOAA"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property(nonatomic,retain)NSMutableData *datosInternet;


//Hacemos una petición al servicio de obtener fotos
-(void)obtenerFotos;
//Serializa los datos de las peticiónes
- (void)serializar;
@end
