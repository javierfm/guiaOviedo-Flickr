//
//  Multimedia.h
//  GuiaOviedo
//
//  Created by svp on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Multimedia : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSManagedObject *evento;

@end
