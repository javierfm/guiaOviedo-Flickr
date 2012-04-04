//
//  spotTiendas.h
//  ProyectoFinal
//
//  Created by svp on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface spotTiendas : MKAnnotationView

//El constructor no hereda de NSOBject sino de MKAnnotationView
-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString*)reuseIdentifier;

@end
