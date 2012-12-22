//
//  practiceViewController.h
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/3/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface practiceViewController : UIViewController <UITextFieldDelegate>
{
    NSString * user;
}
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property(nonatomic, retain)NSString *user;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)createAccount:(id)sender;

- (IBAction)btnSignIn:(id)sender;

@end
