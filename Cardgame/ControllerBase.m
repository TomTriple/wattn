//
//  PlayerBase.m
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ControllerBase.h"

@implementation ControllerBase

@synthesize playerNode = _playerNode; 
@synthesize cards = _cards; 


-(id)init {
    self = [super init];
    if (self) {
        _cards = [[NSMutableArray alloc] init];
        _thinking = NO; 
    }
    return self;
}


-(void)startNewGame {

}


-(void)receiveCard:(Card *)card {
    [_cards addObject:card];
}


-(Card*)playCard {
    
}


-(void)think {

}


-(void)dealloc {
    [super dealloc];
    [_cards release];
    [_playerNode release]; 
}

@end
