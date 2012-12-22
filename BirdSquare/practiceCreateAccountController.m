//
//  practiceCreateAccountController.m
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/17/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import "practiceCreateAccountController.h"
#import <sqlite3.h>
#import "DatabaseHandler.h"

@interface practiceCreateAccountController ()

@end

@implementation practiceCreateAccountController
@synthesize databasePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createAccount:(id)sender {
    NSString *msg = [[DatabaseHandler instance] checkIfUserExists:self.txtUsername.text];
    if([msg isEqualToString:@""])
    {
    if([self.txtPassword.text isEqualToString:self.txtConfirmPassword.text])
    {
       msg = [[DatabaseHandler instance] saveUser:self.txtUsername.text withPassword:self.txtPassword.text];
        if([msg isEqualToString:@"Success"])
        {
                [self performSegueWithIdentifier:@"loginAfterCreateAccount" sender:self];
        }
    }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Passwords do not match." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    else
    {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
   }

@end
