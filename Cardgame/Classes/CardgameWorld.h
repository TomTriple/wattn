//
//  CardgameWorld.h
//  Cardgame
//
//  Created by tom hoefer on 04.12.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


#import "CC3World.h"
#import "CC3MeshNode.h"
#import "CC3PODResourceNode.h" 


@class PhonePlayerController, PlayerController; 

@interface CardgameWorld : CC3World {
    CC3PODResourceNode *player;
    CC3Node *_marker; 
    PhonePlayerController *phoneController;
}

-(void)mark:(PlayerController*)playerController;

@end
