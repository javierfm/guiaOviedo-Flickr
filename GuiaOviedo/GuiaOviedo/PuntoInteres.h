//
//  PuntoInteres.h
//  GuiaOviedo
//
//  Created by svp on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Evento;

@interface PuntoInteres : NSManagedObject

@property (nonatomic, retain) NSString * direccion;
@property (nonatomic, retain) NSNumber * latitud;
@property (nonatomic, retain) NSNumber * longitud;
@property (nonatomic, retain) NSString * telefono;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSString * web;
@property (nonatomic, retain) NSSet *eventos;
@end

@interface PuntoInteres (CoreDataGeneratedAccessors)

- (void)addEventosObject:(Evento *)value;
- (void)removeEventosObject:(Evento *)value;
- (void)addEventos:(NSSet *)values;
- (void)removeEventos:(NSSet *)values;
@end
