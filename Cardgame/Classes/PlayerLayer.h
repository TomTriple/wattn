//
//  PlayerLayer.h
//  Cardgame
//
//  Created by tom hoefer on 06.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCLayer.h"


@interface PlayerLayer : CCLayerColor
+(id)layerWithName:(NSString *)name size:(CGSize)size;
@property (nonatomic, retain) NSString* name; 
@end
