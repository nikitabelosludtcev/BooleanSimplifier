//
//  Algo.h
//  BooleanFunctionsSimplifier
//
//  Created by Nikita Belosludcev on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Algo : NSObject
{
    NSMutableArray *finalArray;
}
@property(nonatomic, retain)     NSMutableArray *finalArray;

-(NSMutableArray*)makeComputeWithArray:(NSMutableArray*) array;
@end
