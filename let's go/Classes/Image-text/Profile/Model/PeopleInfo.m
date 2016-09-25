//
//  PeopleInfo.m
//  let's go
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PeopleInfo.h"

@implementation PeopleInfo

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.image forKey:@"icon"];
    [aCoder encodeObject:self.name forKey:@"nicheng"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.image = [aDecoder decodeObjectForKey:@"icon"];
        self.name = [aDecoder decodeObjectForKey:@"nicheng"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
    }
    return self;
}

@end
