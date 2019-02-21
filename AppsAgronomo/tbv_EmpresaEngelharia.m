//
//  tbv_EmpresaEngelharia.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 23/11/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "tbv_EmpresaEngelharia.h"
#import "tv_clientes_especialistas.h"
#import "Reachability.h"
#import <TSMessages/TSMessageView.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface tbv_EmpresaEngelharia ()

@end

@implementation tbv_EmpresaEngelharia

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
    
    self.navigationController.navigationBar.barTintColor = azul;
    
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
    
    tv_clientes_especialistas * clientes = [self.storyboard instantiateViewControllerWithIdentifier:@"segue_clientes"];
    
    clientes.vcCor = azul;
    clientes.vsCodCor = @"2";
    
    
    // AGRIMESSORES
    if (indexPath.row == 0) {
        clientes.title = @"EMPRESA DE CONSTRUÇÃO";
        clientes.vsIdCategoria = @"22";
        [self.navigationController pushViewController:clientes animated:YES];
        
    }
    // ARQUITETOS
    if (indexPath.row == 1) {
        clientes.title = @"EMPRESA DE AGRONOMIA";
        clientes.vsIdCategoria = @"23";
        [self.navigationController pushViewController:clientes animated:YES];
    }
    
    if (indexPath.row == 2) {
        
        clientes.title = @"EMPRESA DE AMBIENTAL";
        clientes.vsIdCategoria = @"24";
        [self.navigationController pushViewController:clientes animated:YES];
    }
    
    
    
    
    
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
}
@end
