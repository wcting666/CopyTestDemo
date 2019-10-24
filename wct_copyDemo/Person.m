//
//  Person.m
//  wct_copyDemo
//
//  Created by Wcting on 2019/10/24.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import "Person.h"

@implementation Person

-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ age:%@ gender:%@",self.name,self.age,self.gender];
}

-(id)copyWithZone:(NSZone *)zone
{
    Person *copy = [[Person allocWithZone:zone] init];
    if (copy) {
        copy.name = [self.name copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.gender = [self.gender copyWithZone:zone];

    }
    return copy;
}

@end
