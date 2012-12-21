//
//  practiceHomePageController.m
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/3/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import "practiceHomePageController.h"
#import "practiceViewController.h"
#import "practiceAppDelegate.h"

@interface practiceHomePageController ()

@end

@implementation practiceHomePageController
@synthesize user;
@synthesize imgUser;
@synthesize imagePath;

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
     NSString *welcomeNote = @"Hi";
    // practiceAppDelegate *appDelegate = (practiceAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.lblWelcome.text = [welcomeNote stringByAppendingString:self.user];
    [imgUser setImage:[UIImage imageNamed:imagePath]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.lblWelcome setText:self.user];
}


@end
