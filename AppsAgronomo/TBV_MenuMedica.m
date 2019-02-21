//
//  TBV_MenuMedica.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 26/08/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "TBV_MenuMedica.h"
#import "tvc_especialistas.h"
#import "tv_farmacias.h"
#import "tv_porPlanoSaude.h"
#import "Reachability.h"
#import <TSMessages/TSMessageView.h>
#import "ViewEdicaoAtual.h"
#import "tv_clientes_especialistas.h"
#import "tvc_todos.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface TBV_MenuMedica ()

@end

@implementation TBV_MenuMedica

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    // Do any additional setup after loading the view.  Codigo cor  1
    // Natigator - cor - rgb(26,188,156) Verde
    verde    = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    // Natigator - cor - rgb(3,169,244) Azul     Codigo cor  2
    azul     = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1];
    // Natigator - cor - rgb(255,82,82) Vermelho   Codigo cor  3
    vermelho = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    // Natigator - cor - rgb(255,199,0) Amarelo   Codigo cor  4
    amarelo  = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:0/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = verde;
    
    //branco botoes do navegador
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSIndexPath *IndexPath = [tableView indexPathForSelectedRow];
    
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    tv_clientes_especialistas * destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"segue_clientes"];
    

    destViewController.vcCor = verde;
    destViewController.vsCodCor = @"1";

    
    // LABORATÓRIO
    if (indexPath.row == 3) {
    
        destViewController.vsIdCategoria = @"70";
        destViewController.title = @"LABORATÓRIOS";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
    // hospitais
    if (indexPath.row == 5) {
        
        destViewController.vsIdCategoria = @"3";
        destViewController.title = @"HOSPITAIS";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
    // PLANOS DE SAÚDE
    if (indexPath.row == 6) {
        
        destViewController.vsIdCategoria = @"5";
        destViewController.title = @"PLANOS DE SAÚDE";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    // PLANOS ODONTOLÓGICOS
    if (indexPath.row == 8) {
        //
        destViewController.vsIdCategoria = @"6";
        destViewController.title = @"PLANOS ODONTOLÓGICOS";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
    // PRODUTOS ORTOPÉDICOS
    if (indexPath.row == 9) {
        //
        destViewController.vsIdCategoria = @"7";
        destViewController.title = @"PRODUTOS ORTOPÉDICOS";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
    // LAR PARA IDOSOS
    if (indexPath.row == 10) {
        //
        destViewController.vsIdCategoria = @"9";
        destViewController.title = @"LAR PARA IDOSOS";
        [self.navigationController pushViewController:destViewController animated:YES];
    }

    // AMBULÂNCIA DE REMOÇÃO
    if (indexPath.row == 11) {
        //
        destViewController.vsIdCategoria = @"11";
        destViewController.title = @"AMBULÂNCIAS DE REMOÇÃO";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
    // ASSOCIAÇÕES BENEFIECIENTES
    if (indexPath.row == 12) {
        destViewController.vsIdCategoria = @"12";   
        destViewController.title = @"ASSOCIAÇÕES BENEFICENTES";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
    // ASSISTÊNCIA DOMICILIAR
    if (indexPath.row == 13) {
        destViewController.vsIdCategoria = @"13";
        destViewController.title = @"ASSISTÊNCIA DOMICILIAR";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
    // USF - UNID. SAÚDE DA FAMÍLIA
    if (indexPath.row == 14) {
        //
        destViewController.vsIdCategoria = @"14";
        destViewController.title = @"USF - UNID. SAÚDE DA FAMÍLIA";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    // TELEFONES ÚTEIS
    if (indexPath.row == 15) {
        destViewController.vsIdCategoria = @"15";
        destViewController.title = @"TELEFONES ÚTEIS";
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    
}

- (IBAction)btnBuscar:(id)sender {
    
    
    tvc_todos * clientes = [self.storyboard instantiateViewControllerWithIdentifier:@"segue_todos"];
    
    clientes.vcCor = verde;
    clientes.vsCodCor = @"1";
    clientes.vsIdCategoria = @"1";
    
    [self.navigationController pushViewController:clientes animated:YES];
    
    
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    // Especialistas
    if ([[segue identifier] isEqualToString:@"segue_especialistas"]) {
        tvc_especialistas * destViewController = segue.destinationViewController;
        destViewController.vsEspecialista = @"1";
        destViewController.vcCor = verde;
        destViewController.vsCodCor = @"1";
        destViewController.title = @"ESPECIALISTAS";
    }
    // Clinicas
    if ([[segue identifier] isEqualToString:@"segue_clinicas"]) {
        tvc_especialistas * destViewController = segue.destinationViewController;
        destViewController.vsEspecialista = @"2";
        destViewController.vcCor = verde;
        destViewController.vsCodCor = @"1";
        destViewController.title = @"CLÍNICAS";
    }
    // odontologia
    if ([[segue identifier] isEqualToString:@"segue_odonto"]) {
        tvc_especialistas * destViewController = segue.destinationViewController;
        destViewController.vsEspecialista = @"8";
        destViewController.vcCor = verde;
        destViewController.vsCodCor = @"1";
        destViewController.title = @"ODONTOLOGIA";
    }
    
    // Farmacias e drogarias
    if ([[segue identifier] isEqualToString:@"segue_Farmacias"]) {
        tv_farmacias * destViewController = segue.destinationViewController;
        destViewController.vcCor = verde;
        destViewController.vsCodCor = @"1";
        destViewController.title = @"DROGARIAS E FARMÁCIAS";
    }
    // plano de saude
    if ([[segue identifier] isEqualToString:@"segue_PorPlano"]) {
        tv_porPlanoSaude * destViewController = segue.destinationViewController;
        destViewController.vcCor = verde;
        destViewController.vsCodCor = @"1";
        destViewController.title = @"POR PLANO DE SAÚDE";
    }
    
    
    
}
- (IBAction)btnFavoristos:(id)sender {
    
    
}

-(void)MensagemErro{
    
    // Add a button inside the message
    [TSMessage showNotificationInViewController:self
                                          title:@"Sem conexão com a intenet"
                                       subtitle:nil
                                          image:nil
                                           type:TSMessageNotificationTypeError
                                       duration:10.0
                                       callback:nil
                                    buttonTitle:nil
                                 buttonCallback:^{
                                     NSLog(@"User tapped the button");
                                     
                                 }
                                     atPosition:TSMessageNotificationPositionTop
                           canBeDismissedByUser:YES];
}


-(void) viewWillAppear:(BOOL)animated
{
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [Reachability reachabilityWithHostName:@"www.revide.com.br"];
    [hostReachable startNotifier];
    
    // now patiently wait for the notification
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) checkNetworkStatus:(NSNotification *)notice {
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable: {
            
            self->internetActive = NO;
            [self MensagemErro];
            
            break;
        }
        case ReachableViaWiFi: {
            self->internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN: {
            
            self->internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus) {
        case NotReachable: {
            NSLog(@"Estamos com instabilidade no site neste momento, tente mais tarde...");
            self->hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi: {
            self->hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN: {
            self->hostActive = YES;
            
            break;
        }
    }
}


@end
