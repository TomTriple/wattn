//
//  Card.m
//  Cardgame
//
//  Created by tom hoefer on 07.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Card.h"


@implementation Card
@synthesize color, value; 

-(NSString *)toString {
    // schlecht - besser als static/extern, damit diese arrays nur einmal angelegt werden
    NSMutableArray* colors = [[NSMutableArray alloc] initWithObjects:@"Herz", @"Gras", @"Schelle", @"Eichel", nil];
    NSMutableArray* values = [[NSMutableArray alloc] initWithObjects:@"Sieben", @"Acht", @"Neun", @"Zehn", @"Unter", @"Ober", @"König", @"Ass", nil];
    
    return [NSString stringWithFormat:@"%@ %@", [colors objectAtIndex:color], [values objectAtIndex:value]]; 
    
}

@end
