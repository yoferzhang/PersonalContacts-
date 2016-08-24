//
//  AddViewController.h
//  PersonalContacts02
//
//  Created by yoferzhang on 16/8/23.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact, AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addViewController:(AddViewController *)addViewController addContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController

@property (nonatomic, strong) id<AddViewControllerDelegate> delegate;

@end
