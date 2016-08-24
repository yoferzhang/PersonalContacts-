//
//  EditViewController.h
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/23.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact, EditViewController;

@protocol EditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(EditViewController *)editViewController addContact:(Contact *)contact;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) Contact *contact;

@property (nonatomic, strong) id<EditViewControllerDelegate> delegate;

@end
