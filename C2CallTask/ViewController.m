//
//  ViewController.m
//  C2CallTask
//
//  Created by Darius Miliauskas on 15/05/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    
    @end

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self run];
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Simulator.");
#else
    // Device
#endif
    
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)run {
    [[C2CallPhone currentPhone] submitMessage:@"Hi, this is an SMS." toNumber:@"37065268789"];
    NSLog(@"Done");
}
    
@end


/*
 http://stackoverflow.com/questions/24050012/error-library-not-found-for
 http://stackoverflow.com/questions/21631313/xcode-project-vs-xcode-workspace-differences
 http://sdkdocs.ios.c2call.com/Release-Notes.txt
 
 */
