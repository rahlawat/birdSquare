//
//  practiceHomePageController.h
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/3/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface practiceHomePageController : UIViewController
{
    NSString *user;
}
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@property (weak, nonatomic) IBOutlet UITableView *tblBirdsCheckedIn;
@property (nonatomic, retain) NSString *user;

-(void)setUserName: (NSString*)userName;

@end
