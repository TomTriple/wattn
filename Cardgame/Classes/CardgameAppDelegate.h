//
//  CardgameAppDelegate.h
//  Cardgame
//
//  Created by tom hoefer on 04.12.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNodeController.h"
#import "CC3World.h"

@interface CardgameAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow* window;
	CCNodeController* viewController;
}

@property (nonatomic, retain) UIWindow* window;

@end
