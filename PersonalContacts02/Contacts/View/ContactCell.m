//
//  ContactCell.m
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/23.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import "ContactCell.h"

@interface ContactCell ()

@property (nonatomic, weak) UIView *divider;

@end

@implementation ContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    [self.contentView addSubview: divider];
    self.divider = divider;
    
    //设置子控件的 frame
    CGFloat dividerX = 0;
    CGFloat dividerY = self.frame.size.height - 1;
    CGFloat dividerW = self.frame.size.width;
    CGFloat dividerH = 1;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTalbeView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setContact:(Contact *)contact {
    _contact = contact;
    
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.number;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
