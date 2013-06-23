//
//  AlternativeViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 23.06.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "AlternativeViewController.h"

@interface AlternativeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation AlternativeViewController

- (IBAction)save:(id)sender {
  if (self.textField.text.length > 0) {
    [self.delegate alternativeViewController:self didAddAlternative:self.textField.text];
  }
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self.textField becomeFirstResponder];
}

@end
