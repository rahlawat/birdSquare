//
//  practiceViewController.m
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/3/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import "practiceViewController.h"
#import "practiceHomePageController.h"
#import "practiceAppDelegate.h"
#import <sqlite3.h>
#import "practiceCreateAccountController.h"
#import "DatabaseHandler.h"

@interface practiceViewController ()

@end

@implementation practiceViewController

@synthesize user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DatabaseHandler instance] createDatabaseIfDoesNotExists];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSignIn:(id)sender {
    NSString *savedUserPassowrd = [[DatabaseHandler instance] findContact:self.txtUsername.text];
    if(([savedUserPassowrd isEqualToString:self.txtPassword.text]) && (![self.txtPassword.text isEqualToString:@""])){
        [self performSegueWithIdentifier:@"navigate" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Please check username/password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"navigate"]) {
        UITabBarController *tabController = segue.destinationViewController;
        UINavigationController *navigationController = (UINavigationController *)[[tabController customizableViewControllers] objectAtIndex:0];
        practiceHomePageController *homeController = (practiceHomePageController *)navigationController.topViewController;
        homeController.user = self.txtUsername.text;
        homeController.imagePath = @"background.jpg";
    }
    if ([segue.identifier isEqualToString:@"createAccount"]) {
        practiceCreateAccountController *createAccountController = segue.destinationViewController;
        createAccountController.databasePath = self.databasePath;
        createAccountController.contactDB = self.contactDB;
    }

}

- (IBAction)createAccount:(id)sender {
      [self performSegueWithIdentifier:@"createAccount" sender:self]; 
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.user = [textField text];
    return YES;
}
@end
