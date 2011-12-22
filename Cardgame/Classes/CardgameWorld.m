//
//  CardgameWorld.m
//  Cardgame
//
//  Created by tom hoefer on 04.12.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "CardgameWorld.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"
#import "CCAction.h"
#import "CCActionInterval.h"
#import "CC3GLMatrix.h"
#import "PlayerController.h"
#import "Wattn.h"
#import "PhonePlayerController.h"
#import "CC3Billboard.h"
#import "CCLabelTTF.h"



@implementation CardgameWorld

-(void) dealloc {
	[super dealloc];
}


-(void) initializeWorld {
    
	// Create Camera
	CC3Camera* cam = [CC3Camera nodeWithName: @"Camera"];
	cam.location = cc3v( 0.0,1, 6.0 );
	[self addChild: cam];
    
    
    // Create additional lights
	CC3Light* lamp = [CC3Light nodeWithName: @"Lamp"];
	lamp.location = cc3v( 0, 2.0, 2.0 );
	[self addChild: lamp];  
    
    
    // Load entire environment 
    [self addContentFromPODResourceFile:@"world.pod"];
    
    
    // Init a cpu-player
    PlayerController *playerController = [[PlayerController alloc] init];
    playerController.playerNode.isTouchEnabled = YES; 
    playerController.playerNode.location = cc3v(0,0,-3.4); 
    [self addChild:playerController.playerNode];
    
    
    // Init human player
    phoneController = [[PhonePlayerController alloc] init];
    phoneController.playerNode.location = cc3v(0, 0.2, 3);
    phoneController.playerNode.isTouchEnabled = YES; 
    [self addChild:phoneController.playerNode]; 
    
    
    // Create VBO 
    [self createGLBuffers];
	[self releaseRedundantData];

    
    // Init marker 
    _marker = [self getNodeNamed:@"marker"];
    _marker.location = CC3VectorAdd(cam.location, cc3v(0,1,0)); 
    
    
    // Start game 
    Wattn *wattn = [[Wattn alloc] init:self];
    [wattn.players addObject:playerController];
    [wattn.players addObject:phoneController];
    [wattn startNewGame];

	LogDebug(@"The structure of this world is: %@", [self structureDescription]);

}


-(void)mark:(PlayerController *)playerController {
    CCEaseElasticOut *anim = [CCEaseElasticOut actionWithAction:[CC3MoveTo actionWithDuration:.5 moveTo:CC3VectorAdd(playerController.playerNode.location, cc3v(0,2.3,0))]];
    [_marker runAction:anim];
}



-(void)nodeSelected:(CC3Node *)aNode byTouchEvent:(uint)touchType at:(CGPoint)touchPoint {
    if(aNode != nil) {
        if([aNode parent] == phoneController.playerNode) {
            [phoneController userSelectedCardNode:aNode]; 
        }
    }
}

/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides this node with an opportunity to perform update activities before
 * any changes are applied to the transformMatrix of the node. The similar and complimentary
 * method updateAfterTransform: is automatically invoked after the transformMatrix has been
 * recalculated. If you need to make changes to the transform properties (location, rotation,
 * scale) of the node, or any child nodes, you should override this method to perform those
 * changes.
 *
 * The global transform properties of a node (globalLocation, globalRotation, globalScale)
 * will not have accurate values when this method is run, since they are only valid after
 * the transformMatrix has been updated. If you need to make use of the global properties
 * of a node (such as for collision detection), override the udpateAfterTransform: method
 * instead, and access those properties there.
 *
 * The specified visitor encapsulates the CC3World instance, to allow this node to interact
 * with other nodes in its world.
 *
 * The visitor also encapsulates the deltaTime, which is the interval, in seconds, since
 * the previous update. This value can be used to create realistic real-time motion that
 * is independent of specific frame or update rates. Depending on the setting of the
 * maxUpdateInterval property of the CC3World instance, the value of dt may be clamped to
 * an upper limit before being passed to this method. See the description of the CC3World
 * maxUpdateInterval property for more information about clamping the update interval.
 *
 * As described in the class documentation, in keeping with best practices, updating the
 * model state should be kept separate from frame rendering. Therefore, when overriding
 * this method in a subclass, do not perform any drawing or rending operations. This
 * method should perform model updates only.
 *
 * This method is invoked automatically at each scheduled update. Usually, the application
 * never needs to invoke this method directly.
 */
-(void) updateBeforeTransform: (CC3NodeUpdatingVisitor*) visitor {}

/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides this node with an opportunity to perform update activities after
 * the transformMatrix of the node has been recalculated. The similar and complimentary
 * method updateBeforeTransform: is automatically invoked before the transformMatrix
 * has been recalculated.
 *
 * The global transform properties of a node (globalLocation, globalRotation, globalScale)
 * will have accurate values when this method is run, since they are only valid after the
 * transformMatrix has been updated. If you need to make use of the global properties
 * of a node (such as for collision detection), override this method.
 *
 * Since the transformMatrix has already been updated when this method is invoked, if
 * you override this method and make any changes to the transform properties (location,
 * rotation, scale) of any node, you should invoke the updateTransformMatrices method of
 * that node, to have its transformMatrix, and those of its child nodes, recalculated.
 *
 * The specified visitor encapsulates the CC3World instance, to allow this node to interact
 * with other nodes in its world.
 *
 * The visitor also encapsulates the deltaTime, which is the interval, in seconds, since
 * the previous update. This value can be used to create realistic real-time motion that
 * is independent of specific frame or update rates. Depending on the setting of the
 * maxUpdateInterval property of the CC3World instance, the value of dt may be clamped to
 * an upper limit before being passed to this method. See the description of the CC3World
 * maxUpdateInterval property for more information about clamping the update interval.
 *
 * As described in the class documentation, in keeping with best practices, updating the
 * model state should be kept separate from frame rendering. Therefore, when overriding
 * this method in a subclass, do not perform any drawing or rending operations. This
 * method should perform model updates only.
 *
 * This method is invoked automatically at each scheduled update. Usually, the application
 * never needs to invoke this method directly.
 */
-(void) updateAfterTransform: (CC3NodeUpdatingVisitor*) visitor {}

@end

