//
//  RootViewController.h
//  Books
//
//  Created by 村上 幸雄 on 12/04/07.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Document.h"

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) Document              *document;

@end
