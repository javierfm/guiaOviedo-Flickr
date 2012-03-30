//
//  DetailViewController.h
//  GuiaOviedo
//
//  Created by svp on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

# define URLServicio [NSURL URLWithString:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=39ea99392a509d351c352ab0651080dd&tags=oviedo&sort=date-posted-desc&accuracy=11&content_type=1&has_geo=1&page=5&format=json&nojsoncallback=1&auth_token=72157629328549670-a95610979f24c5f9&api_sig=6802bbfdfae0d192556023f22f1d90f0"]

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property(nonatomic,retain)NSMutableArray *listadoFotos;
@property(nonatomic,retain)NSMutableData *datosInternet;
- (void)serializar;
@end
