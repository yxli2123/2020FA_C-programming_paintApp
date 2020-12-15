//
//  MBProgressHUD+XMG.h
//  Paint
//
//  Created by MacBook on 2020/11/18.
//  Copyright © 2020年 MacBook. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XMG)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
