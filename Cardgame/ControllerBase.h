//
//  PlayerBase.h
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@class CC3MeshNode; 


@interface ControllerBase : NSObject {
    NSMutableArray *_cards;
    CC3MeshNode *_playerNode;
    BOOL _thinking; 
}

@property (nonatomic, retain, readonly) NSMutableArray *cards; 
@property (nonatomic, retain) CC3MeshNode *playerNode; 

-(void)startNewGame; 
-(void)receiveCard:(Card *)card;
-(Card*)playCard;
-(void)think;

@end
