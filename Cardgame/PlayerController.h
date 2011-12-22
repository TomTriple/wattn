//
//  PlayerController.h
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3PODResourceNode.h"
#import "Wattn.h"
#import "ControllerBase.h"

@class Card;


@interface PlayerController : ControllerBase {
    Card *_thinkResult;
}

-(void)thinkOp;
-(void)thinkOpTimer;

@end
