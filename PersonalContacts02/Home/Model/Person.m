//
//  Person.m
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/24.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInt:self.age forKey:@"age"];
    [encoder encodeFloat:self.height forKey:@"height"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.name = [decoder decodeObjectForKey:@"name"];
    self.age = [decoder decodeIntForKey:@"age"];
    self.height = [decoder decodeFloatForKey:@"height"];
    return self;
}

@end
