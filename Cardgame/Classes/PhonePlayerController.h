//
//  PhonePlayerController.h
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControllerBase.h"

@class CC3Node, Card;

@interface PhonePlayerController : ControllerBase {
    Card *_thinkResult;
}

-(void)userSelectedCardNode:(CC3Node *)node; 

@end
