//
//  PhonePlayerController.m
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PhonePlayerController.h"
#import "CC3Node.h"
#import "CC3MeshNode.h"
#import "CC3ActionInterval.h"
#import "CCActionEase.h"



@implementation PhonePlayerController

-(id)init {
    self = [super init];
    if(self) {
        _thinkResult = nil; 
        _playerNode = [CC3MeshNode nodeWithName:@"me"];
        for (int i = 0; i < 5; i++) {
            CC3BoundingBox bounds = CC3BoundingBoxFromMinMax(cc3v(-.2,-.4,-.01), cc3v(.2,.4,.01));
            CC3MeshNode *cardMesh = [CC3MeshNode nodeWithName:@"card"];
            // don´t propagate picks to playerNode as cube is a valid target, too! 
            cardMesh.isTouchEnabled = YES;
            cardMesh.location = cc3v(-1 + (i * .5), 0, 0);
            [cardMesh populateAsTexturedBox:bounds];
            cardMesh.material = [CC3Material material];
            cardMesh.material.texture = [CC3Texture textureFromFile:@"Icon.png"];
            [_playerNode addChild:cardMesh];
        }
    }
    return self; 
}


-(void)startNewGame {
    CC3Vector target = CC3VectorAdd(_playerNode.location, cc3v(0, -.3, 0));
    [_playerNode runAction:[CCEaseBounceOut actionWithAction:[CC3MoveTo actionWithDuration:2 moveTo:target]]];
}


-(void)think {
    NSLog(@"user denkt...");
    if(_thinking == NO) {
        _thinkResult = nil; 
        CC3Vector target = CC3VectorAdd(_playerNode.location, cc3v(0, .4, 0));
        [_playerNode runAction:[CCEaseBounceOut actionWithAction:[CC3MoveTo actionWithDuration:.5 moveTo:target]]];
        _thinking = YES;
    }
}


-(void)userSelectedCardNode:(CC3Node *)node {
    if (_thinking) {
        int ix = [self cardNodeToIndex:node];
        NSLog(@"ix %i", ix);
        Card *card = [_cards objectAtIndex:ix];
        [_cards removeObject:card];
        _thinkResult = card; 
        NSLog(@"result %@", [card toString]); 
    }
}


-(int)cardNodeToIndex:(CC3Node*)node {
    for (int i = 0; i < _playerNode.children.count; i++) {
        CC3Node *child = [[_playerNode children] objectAtIndex:i];
        if (child == node)
            return i; 
    }
}


-(Card*)playCard {
    if (_thinking && _thinkResult) {
        _thinking = NO;
    }
    return _thinkResult;
}

@end

