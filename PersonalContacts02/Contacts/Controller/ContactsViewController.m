//
//  ContactsViewController.m
//  PersonalContact
//
//  Created by yoferzhang on 16/8/22.
//  Copyright © 2016年 yoferzhang. All rights reserved.
//

#import "ContactsViewController.h"
#import "AddViewController.h"
#import "Contact.h"
#import "EditViewController.h"
#import "ContactCell.h"

// 数据存放路径
#define ContactsFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]


@interface ContactsViewController () <UIActionSheetDelegate, AddViewControllerDelegate, EditViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadContactData];
    [self setNavigationBar];
    [self setTableViewLine];
}

- (NSMutableArray *)contacts {
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    
    return _contacts;
}

#pragma makr - 设置导航栏

- (void)setNavigationBar
{
    [self baseInteractivePopGestureRecognizerEnable:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"联系人列表";
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    
    UIBarButtonItem *addBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushToAddViewController)];
    UIBarButtonItem *deleteBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAllContacts)];
    [self.navigationItem setRightBarButtonItems:@[addBar, deleteBar]];
}

#pragma mark - 导航栏响应方法

/**
 *  点击注销是弹出警告窗口
 */
- (void)logout:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要注销？" message:@"注销将无法查看您的联系人" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)pushToAddViewController
{
    // 设置addViewController页面左上角的返回按钮文字
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    AddViewController *addViewController = [[AddViewController alloc] init];
    addViewController.delegate = self;
    [self.navigationController pushViewController:addViewController animated:YES];
}

- (void)deleteAllContacts
{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

#pragma mark - tableview的分割线隐藏

- (void)setTableViewLine
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  开启 / 关闭 iOS系统原生左滑pop会上一级视图的方法
 *
 *  @param enable YES表示开启，NO表示关闭
 */
-(void)baseInteractivePopGestureRecognizerEnable:(BOOL) enable{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (enable) {
            self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        
    }
}

#pragma mark - 实现 AddViewControllerDelegate 代理方法
- (void)addViewController:(AddViewController *)addViewController addContact:(Contact *)contact
{
    [self.contacts addObject:contact];
    
    [self.tableView reloadData];
    [self archiverContactData];
}

#pragma mark - 实现 editViewControllerDelegate 代理方法
- (void)editViewController:(EditViewController *)editViewController addContact:(Contact *)contact
{
    [self.tableView reloadData];
    [self archiverContactData];
}

#pragma mark - TableView 数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [ContactCell cellWithTalbeView:tableView];
    
    // 设置Cell数据
    cell.contact = self.contacts[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置addViewController页面左上角的返回按钮文字
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    EditViewController *editViewController = [[EditViewController alloc] init];
    // 传递数据给下一个界面
    editViewController.delegate = self;
    editViewController.contact = self.contacts[indexPath.row];
    [self.navigationController pushViewController:editViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.删除数据
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        // 2.刷新表格
//        [self.tableView reloadData];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        // 调用这个方法的时候必须要
        
        // 3.归档
        [self archiverContactData];
    }
}

#pragma mark - 归档数据

- (void)archiverContactData
{
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:ContactsFilepath];
}

#pragma mark - 启动时读取数据

- (void)loadContactData
{
    self.contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactsFilepath];
}


@end
