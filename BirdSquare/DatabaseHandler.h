//
//  DatabaseHandler.h
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/22/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DatabaseHandler : NSObject

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (weak, nonatomic) IBOutlet UILabel *status;

+ (DatabaseHandler *)instance;
- (void)createDatabaseIfDoesNotExists;
- (NSString *) findContact:(NSString *)userName;
-(NSString *)saveUser:(NSString *)userName withPassword:(NSString *)password;
-(NSString *)checkIfUserExists:(NSString *)userName;
@end
