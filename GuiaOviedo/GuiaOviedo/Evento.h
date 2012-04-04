//
//  Evento.h
//  GuiaOviedo
//
//  Created by svp on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Multimedia;

@interface Evento : NSManagedObject

@property (nonatomic, retain) NSDate * fin;
@property (nonatomic, retain) NSDate * inicio;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * programa;
@property (nonatomic, retain) NSSet *multimedias;
@property (nonatomic, retain) NSManagedObject *ubicacion;
@end

@interface Evento (CoreDataGeneratedAccessors)

- (void)addMultimediasObject:(Multimedia *)value;
- (void)removeMultimediasObject:(Multimedia *)value;
- (void)addMultimedias:(NSSet *)values;
- (void)removeMultimedias:(NSSet *)values;
@end
