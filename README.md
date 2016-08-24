## 私人通讯录

### 写在前面

本 Demo 简单演示了一些小控件的应用。

- 比如导航栏的设置；
- 界面全部是代码写的，没有用stroyboard。
- UITextField，UILabel，UIButton等小控件的精确控制；
- 页面之间的数据传输；
- 数据的本地化存储；
- UITableView 的添加删除Cell
- 在系统提供样式的Cell中代码添加自定义View
- 利用第三方控件模拟网络请求等待，就是转菊花

### 简单演示

<center>
![](http://ww1.sinaimg.cn/mw690/a9c4d5f6gw1f74wg7775tg20dc0o54qs.gif)
</center>

<center>
![](http://ww2.sinaimg.cn/mw690/a9c4d5f6gw1f74wg3rbw8g20dc0o5e82.gif)
</center>

<center>
![](http://ww4.sinaimg.cn/mw690/a9c4d5f6gw1f74wg1374dg20dc0o5qv7.gif)
</center>

<center>
![](http://ww2.sinaimg.cn/mw690/a9c4d5f6gw1f74wfxumj5g20dc0o57wj.gif)
</center>


### 运行环境

运行环境为 Xcode 7.3，iOS 9.3

工程中用了cocoapods，工程入口为根目录下：PersonalContacts02.xcworkspace


### 流水账

下面只是简单记录了一些代码生成的过程和思想：

AppDelegate.m

```objc
#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainNavigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
```

HomeViewController.m

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBar];
    [self drawLabelAndText];
}

#pragma mark - 设置导航栏

- (void)setNavigationBar
{
    self.navigationItem.title = @"私人通讯录";
}

#pragma mark - 绘制登录界面

- (void)drawLabelAndText
{
    CGFloat accountLabelX = self.view.bounds.size.width / 10.0;
    CGFloat accountLabelY = 64 + self.view.bounds.size.width / 10.0;
    CGFloat accountLabelW = accountLabelX;
    CGFloat accountLabelH = 20;
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(accountLabelX, accountLabelY, accountLabelW, accountLabelH)];
    accountLabel.text = @"账号";
    [self.view addSubview:accountLabel];
    
    CGFloat passwordLabelX = accountLabelX;
    CGFloat passwordLabelY = accountLabelY + accountLabelH + 20;
    CGFloat passwordLabelW = accountLabelW;
    CGFloat passwordLabelH = accountLabelH;
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(passwordLabelX, passwordLabelY, passwordLabelW, passwordLabelH)];
    passwordLabel.text = @"密码";
    [self.view addSubview:passwordLabel];
    
    CGFloat accountTextFieldX = accountLabelX + accountLabelW + 40;
    CGFloat accountTextFieldY = accountLabelY;
    CGFloat accountTextFieldW = self.view.bounds.size.width / 2.0;
    CGFloat accountTextFieldH = accountLabelH;
    UITextField *accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(accountTextFieldX, accountTextFieldY, accountTextFieldW, accountTextFieldH)];
    accountTextField.placeholder = @"请输入账号(*)";
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:accountTextField];
    [self.view addSubview:accountTextField];
    
    CGFloat passwordTextFieldX = accountTextFieldX;
    CGFloat passwordTextFieldY = passwordLabelY;
    CGFloat passwordTextFieldW = accountTextFieldW;
    CGFloat passwordTextFieldH = accountLabelH;
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH)];
    passwordTextField.placeholder = @"请输入密码(*)";
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:passwordTextField];
    [self.view addSubview:passwordTextField];
    
    CGFloat remeberPasswordLabelX = accountLabelX;
    CGFloat remeberPasswordLabelY = passwordLabelY + passwordLabelH + 25;
    CGFloat remeberPasswordLabelW = passwordLabelW + 40;
    CGFloat remeberPasswordLabelH = accountLabelH;
    UILabel *remeberPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(remeberPasswordLabelX, remeberPasswordLabelY, remeberPasswordLabelW, remeberPasswordLabelH)];
    remeberPasswordLabel.text = @"记住密码";
    [self.view addSubview:remeberPasswordLabel];
    
    CGFloat remeberPasswordSwitchX = remeberPasswordLabelX + remeberPasswordLabelW;
    CGFloat remeberPasswordSwitchY = passwordLabelY + passwordLabelH + 20;
    CGFloat remeberPasswordSwitchW = remeberPasswordLabelW;
    CGFloat remeberPasswordSwitchH = accountLabelH;
    UISwitch *remeberPasswordSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(remeberPasswordSwitchX, remeberPasswordSwitchY, remeberPasswordSwitchW, remeberPasswordSwitchH)];
    [self.view addSubview:remeberPasswordSwitch];
    
    CGFloat automaticLogonLabelX = remeberPasswordSwitchX + remeberPasswordSwitchW;
    CGFloat automaticLogonLabelY = passwordLabelY + passwordLabelH + 25;
    CGFloat automaticLogonLabelW = passwordLabelW + 40;
    CGFloat automaticLogonLabelH = accountLabelH;
    UILabel *automaticLogonLabel = [[UILabel alloc] initWithFrame:CGRectMake(automaticLogonLabelX, automaticLogonLabelY, automaticLogonLabelW, automaticLogonLabelH)];
    automaticLogonLabel.text = @"自动登录";
    [self.view addSubview:automaticLogonLabel];
    
    CGFloat automaticLogonSwitchX = automaticLogonLabelX + automaticLogonLabelW;
    CGFloat automaticLogonSwitchY = passwordLabelY + passwordLabelH + 20;
    CGFloat automaticLogonSwitchW = remeberPasswordLabelW;
    CGFloat automaticLogonSwitchH = accountLabelH;
    UISwitch *automaticLogonSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(automaticLogonSwitchX, automaticLogonSwitchY, automaticLogonSwitchW, automaticLogonSwitchH)];
    [self.view addSubview:automaticLogonSwitch];
    
    CGFloat logButtonX = self.view.bounds.size.width / 2.0 - 40;
    CGFloat logButtonY = remeberPasswordLabelY + 40;
    CGFloat logButtonW = 80;
    CGFloat logButtonH = accountLabelH;
    UIButton *logButton = [[UIButton alloc] initWithFrame:CGRectMake(logButtonX, logButtonY, logButtonW, logButtonH)];
    [logButton setTitle:@"登录" forState:UIControlStateNormal];
    [logButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [logButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    [logButton addTarget:self action:@selector(pushToContactsViewController) forControlEvents:UIControlEventTouchUpInside];
    [logButton setEnabled:YES];
    [self.view addSubview:logButton];
}

#pragma mark - 登录按钮响应事件方法

- (void)pushToContactsViewController
{
    ContactsViewController *contactsViewController = [[ContactsViewController alloc] init];
    
    [self.navigationController pushViewController:contactsViewController animated:YES];
}

// 记得移除监听
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
```

添加属性：

```objc
@interface HomeViewController ()

@property(nonatomic, weak) UIButton *logButton;

@end
```

记得将button赋值

```objc
    [self.view addSubview:logButton];
    self.logButton = logButton;
}
```

```objc
/*
 * 文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    self.logButton.enabled = (self.accountTextField.text.length && self.passwordTextField.text.length);
}
```

将添加事件响应拿出来放到单独的方法中：

```objc
#pragma mark - 添加文本框和按钮的响应事件，或者通知

- (void)addTarget
{
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountTextField];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    
    // 登录按钮添加响应事件
    [self.logButton addTarget:self action:@selector(pushToContactsViewController) forControlEvents:UIControlEventTouchUpInside];
    
    // 给开关添加响应方法
    [self.remeberPasswordSwitch addTarget:self action:@selector(remeberPasswordChange) forControlEvents:UIControlEventValueChanged];
    [self.automaticLogonSwitch addTarget:self action:@selector(automaticLogonChange) forControlEvents:UIControlEventValueChanged];
}
```

完成两个方法

```objc
- (void)remeberPasswordChange
{
    if (self.remeberPasswordSwitch.isOn == NO) {
        self.automaticLogonSwitch.on = NO;
    }
}

- (void)automaticLogonChange
{
    if (self.automaticLogonSwitch.isOn) {
        self.remeberPasswordSwitch.on = YES;
    }
}
```


ContactsViewController.m

```objc
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
```

HomeViewController.m

使用第三方库 SVProgressHUD

然后重新写登录按钮的响应方法

```objc
- (void)pushToContactsViewController
{
    if (![self.accountTextField.text isEqualToString:@"yofer"]) {
        // 账号不存在
        [SVProgressHUD showErrorWithStatus:@"账号不存在"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (![self.passwordTextField.text isEqualToString:@"666"]) {
        // 密码错误
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在加载..."]; // 这是转菊花的样式
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        ContactsViewController *contactsViewController = [[ContactsViewController alloc] init];
        contactsViewController.title = [NSString stringWithFormat:@"%@的联系人列表", self.accountTextField.text];
        [self.navigationController pushViewController:contactsViewController animated:YES];
    });
}
```

更改一下开关的关闭打开，设置动画

```objc
- (void)remeberPasswordChange
{
    if (self.remeberPasswordSwitch.isOn == NO) {
//        self.automaticLogonSwitch.on = NO;
        [self.automaticLogonSwitch setOn:NO animated:YES];
    }
}

- (void)automaticLogonChange
{
    if (self.automaticLogonSwitch.isOn) {
//        self.remeberPasswordSwitch.on = YES;
        [self.remeberPasswordSwitch setOn:YES animated:YES];
    }
}
```

AddViewController.m

```objc
#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    [self drawLabel];
}

- (void)setNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加联系人";
//    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
}

- (void)drawLabel
{
    CGFloat nameLabelX = self.view.bounds.size.width / 10.0;
    CGFloat nameLabelY = 64 + self.view.bounds.size.width / 10.0;
    CGFloat nameLabelW = nameLabelX;
    CGFloat nameLabelH = 20;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
    nameLabel.text = @"姓名";
    [self.view addSubview:nameLabel];
    
    CGFloat numberLabelX = nameLabelX;
    CGFloat numberLabelY = nameLabelY + nameLabelH + 20;
    CGFloat numberLabelW = nameLabelW;
    CGFloat numberLabelH = nameLabelH;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH)];
    numberLabel.text = @"电话";
    [self.view addSubview:numberLabel];
    
    CGFloat nameTextFieldX = nameLabelX + nameLabelW + 40;
    CGFloat nameTextFieldY = nameLabelY;
    CGFloat nameTextFieldW = self.view.bounds.size.width / 2.0;
    CGFloat nameTextFieldH = nameLabelH;
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH)];
    nameTextField.placeholder = @"请输入姓名(*)";
    [self.view addSubview:nameTextField];
    
    CGFloat numberTextFieldX = nameTextFieldX;
    CGFloat numberTextFieldY = numberLabelY;
    CGFloat numberTextFieldW = nameTextFieldW;
    CGFloat numberTextFieldH = nameLabelH;
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(numberTextFieldX, numberTextFieldY, numberTextFieldW, numberTextFieldH)];
    numberTextField.placeholder = @"请输入电话(*)";
    numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:numberTextField];

    CGFloat addButtonX = self.view.bounds.size.width / 2.0 - 60;
    CGFloat addButtonY = numberTextFieldY + 40;
    CGFloat addButtonW = 120;
    CGFloat addButtonH = nameLabelH;
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(addButtonX, addButtonY, addButtonW, addButtonH)];
    [addButton setTitle:@"登录" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addButton setEnabled:NO];
    [self.view addSubview:addButton];
    self.addButton = addButton;
}


@end
```

修改 ContactsViewController.m 中的方法，将下一个视图的左上角按钮设置为返回

```objc
- (void)pushToAddViewController
{
    AddViewController *addViewController = [[AddViewController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:addViewController animated:YES];
}
```

为了已进入添加界面，就弹出键盘，在 AddViewController.m 中

```objc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // 让文本框成为第一响应者
    [self.nameTextField becomeFirstResponder];
}
```

添加代理，回传值

```objc
#import <UIKit/UIKit.h>

@class Contact, AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addViewController:(AddViewController *)addViewController addContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController

@property (nonatomic, strong) id<AddViewControllerDelegate> delegate;

@end
```

AddViewController.m 中

```objc
#pragma mark - 调用 AddViewControllerDelegate 代理方法
- (void)addContacts
{
    // 回传数据
    if ([self.delegate respondsToSelector:@selector(addViewController:addContact:)]) {
        Contact *contact = [[Contact alloc] init];
        contact.name = self.nameTextField.text;
        contact.number = self.numberTextField.text;
        [self.delegate addViewController:self addContact:contact];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
```

ContactsViewController.m

添加代理

```objc
@interface ContactsViewController () <UIActionSheetDelegate, AddViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end
```

设置代理

```objc
- (void)pushToAddViewController
{
    AddViewController *addViewController = [[AddViewController alloc] init];
    addViewController.delegate = self;
    
    // 设置addViewController页面左上角的返回按钮文字
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:addViewController animated:YES];
}
```

```objc
#pragma mark - 实现 AddViewControllerDelegate 代理方法
- (void)addViewController:(AddViewController *)addViewController addContact:(Contact *)contact
{
    [self.contacts addObject:contact];
    
    [self.tableView reloadData];
}

#pragma mark - TableView 数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    // 设置Cell数据
    Contact *contact = self.contacts[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.number;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
```


EditViewController.h

```objc
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
```

EditViewController.m


```objc
#import "EditViewController.h"
#import "Contact.h"

@interface EditViewController ()

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    [self drawLabel];
    [self addTarget];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    
//    // 让文本框成为第一响应者
//    [self.nameTextField becomeFirstResponder];
//}

- (void)setNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"查看联系人";
    //    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
    
    // 设置右上角的按钮
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editContact)];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

#pragma mark - 右上角编辑按钮的响应方法

- (void)editContact
{
    if (self.nameTextField.enabled) { // 点击的是“取消”
        self.nameTextField.enabled = NO;
        self.numberTextField.enabled = NO;
        self.nameTextField.text = self.contact.name;
        self.numberTextField.text = self.contact.number;
        [self.saveButton setHidden:YES];
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    } else { // 点击的是 "编辑"
        self.nameTextField.enabled = YES;
        self.numberTextField.enabled = YES;
        
        // 让文本框成为第一响应者
        [self.numberTextField becomeFirstResponder];
        [self.saveButton setHidden:NO];
        self.navigationItem.rightBarButtonItem.title = @"取消";
    }

}

#pragma mark - 添加label和button

- (void)drawLabel
{
    CGFloat nameLabelX = self.view.bounds.size.width / 10.0;
    CGFloat nameLabelY = 64 + self.view.bounds.size.width / 10.0;
    CGFloat nameLabelW = nameLabelX;
    CGFloat nameLabelH = 20;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
    nameLabel.text = @"姓名";
    [self.view addSubview:nameLabel];
    
    CGFloat numberLabelX = nameLabelX;
    CGFloat numberLabelY = nameLabelY + nameLabelH + 20;
    CGFloat numberLabelW = nameLabelW;
    CGFloat numberLabelH = nameLabelH;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH)];
    numberLabel.text = @"电话";
    [self.view addSubview:numberLabel];
    
    CGFloat nameTextFieldX = nameLabelX + nameLabelW + 40;
    CGFloat nameTextFieldY = nameLabelY;
    CGFloat nameTextFieldW = self.view.bounds.size.width / 2.0;
    CGFloat nameTextFieldH = nameLabelH;
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH)];
    nameTextField.placeholder = @"请输入姓名(*)";
    nameTextField.text = self.contact.name;
    nameTextField.enabled = NO;
    [self.view addSubview:nameTextField];
    self.nameTextField = nameTextField;
    
    CGFloat numberTextFieldX = nameTextFieldX;
    CGFloat numberTextFieldY = numberLabelY;
    CGFloat numberTextFieldW = nameTextFieldW;
    CGFloat numberTextFieldH = nameLabelH;
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(numberTextFieldX, numberTextFieldY, numberTextFieldW, numberTextFieldH)];
    numberTextField.placeholder = @"请输入电话(*)";
    numberTextField.text = self.contact.number;
    numberTextField.enabled = NO;
    numberTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:numberTextField];
    self.numberTextField = numberTextField;
    
    CGFloat saveButtonX = self.view.bounds.size.width / 2.0 - 60;
    CGFloat saveButtonY = numberTextFieldY + 40;
    CGFloat saveButtonW = 120;
    CGFloat saveButtonH = nameLabelH;
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(saveButtonX, saveButtonY, saveButtonW, saveButtonH)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveButton setEnabled:NO];
    [saveButton setHidden:YES];
    [self.view addSubview:saveButton];
    self.saveButton = saveButton;
}

#pragma mark - 添加响应事件

- (void)addTarget
{
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
    
    // 登录按钮添加响应事件
    [self.saveButton addTarget:self action:@selector(saveContact) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 调用 AddViewControllerDelegate 代理方法
- (void)saveContact
{
    // 回传数据
    if ([self.delegate respondsToSelector:@selector(editViewController:addContact:)]) {
        self.contact.name = self.nameTextField.text;
        self.contact.number = self.numberTextField.text;
        [self.delegate editViewController:self addContact:self.contact];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    self.saveButton.enabled = (self.nameTextField.text.length && self.numberTextField.text.length);
}

@end
```

ContactsViewController.m

```objc
#pragma mark - 实现 editViewControllerDelegate 代理方法
- (void)editViewController:(EditViewController *)editViewController addContact:(Contact *)contact
{
    [self.tableView reloadData];
}

```

实现数据存储 Contact.h


记得必须遵守 NSCoding 协议

```objc
#import <Foundation/Foundation.h>

@interface Contact : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;

@end
```

然后实现下面两个方法

Contact.m

```objc
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
```

数据存放的地方
ContactsViewController.m

```objc
// 数据存放路径
#define ContactsFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]
```

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadContactData];
    [self setNavigationBar];
    [self setTableViewLine];
}

```


```objc
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
```

```objc
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
```

语言调整为中文，虽然把模拟器设置成中文，可还要把工程中添加中文配置才可以

<center>
![](http://ww2.sinaimg.cn/mw690/a9c4d5f6gw1f74tjx41xgj218y0nujv9.jpg)
</center>

更换一下删除操作后刷新表格的方式，不需要全部刷新，只要删掉一行就行

```objc
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.删除数据
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        // 2.刷新表格
//        [self.tableView reloadData];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        // 3.归档
        [self archiverContactData];
    }
}
```










