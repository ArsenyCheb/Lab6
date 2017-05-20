//
//  main.m
//  lab6_task1
//
//  Created by Arseny Cheb on 11.05.17.
//  Copyright © 2017 Arseny Cheb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Analyser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Analyser* analyser = [[Analyser alloc] init];
        char str[256];
        printf("Enter string: \n");
        fgets(str, 256, stdin);
        NSString * words =[NSString stringWithUTF8String:str];
        [analyser foo: [words substringToIndex: [words length]-1]];
        
        return 0;
    }
}
