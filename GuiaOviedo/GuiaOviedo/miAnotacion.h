//
//  miAnotacion.h
//  MapKit2
//
//  Created by svp on 05/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface miAnotacion : NSObject <MKAnnotation>
@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property(nonatomic,retain)NSString *titulo;
@property(nonatomic,retain)NSString *subtitulo;

-(id)initWithCoordenada:(CLLocationCoordinate2D)_coordenada titulo:(NSString*)_titulo subtitulo:(NSString*)_subtitulo;
-(NSString*)subtitle;
-(NSString*)title;

@end
