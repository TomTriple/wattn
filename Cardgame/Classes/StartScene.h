//
//  StartScene.h
//  Cardgame
//
//  Created by tom hoefer on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScene.h"
#import "CCLayer.h" 

@class CCMenuItem, CCMenu, CCSprite;


@interface StartScene : CCScene

@end


@interface StartLayer : CCLayer {
    CCMenu *menu;
    CCMenuItem *menuItemStart;
    CCMenuItem *menuItemOptions;
}

@end
