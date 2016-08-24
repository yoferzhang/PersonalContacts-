//
//  Contact.m
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/23.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.number forKey:@"number"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.number = [decoder decodeObjectForKey:@"number"];
    }
    
    return self;
}

@end
