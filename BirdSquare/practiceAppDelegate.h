//
//  practiceAppDelegate.h
//  BirdSquare
//
//  Created by Renu Ahlawat on 12/3/12.
//  Copyright (c) 2012 Renu Ahlawat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface practiceAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableString *uname;
}

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic)NSMutableString *uname;

@end
