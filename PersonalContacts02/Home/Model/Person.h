//
//  Person.h
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/24.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) float height;

@end
