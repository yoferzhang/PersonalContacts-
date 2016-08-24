//
//  ContactCell.h
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/23.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactCell : UITableViewCell

@property (nonatomic, strong) Contact *contact;

+ (instancetype)cellWithTalbeView:(UITableView *)tableView;

@end
