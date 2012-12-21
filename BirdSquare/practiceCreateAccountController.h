//
//  practiceCreateAccountController.h
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/17/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface practiceCreateAccountController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
- (IBAction)createAccount:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
-(void)saveUser;
-(NSString *)checkIfUserExists;
@end
