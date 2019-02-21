//
//  ViewContato.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "ViewContato.h"
#import "SWRevealViewController.h"
#import <sys/utsname.h>
#import "Map.h"


@interface ViewContato ()

@end

@implementation ViewContato

@synthesize contato;
@synthesize contarumamigo;
@synthesize site;

@synthesize ViewApper;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    contato.layer.cornerRadius = 10.0f;
    contato.layer.masksToBounds = YES;
    
    contarumamigo.layer.cornerRadius = 10.0f;
    contarumamigo.layer.masksToBounds = YES;

    site.layer.cornerRadius = 10.0f;
    site.layer.masksToBounds = YES;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    self.title = @"Developed by";
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //    [self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)BtnComoChegar:(id)sender {
    NSString * Endereco = @"Rua Galileu Galilei, 1227  - Ribeirão Preto, SP";
    
    Map * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"1234"];
    
    vc.endereco = Endereco;
    vc.cinema = @"Guia Saúde Aqui";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)BtnEnviarEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Contato - iOS"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"comercial@apppromastersolution.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                        message:@"Este dispositivo não suporta o envio de e-mail."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)btnFace:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/promastersolution/"]];
}

- (IBAction)btnWebSite:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.promastersolution.com.br/"]];
}

- (IBAction)btnLigar:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:16992318863"]];
}


@end
