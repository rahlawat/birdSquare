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

@interface practiceViewController ()

@end

@implementation practiceViewController

@synthesize user;

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"contacts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (NAME TEXT, PASSWORD TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status.text = @"Failed to create table";
            }
            sqlite3_close(_contactDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSignIn:(id)sender {
    NSString *savedUserPassowrd = [self findContact];
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

- (NSString *) findContact
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSString *passwordField;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, password FROM contacts WHERE name=\"%@\"",
                              self.txtUsername.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                passwordField = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
            }
            else
            {
               passwordField = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
return passwordField;
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
