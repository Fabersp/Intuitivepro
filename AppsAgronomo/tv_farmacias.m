//
//  tv_farmacias.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 01/10/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "tv_farmacias.h"
#import "tv_clientes_especialistas.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface tv_farmacias ()

@end

@implementation tv_farmacias

@synthesize vsEspecialista;
@synthesize vcCor;
@synthesize vsCodCor;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([[segue identifier] isEqualToString:@"segueManipulacao"]) {
        tv_clientes_especialistas * destViewController = segue.destinationViewController;
        destViewController.title = @"FARMÁCIAS DE MANIPULAÇÃO";
        destViewController.vcCor = vcCor;
        destViewController.vsCodCor = vsCodCor;
        destViewController.vsIdCategoria = @"4";
    }
    if ([[segue identifier] isEqualToString:@"segue24h"]) {
        tv_clientes_especialistas * destViewController = segue.destinationViewController;
        destViewController.title = @"DROGRARIAS 24 HORAS";
        destViewController.vcCor = vcCor;
        destViewController.vsCodCor = vsCodCor;
        destViewController.vsIdCategoria = @"41";
    }
    if ([[segue identifier] isEqualToString:@"seguefarmaGeral"]) {
        tv_clientes_especialistas * destViewController = segue.destinationViewController;
        destViewController.title = @"DROGARIAS E FARMÁCIAS";
        destViewController.vcCor = vcCor;
        destViewController.vsCodCor = vsCodCor;
        destViewController.vsIdCategoria = @"40";
    }
    
    
    
}





@end
