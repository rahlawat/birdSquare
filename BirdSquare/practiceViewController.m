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

@interface practiceViewController ()

@end

@implementation practiceViewController

@synthesize user;

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
        practiceHomePageController *homePageController = [[practiceHomePageController alloc] initWithNibName:@"practiceHomePageController" bundle:nil];
        [homePageController setUser:self.user];
        [self.navigationController pushViewController:homePageController animated:YES];
       // [homePageController release];
//        practiceAppDelegate *appDelegate = (practiceAppDelegate *)[[UIApplication sharedApplication] delegate];
//        [appDelegate.uname setString:self.txtUsername.text];
       // user = self.txtUsername.text;
        [self performSegueWithIdentifier:@"navigate" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Please check username/password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"prepareForSegue: %@", segue.identifier);
//    
//    if([segue.identifier isEqualToString:@"userHome"]){
//        [segue.destinationViewController setUserName:self.txtUsername.text];
//    }
//}

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
