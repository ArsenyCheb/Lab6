//
//  Analyser.m
//  lab6_task1
//
//  Created by Arseny Cheb on 11.05.17.
//  Copyright © 2017 Arseny Cheb. All rights reserved.
//

#import "Analyser.h"

@implementation Analyser

- (void)foo: (NSString*)bar
{
    NSArray *words = [bar componentsSeparatedByString: @" "];
    NSMutableDictionary* statistics = [NSMutableDictionary dictionary];
    
    for (NSString* word in words){
        
        if ([word compare:@""]){
            NSNumber *repetitions = [statistics valueForKey:word];
            [statistics setObject:[[NSNumber alloc] initWithLong:([repetitions integerValue] +1)] forKey:word];
        }
        
    }
    
    NSArray *sortedKeys = [statistics keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    
   
    for (int i = 0; i < 5 && i < [sortedKeys count]; i++)
        NSLog(@"%@: %@", sortedKeys[i], [statistics valueForKey: sortedKeys[i]]);
}
@end
