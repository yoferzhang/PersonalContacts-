//
//  Contact.h
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/23.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;

@end
