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
#import "Fotografia.h"

# define URLServicio [NSURL URLWithString:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=088cf623e8e9ac0c43c0351bd935aa63&tags=Oviedo&sort=date-posted-desc&accuracy=11&content_type=1&has_geo=1&format=json&nojsoncallback=1&auth_token=72157629335800670-8b255613d3b3007d&api_sig=b6b888234cc983e0013bab9bc864dca0"]

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property(nonatomic,retain)NSMutableArray *listadoFotos;
@property(nonatomic,retain)NSMutableData *datosInternet;
- (void)serializar;
@end
