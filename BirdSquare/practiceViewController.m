//
//  practiceViewController.m
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/3/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import "practiceViewController.h"

@interface practiceViewController ()

@end

@implementation practiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSignIn:(id)sender {
    BOOL isValidUserOne = [self.txtUsername.text isEqualToString: @"Renu"] && [self.txtPassword.text isEqualToString: @"123456"];
      BOOL isValidUserTwo = [self.txtUsername.text isEqualToString: @"Priyanka"] && [self.txtPassword.text isEqualToString: @"123456"];
    if(isValidUserOne || isValidUserTwo){
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Please check username/password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}
@end
