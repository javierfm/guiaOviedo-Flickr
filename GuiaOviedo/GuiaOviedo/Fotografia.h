//
//  Fotografia.h
//  GuiaOviedo
//
//  Created by svp on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Fotografia : NSObject

@property(nonatomic,retain)NSURL *urlImagen;
@property(nonatomic,assign)CLLocationCoordinate2D coordenadas;
@property(nonatomic,retain)NSString *titulo;//titulo o autor de la foto
@property(nonatomic,assign)int Id;//lo necesitamos para sus coordenadas

@end
