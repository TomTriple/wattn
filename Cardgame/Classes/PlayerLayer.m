//
//  PlayerLayer.m
//  Cardgame
//
//  Created by tom hoefer on 06.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerLayer.h"
#import "CCLabelTTF.h"


@implementation PlayerLayer

@synthesize name; 

+(id)layerWithName:(NSString *)name size:(CGSize)size {
    PlayerLayer *layer = [PlayerLayer layerWithColor:ccc4(200, 200, 200, 200) width:size.width height:size.height];
    layer.name = name; 
    CCLabelTTF *nameLayer = [CCLabelTTF labelWithString:name fontName:@"Marker Felt" fontSize:22];
    nameLayer.position = CGPointMake(125, 25);
    [layer addChild:nameLayer];
    return layer; 
}

@end
