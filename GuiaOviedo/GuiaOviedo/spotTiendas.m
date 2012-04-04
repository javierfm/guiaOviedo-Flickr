//
//  spotTiendas.m
//  ProyectoFinal
//
//  Created by svp on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "spotTiendas.h"

@implementation spotTiendas

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{   
    if(self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        UIImage *imagen=[UIImage imageNamed:@"shop.png"];
        if(!imagen)
        {
            
            return nil;
        }
        self.image=imagen;
    }
    return self;
}

@end
