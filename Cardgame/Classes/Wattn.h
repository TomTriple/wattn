//
//  Wattn.h
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CardgameWorld, ControllerBase;

@interface Wattn : NSObject {
    NSMutableSet *_cards; 
    int _round;
    CardgameWorld *_world; 
    ControllerBase *_currentController;
    int _iteratorIndex;
}

@property (nonatomic, retain) NSMutableArray *players;
-(void)startNewGame; 
-(id)init:(CardgameWorld *)world; 
@end

