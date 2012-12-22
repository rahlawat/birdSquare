//
//  DatabaseHandler.m
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/22/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import "DatabaseHandler.h"
#import <sqlite3.h>


@implementation DatabaseHandler

static DatabaseHandler *_instance = nil;

+ (DatabaseHandler *)instance
{
    if (!_instance) _instance = [DatabaseHandler new];
    return _instance;
}

-(void)createDatabaseIfDoesNotExists
{
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
    }

}

- (NSString *) findContact:(NSString *)userName
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSString *passwordField;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, password FROM contacts WHERE name=\"%@\"",
                              userName];
        
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

-(NSString *)saveUser:(NSString *)userName withPassword:(NSString *)password
{
    sqlite3_stmt    *statement;
    NSString *message = @"";
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, password) VALUES (\"%@\", \"%@\")",
                               userName, password];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            message = [message stringByAppendingString:@"Success"];
            
        }
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Problem saving the User." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        message = [message stringByAppendingString:@"Failure"];
    }
    sqlite3_finalize(statement);
    sqlite3_close(_contactDB);
    return message;
}

-(NSString *)checkIfUserExists:(NSString *)userName
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSString *message = @"";
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, password FROM contacts WHERE name=\"%@\"",
                              userName];
        
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
