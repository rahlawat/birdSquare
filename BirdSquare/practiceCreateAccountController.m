//
//  practiceCreateAccountController.m
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/17/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import "practiceCreateAccountController.h"
#import <sqlite3.h>

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
   NSString *msg = [self checkIfUserExists];
    if([msg isEqualToString:@""])
    {
    [self saveUser];
    }
    else
    {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
   }

-(void)saveUser
{
    sqlite3_stmt    *statement;
    const char *dbpath = [databasePath UTF8String];
    if ((sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) && ([self.txtPassword.text isEqualToString:self.txtConfirmPassword.text]))
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, password) VALUES (\"%@\", \"%@\")",
                               self.txtUsername.text, self.txtPassword.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            [self performSegueWithIdentifier:@"loginAfterCreateAccount" sender:self];
            
        }
    }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Passwords do not match." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }

-(NSString *)checkIfUserExists
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSString *message = @"";
    
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
              message = [message stringByAppendingString:@"User already exists"];
            }
            else
            {
               
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }

    return message;
}
@end
