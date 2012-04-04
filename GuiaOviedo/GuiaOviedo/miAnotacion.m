//
//  miAnotacion.m
//  MapKit2
//
//  Created by svp on 05/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "miAnotacion.h"

@implementation miAnotacion
@synthesize coordinate,titulo,subtitulo;

-(NSString*)subtitle
{
    return self.subtitulo;
}

-(NSString*)title
{
    return self.titulo;
}

-(id)initWithCoordenada:(CLLocationCoordinate2D)_coordenada titulo:(NSString *)_titulo subtitulo:(NSString *)_subtitulo
{
    coordinate=_coordenada;
    self.titulo=_titulo;
    self.subtitulo=_subtitulo;
    return self;
}

@end
