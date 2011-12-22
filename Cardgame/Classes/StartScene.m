//
//  StartScene.m
//  Cardgame
//
//  Created by tom hoefer on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StartScene.h"
#import "CCMenu.h"
#import "CCMenuItem.h"
#import "CCSprite.h" 
#import "CCAction.h"
#import "CCActionInterval.h"
#import "CGPointExtension.h"
#import "CCActionEase.h"
#import "CCDirector.h"
#import "CCTransition.h"
#import "PickerScene.h"



@implementation StartScene

-(id)init {
    self = [super init];
    if(self) {
        StartLayer *startLayer = [[StartLayer alloc] init];
        CCLayer *backgroundLayer = [[CCLayer alloc] init];
        CCSprite *background = [CCSprite spriteWithFile:@"env.jpg"];
        background.position = ccp(0, 200);
        [backgroundLayer addChild:background]; 
        [self addChild:backgroundLayer]; 
        [self addChild:startLayer];
        [startLayer release];
        [backgroundLayer release]; 
    }
    
    return self; 
}

@end



@interface StartLayer ()
-(void)addButtons;
-(void)itemStartTouched:(CCMenuItem *)item;
-(void)itemOptionsTouched:(CCMenuItem *)item;
-(void)menuItemsAnimate:(ccTime)dt;
@end



@implementation StartLayer


-(id)init {
    self = [super init];
    if(self) {
        self.isTouchEnabled = YES;
        [self addButtons]; 
        [self schedule:@selector(menuItemsAnimate:) interval:1.5];  
    }
    return self;
}


-(void)menuItemsAnimate:(ccTime)dt {
    for (int i = 0; i < menu.children.count; i++) {
        srandom(time(NULL)); 
        CCActionInterval *rotate = [CCRotateBy actionWithDuration:0.2 angle:rand() % 20 - 10];
        CCActionInterval *back = [rotate reverse]; 
        CCActionInterval *seq = [CCSequence actions:rotate, back, nil]; 
        CCActionInterval *bounce = [CCEaseBounceOut actionWithAction:seq];
        CCMenuItem *item = [menu.children objectAtIndex:i];
        [item runAction:bounce]; 
    }
}


-(void)addButtons {
    menuItemStart = [CCMenuItemImage itemFromNormalImage:@"Icon.png" selectedImage:@"Icon.png" target:self selector:@selector(itemStartTouched:)]; 
    menuItemOptions = [CCMenuItemImage itemFromNormalImage:@"Icon.png" selectedImage:@"Icon.png" target:self selector:@selector(itemOptionsTouched:)];
    menu = [CCMenu menuWithItems:menuItemStart, menuItemOptions, nil]; 
    [menu alignItemsVertically];
    [self addChild:menu];
}


-(void)itemOptionsTouched:(CCMenuItem *)item {
    NSLog(@"options...");
}


-(void)itemStartTouched:(CCMenuItem *)item {
    CCDirector *director = [CCDirector sharedDirector];
    PickerScene *pickerScene = [[PickerScene alloc] init]; 
    [director replaceScene: [CCTransitionFade transitionWithDuration:0.5 scene:pickerScene]];
    [pickerScene release];
}

@end