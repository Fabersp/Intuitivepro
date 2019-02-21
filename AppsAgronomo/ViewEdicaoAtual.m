//
//  ViewEdicaoAtual.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 30/06/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import "ViewEdicaoAtual.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
#import <TSMessages/TSMessageView.h>
#import "tvc_especialistas.h"
#import "tbv_estado.h"
#import "TBV_Engenharia.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ViewEdicaoAtual ()


@end

@implementation ViewEdicaoAtual

@synthesize pageImages;
@synthesize pastaEdicao;
@synthesize ObjetoJson;
@synthesize imgCapa;
@synthesize ID_Edicao;
@synthesize Edicao;
@synthesize btnDownload;

@synthesize btnMedica;
@synthesize btnJuridica;
@synthesize btnContabil;
@synthesize btnEngenheria;
@synthesize imgLogo;

@synthesize Id_Cidade;

@synthesize ViewApper;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationController.view addSubview:ViewApper];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController ) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    btnMedica.layer.masksToBounds = YES;
    btnJuridica.layer.masksToBounds = YES;
    btnContabil.layer.masksToBounds = YES;
    btnEngenheria.layer.masksToBounds = YES;

}


-(void)viewDidAppear:(BOOL)animated{

    NSString * StrCidade = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/lista_cidade_estado.php?tipo_os=IOS"];
    
    [self loading_Cidade:StrCidade];
    
    // orientar os botoes e imagens

    [self orientarBotoesImagem];
    
    
    
//    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [titleLabelButton setTitle:@"myTitle" forState:UIControlStateNormal];
//    titleLabelButton.frame = CGRectMake(0, 0, 70, 44);
//    [titleLabelButton addTarget:self action:@selector(didTapTitleView:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = titleLabelButton;
    
    // branco
    self.navigationController.navigationBar.barTintColor = Rgb2UIColor(255,255,255);
    
    // cinza
    self.navigationItem.leftBarButtonItem.tintColor = Rgb2UIColor(142, 142, 142);
    
    // cinza
    self.navigationItem.rightBarButtonItem.tintColor = Rgb2UIColor(142, 142, 142);
   
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(142, 142, 142)}];
    
}

-(void) orientarBotoesImagem {
    
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                
            case 480:
                printf("iPhone 4");
            
                imgLogo.frame  = CGRectMake(16, 50, 288, 200);
                imgLogo.image  = [UIImage imageNamed:@"logo"];
                
                radiunBtn = 25.0f;
                
                btnMedica.layer.cornerRadius = radiunBtn;
                btnJuridica.layer.cornerRadius = radiunBtn;
                btnContabil.layer.cornerRadius = radiunBtn;
                btnEngenheria.layer.cornerRadius = radiunBtn;
                
                x = 16;
                w = 288;
                h = 50;
                
                // verde
                btnMedica.frame       = CGRectMake(x, 258, w, h);
                // Azul
                btnJuridica.frame   = CGRectMake(x, 313, w, h);
                // vermelho
                btnEngenheria.frame     = CGRectMake(x, 368, w, h);
                // amarelo
                btnContabil.frame     = CGRectMake(x, 423, w, h);
                
                break;
                
                
                
            case 960:
                printf("iPhone 4");
                
                imgLogo.frame  = CGRectMake(16, 54, 288, 195);
                imgLogo.image  = [UIImage imageNamed:@"logo"];
                
                radiunBtn = 25.0f;
                
                btnMedica.layer.cornerRadius = radiunBtn;
                btnJuridica.layer.cornerRadius = radiunBtn;
                btnContabil.layer.cornerRadius = radiunBtn;
                btnEngenheria.layer.cornerRadius = radiunBtn;

                x = 16;
                w = 288;
                h = 45;
                
                // verde
                btnMedica.frame       = CGRectMake(x, 258, w, h);
                // Azul
                btnJuridica.frame   = CGRectMake(x, 313, w, h);
                // vermelho
                btnEngenheria.frame     = CGRectMake(x, 368, w, h);
                // amarelo
                btnContabil.frame     = CGRectMake(x, 423, w, h);
                
                break;
                
            case 1136:
                printf("iPhone 5 or 5S or 5C");
                
                imgLogo.frame  = CGRectMake(16, 55, 288, 200);
                imgLogo.image  = [UIImage imageNamed:@"logo"];
                
                radiunBtn = 35.0f;
                
                btnMedica.layer.cornerRadius = radiunBtn;
                btnJuridica.layer.cornerRadius = radiunBtn;
                btnContabil.layer.cornerRadius = radiunBtn;
                btnEngenheria.layer.cornerRadius = radiunBtn;
                
                x = 16;
                w = 288;
                h = 65;
                
                // verde
                btnMedica.frame       = CGRectMake(x, 266, w, h);
                // Azul
                btnJuridica.frame   = CGRectMake(x, 342, w, h);
                // vermelho
                btnEngenheria.frame     = CGRectMake(x, 418, w, h);
                // amarelo
                btnContabil.frame     = CGRectMake(x, 494, w, h);
                
                break;
                
            case 1334:
                printf("iPhone 6 or 7 or 8");
               
                imgLogo.frame  = CGRectMake(29, 55, 317, 215);
                imgLogo.image  = [UIImage imageNamed:@"logo"];
                
                radiunBtn = 40.0f;
                
                btnMedica.layer.cornerRadius = radiunBtn;
                btnJuridica.layer.cornerRadius = radiunBtn;
                btnContabil.layer.cornerRadius = radiunBtn;
                btnEngenheria.layer.cornerRadius = radiunBtn;
                
                x = 30;
                w = 312;
                h = 85;
                
                // verde
                btnMedica.frame       = CGRectMake(x, 279, w, h);
                // Azul
                btnJuridica.frame   = CGRectMake(x, 375, w, h);
                // vermelho
                btnEngenheria.frame     = CGRectMake(x, 470, w, h);
                // amarelo
                btnContabil.frame     = CGRectMake(x, 566, w, h);
                
                
                
                break;
            case 2208:
                
                printf("iPhone 6 or 7 or 8 - plus");
                
                imgLogo.frame  = CGRectMake(42, 72, 317, 215);
                imgLogo.image  = [UIImage imageNamed:@"logo"];
                
                radiunBtn = 45.0f;
                
                btnMedica.layer.cornerRadius = radiunBtn;
                btnJuridica.layer.cornerRadius = radiunBtn;
                btnContabil.layer.cornerRadius = radiunBtn;
                btnEngenheria.layer.cornerRadius = radiunBtn;
                
                x = 30;
                w = 355;
                h = 90;
                
                // verde
                btnMedica.frame       = CGRectMake(x, 302, w, h);
                // Azul
                btnJuridica.frame   = CGRectMake(x, 409, w, h);
                // vermelho
                btnEngenheria.frame     = CGRectMake(x, 514, w, h);
                // amarelo
                btnContabil.frame     = CGRectMake(x, 621, w, h);
                
                
                
          /*  logo: x 49 , y 72
                w 317, h 215
                
                botões
                
                w 317, h 90
                
            saude: x 49, y 302
                
            engenharia: x 49, y 409
                
                jurídico, x 49, y 514
                
            contabilidade: x 49, y 621
            */
                
                
                break;
            case 2001:
                printf("iPhone X");
                
                imgLogo.frame  = CGRectMake(29, 103, 317, 215);
                imgLogo.image  = [UIImage imageNamed:@"logo"];
                
                radiunBtn = 42.0f;
                
                btnMedica.layer.cornerRadius = radiunBtn;
                btnJuridica.layer.cornerRadius = radiunBtn;
                btnContabil.layer.cornerRadius = radiunBtn;
                btnEngenheria.layer.cornerRadius = radiunBtn;
                
                x = 29;
                w = 334;
                h = 90;
                
                // verde
                btnMedica.frame     = CGRectMake(x, 334, w, h);
                // Azul
                btnJuridica.frame   = CGRectMake(x, 442, w, h);
                // vermelho
                btnEngenheria.frame  = CGRectMake(x, 549, w, h);
                // amarelo
                btnContabil.frame     = CGRectMake(x, 658, w, h);
                
                
              /*  Iphone X
                
            logo: x 29 , y 103
                w 317, h 215
                
                botões
                
                w 317, h 90
                
            saude: x 29, y 334
                
            engenharia: x 29, y 442
                
                jurídico, x 29, y 549
                
            contabilidade: x 29, y 658

                */
                
                
                break;
                
            default:
                printf("unknown");
                
                imgLogo.frame  = CGRectMake(29, 81, 317, 200);
                imgLogo.image  = [UIImage imageNamed:@"logo"];
                
                radiunBtn = 42.0f;
                
                btnMedica.layer.cornerRadius = radiunBtn;
                btnJuridica.layer.cornerRadius = radiunBtn;
                btnContabil.layer.cornerRadius = radiunBtn;
                btnEngenheria.layer.cornerRadius = radiunBtn;
                
                x = 29;
                w = 315;
                h = 80;
                
                // verde
                btnMedica.frame     = CGRectMake(x, 293, w, h);
                // Azul
                btnJuridica.frame   = CGRectMake(x, 383, w, h);
                // vermelho
                btnEngenheria.frame  = CGRectMake(x, 473, w, h);
                // amarelo
                btnContabil.frame     = CGRectMake(x, 564, w, h);
        }
    }

}

-(void)loading_Cidade:(NSString *) StrSobreEspec {
    
    NSURL * url = [NSURL URLWithString:StrSobreEspec];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            lista_cidade = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            
        }
    }];
    [task resume];
}



- (IBAction)didTapTitleView:(id) sender {
    tbv_estado * destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"segue_estado"];
        destViewController.title = @"Estado";
        [self.navigationController pushViewController:destViewController animated:YES];
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
     [self orientarBotoesImagem];
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
            //[self loading_estado];
          
            break;
        }
        case ReachableViaWWAN: {
            
            self->internetActive = YES;
            //[self loading_estado];
            break;
        }
    }
}

- (IBAction)btnListarFavoritos:(id)sender {
    
    // Do any additional setup after loading the view.  Codigo cor  1
    // Natigator - cor - rgb(26,188,156) Verde
    verde    = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    // Natigator - cor - rgb(3,169,244) Azul     Codigo cor  2
    azul     = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1];
    // Natigator - cor - rgb(255,82,82) Vermelho   Codigo cor  3
    vermelho = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    // Natigator - cor - rgb(255,199,0) Amarelo   Codigo cor  4
    amarelo  = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:0/255.0 alpha:1];
    
    tvc_especialistas * especialistas = [self.storyboard instantiateViewControllerWithIdentifier:@"segue_clientes"];

    
    especialistas.vcCor = vermelho;
    //especialistas.vsCodCor = @"3";
    
    [self.navigationController pushViewController:especialistas animated:YES];
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([[segue identifier] isEqualToString:@"segueEngenharia"]) {
        TBV_Engenharia * destViewController = segue.destinationViewController;
        destViewController.vsCategoria = @"2";
        destViewController.vsCodCor = @"2";
    }
    if ([[segue identifier] isEqualToString:@"segueJuridica"]) {
        TBV_Engenharia * destViewController = segue.destinationViewController;
        destViewController.vsCategoria = @"3";
        destViewController.vsCodCor = @"3";
    }
    if ([[segue identifier] isEqualToString:@"segueContabil"]) {
        TBV_Engenharia * destViewController = segue.destinationViewController;
        destViewController.vsCategoria = @"4";
        destViewController.vsCodCor = @"4";
    }
}































@end
