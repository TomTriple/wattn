//
//  PickerScene.m
//  Cardgame
//
//  Created by tom hoefer on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PickerScene.h"
#import "CCSprite.h"
#import "CGPointExtension.h"
#import "CCLabelTTF.h"
#import "CCDirector.h"
#import "CCMenu.h"
#import "CCMenuItem.h"
#import "CCTouchDispatcher.h"
#import "CCActionInterval.h"
#import "CCActionEase.h"
#import "PlayerLayer.h"
#import "CC3Layer.h"
#import "CardgameLayer.h"
#import "CardgameWorld.h"
#import "CCNodeController.h"



#define ITEM_HEIGHT 50


@implementation PickerScene

-(id)init {
    self = [super init];
    if(self) {
        PickerLayer *layer = [[PickerLayer alloc] init];
        [self addChild:layer];
    }
    return self;
}

@end




@interface PickerLayer (Private)
-(void)addCurrentToPicks;
-(BOOL)startbuttonTouched; 
-(BOOL)playerLayerTouched; 
@end


@implementation PickerLayer 

-(id)init {
    self = [super init];
    if(self) {
        picks = [[NSMutableArray alloc] init];
        selectionNeedsRedraw = NO; 
        self.isTouchEnabled = YES;                 
        size = [[CCDirector sharedDirector] winSize]; 
        PlayerLayer *base = [PlayerLayer layerWithName:@"test" size:CGSizeMake(size.width, ITEM_HEIGHT)];
        base.position = ccp(0, size.height - ITEM_HEIGHT); 
        startButton = [CCSprite spriteWithFile:@"Icon.png"]; 
        startButton.position = ccp((size.width - [startButton boundingBox].size.width) / 2, 140);
        [self addChild:startButton]; 
        [self addChild:base];
        [self scheduleUpdate]; 

    }
    return self;
}


-(void)update:(ccTime)dt {
    if(selectionNeedsRedraw == NO)
        return; 
    for(int i = 0; i < picks.count; i++) {
        PlayerLayer *layer = [picks objectAtIndex:i]; 
        CCSprite *selection = [CCSprite spriteWithFile:@"Icon.png"];
        [self addChild:selection]; 
        selection.position = ccp(80 * i + 40, 60); 
        srand(time(NULL)); 
        [selection runAction:[CCMoveBy actionWithDuration:0.05 position:ccp(rand() % 5 + 1, 0)]];
    }
    selectionNeedsRedraw = NO; 
}


-(BOOL)playerLayerTouched {
    CCActionInterval *tint = [CCTintTo actionWithDuration:.1 red:0 green:0 blue:0];
    CCActionInterval *scale = [CCScaleBy actionWithDuration:.1 scale:0.95]; 
    CCActionInterval *seq = [CCSequence actions:scale, tint, scale.reverse, nil];
    [currentSelection runAction:[CCEaseBounceOut actionWithAction:seq]]; 
    [self addCurrentToPicks];
    NSLog(@"touched...");
    return YES;
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch]; 
    for(int i = 0; i < self.children.count; i++) {
        currentSelection = (PlayerLayer *)[self.children objectAtIndex:i]; 
        if(CGRectContainsPoint([currentSelection boundingBox], touchPoint)) {
            if([currentSelection isMemberOfClass:[PlayerLayer class]]) 
                return [self playerLayerTouched]; 
            else if(currentSelection == startButton) {
                return [self startbuttonTouched]; 
            }        
        }
    }
    return NO; 
}


-(BOOL)startbuttonTouched {
	CC3Layer* cc3Layer = [CardgameLayer node];
	[cc3Layer scheduleUpdate];
	cc3Layer.cc3World = [CardgameWorld world];
	ControllableCCLayer* mainLayer = cc3Layer; 
	CCNodeController *viewController = [[CCNodeController controller] retain];
	viewController.doesAutoRotate = YES;
	[viewController runSceneOnNode: mainLayer];	 
    return YES; 
}


-(void)addCurrentToPicks {
    [picks addObject:currentSelection]; 
    selectionNeedsRedraw = YES; 
}


-(void)dealloc {
    [super dealloc]; 
    [picks release]; 
}


-(void)registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];    
}


@end
