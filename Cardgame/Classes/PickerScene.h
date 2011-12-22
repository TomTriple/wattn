//
//  PickerScene.h
//  Cardgame
//
//  Created by tom hoefer on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScene.h"
#import "CCLayer.h"
#import "CCNode.h"
#import "CCSprite.h"
#import "PlayerLayer.h"

@interface PickerScene : CCScene

@end



@interface PickerLayer : CCLayer {
    CGSize size;
    NSMutableArray *picks; 
    CCNode *currentSelection; 
    BOOL selectionNeedsRedraw; 
    CCSprite *startButton;
}

@end
