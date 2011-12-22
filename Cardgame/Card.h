//
//  Card.h
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject 
@property (nonatomic) int color;
@property (nonatomic) int value; 


-(NSString *)toString;
@end