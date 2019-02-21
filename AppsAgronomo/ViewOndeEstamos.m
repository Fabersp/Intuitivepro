//
//  ViewOndeEstamos.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 24/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import "ViewOndeEstamos.h"
#import "SWRevealViewController.h"

@interface ViewOndeEstamos ()

@end

@implementation ViewOndeEstamos


@synthesize ViewApper;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    
    [self.navigationController.view addSubview:ViewApper];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

- (IBAction)btnTelefone:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:3535317988"]];
}


@end
