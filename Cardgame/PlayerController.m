//
//  PlayerController.m
//  ;
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerController.h"
#import "CardgameWorld.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"
#import "CCAction.h"
#import "CCActionInterval.h"
#import "CC3GLMatrix.h"
#import "CC3Billboard.h"
#import "CCLabelTTF.h"
#import "CCLayer.h"




@implementation PlayerController


-(id)init{
    self = [super init];
    if(self) {
        _playerNode = (CC3PODResourceNode *) [CC3PODResourceNode nodeFromResourceFile:@"player.pod"];
        _thinkResult = nil; 
    }
    return self; 
}


-(void)startNewGame {
    CCActionInterval *loop = [CCRepeatForever actionWithAction:[CC3Animate actionWithDuration:2 limitFrom:.3 to:.4]];
    [_playerNode runAction:loop]; 
    CCActionInterval *intro = [CC3Animate actionWithDuration:3 limitFrom:0 to:.2];
    [_playerNode runAction:intro];
}


-(void)think {
    NSLog(@"cpu-player denkt...");
    if(_thinking == NO) {
        _thinkResult = nil; 
        _thinking = YES; 
        NSThread *th = [[NSThread alloc] initWithTarget:self selector:@selector(thinkOp) object:nil];
        [th start];
    }
}


-(void)thinkOp {
    [NSThread sleepForTimeInterval:3];
    // zug-algorithmus...
    @synchronized(self) {
        _thinkResult = [_cards objectAtIndex:0];
    }
}


-(Card *)playCard {
    @synchronized(self) {
        if(_thinkResult != nil) {
            _thinking = NO;
            [_playerNode runAction:[CC3Animate actionWithDuration:0.5 limitFrom:0.4 to:0.5]];
            CCLabelTTF* bbLabel = [CCLabelTTF labelWithString: [_thinkResult toString] fontName: @"Marker Felt" fontSize: 200.0];
            CCLayerColor *billboard = [CCLayerColor layerWithColor:ccc4(100, 100, 100, 0) width:1 height:1];
            [billboard addChild:bbLabel];
            CC3Billboard* bb = [CC3Billboard nodeWithName: @"billy" withBillboard: billboard];
            bb.zOrder = 1;
            bb.color = ccBLACK;
            bb.location = cc3v(0,3,0);
            bb.shouldDrawAs2DOverlay = YES; 
            [_playerNode addChild:bb];
            
            /*
            CC3Node *card = [self getNodeNamed:@"card"];
            card.location = cc3v(0, 0.5, -2);    
            [card runAction:[CC3MoveTo actionWithDuration:0.1 moveTo:CC3VectorMake(0,.1,1)]];
             */
            return _thinkResult;
        }
    }
    return nil;
}


@end
