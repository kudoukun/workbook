//
//  ViewController.m
//  Dialog
//
//  Created by 村上 幸雄 on 12/05/28.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import "ModalPaneViewController.h"
#import "ViewController.h"

@interface ViewController ()
- (void)didDone:(id)arg;
- (void)didCancel:(id)arg;
- (void)performDismiss:(NSTimer *)theTimer;
@end

@implementation ViewController

@synthesize modalPaneView = _modalPaneView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.modalPaneView.hidden = YES;
}

- (void)viewDidUnload
{
    self.modalPaneView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)alertImage:(id)sender
{
    DBGMSG(@"%s", __func__);
    UIImage *image = [UIImage imageNamed:@"likeness.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(10.0, 80.0, 100.0, 100.0);
    
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"Alert Image";
    alertView.message = @"a likeness";
    [alertView addSubview:imageView];
    [alertView addButtonWithTitle:@"NO"];
    [alertView addButtonWithTitle:@"YES"];
    alertView.cancelButtonIndex = 0;
    [alertView show];
}

- (IBAction)modalPane:(id)sender
{
    DBGMSG(@"%s", __func__);
#if 0
    ModalPaneViewController *modalPaneViewController
        = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalPaneViewController"];
        /*
        = [[ModalPaneViewController alloc] initWithNibName:@"ModalPaneViewController" bundle:nil];
        */
    [modalPaneViewController setCompletionHandler:^(ModalPaneViewControllerResult result) {
        switch (result) {
            case ModalPaneViewControllerResultCancelled:
                [self performSelectorOnMainThread:@selector(didCancel:) withObject:nil waitUntilDone:NO];
                break;
            case ModalPaneViewControllerResultDone:
                [self performSelectorOnMainThread:@selector(didDone:) withObject:nil waitUntilDone:NO];
                break;
            default:
                break;
        }
        
        [self dismissModalViewControllerAnimated:YES];
    }];
    [self presentModalViewController:modalPaneViewController animated:YES];
#endif  /* 0 */
    self.modalPaneView.hidden = NO;
}

- (IBAction)alertDismiss:(id)sender
{
    DBGMSG(@"%s", __func__);
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"Alert Dismiss";
    alertView.message = @"\n\ndismiss alert";
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self
                                   selector:@selector(performDismiss:)
                                   userInfo:alertView repeats:NO];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DBGMSG(@"%s, buttonIndex(%d)", __func__, (int)buttonIndex);
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    CGRect  frame = alertView.frame;
    frame.origin.y -= 50.0;
    frame.size.height += 100.0;
    alertView.frame = frame;
    
    for (UIView* view in alertView.subviews) {
        frame = view.frame;
        if (frame.origin.y > 80) {
            frame.origin.y += 100;
            view.frame = frame;
        }
    }
}

- (IBAction)done:(id)sender
{
    DBGMSG(@"%s", __func__);
    self.modalPaneView.hidden = YES;
}

- (IBAction)cancel:(id)sender
{
    DBGMSG(@"%s", __func__);
    self.modalPaneView.hidden = YES;
}

#pragma mark - private

- (void)didDone:(id)arg
{
    DBGMSG(@"%s", __func__);
}

- (void)didCancel:(id)arg
{
    DBGMSG(@"%s", __func__);
}

- (void)performDismiss:(NSTimer *)theTimer
{
    DBGMSG(@"%s", __func__);
    UIAlertView *alertView = [theTimer userInfo];
    [alertView dismissWithClickedButtonIndex:0 animated:NO];
}

#pragma mark - ModalPaneViewControllerDelegate

- (void)modalPaneViewControllerDidDone:(ModalPaneViewController *)modalPaneViewController
{
    DBGMSG(@"%s", __func__);
    [self dismissModalViewControllerAnimated:YES];
}

- (void)modalPaneViewControllerDidCancel:(ModalPaneViewController *)modalPaneViewController
{
    DBGMSG(@"%s", __func__);
    [self dismissModalViewControllerAnimated:YES];
}

@end
