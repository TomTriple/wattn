//
//  ;
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Wattn.h"
#import "CC3PODResourceNode.h"
#import "PlayerController.h"
#import "Card.h"


enum CARD_COLOR {
    HERZ, GRAS, SCHELLE, EICHEL
};

enum CARD_VALUE {
    SIEBEN, ACHT, NEUN, ZEHN, UNTER, OBER, KOENIG, ASS 
};



@interface Wattn (Private)
-(void)mixCards; 
-(void)startNewRound;
-(void)gameloop;
-(void)nextController;
@end



@implementation Wattn

@synthesize players = _players; 

-(id)init:(CardgameWorld *)world {
    self = [super init]; 
    if(self) {
        _world = world;
        _players = [[NSMutableArray alloc] init];
        _cards = [[NSMutableSet alloc] init];
        _iteratorIndex = 0; 
    }
    return self; 
}


-(void)startNewGame {
    [self mixCards]; 
    for(ControllerBase *playerController in _players) {
        for (int i = 0; i < 5; i++) {
            Card *card = [_cards anyObject];
            [playerController receiveCard:card];
            [_cards removeObject:card];
        }
        [playerController startNewGame];
    }
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(startNewRound) userInfo:nil repeats:NO];
}


-(void)startNewRound {
    [self nextController];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(gameloop) userInfo:nil repeats:YES]; 
}


-(void)gameloop {
    Card *card = nil;
    [_currentController think]; 
    if((card = [_currentController playCard]) != nil) {
        NSLog(@"player hat sich entschieden, spielt %@", [card toString]); 
        [self nextController];
    } else {
        ;
    }
}


// wieso geht das mit NSEnumeration nicht?! :( 
-(void)nextController {
    if(_iteratorIndex == _players.count)
        _iteratorIndex = 0;
    _currentController = [_players objectAtIndex:_iteratorIndex];
    [_world mark:_currentController];    
    _iteratorIndex++; 
}


-(void)dealloc {
    [super dealloc];
    [_players release];
    [_cards release];
}


-(void)mixCards {
    for(int i = HERZ; i <= EICHEL; i++) {
        for(int j = SIEBEN; j <= ASS; j++) {
            Card *card = [[Card alloc] init]; 
            card.color = i;
            card.value = j; 
            [_cards addObject:card]; 
            [card release];
        }
    }
}

@end


