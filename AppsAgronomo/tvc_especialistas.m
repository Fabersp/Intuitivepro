//
//  tvc_especialistas.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 26/09/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "tvc_especialistas.h"
#import "Reachability.h"
#import "cell_especialistas.h"
#import "tv_clientes_especialistas.h"
#import <TSMessages/TSMessageView.h>




#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]


@interface tvc_especialistas ()

@end

@implementation tvc_especialistas

@synthesize ObjetoJson;
@synthesize vsEspecialista;
@synthesize vcCor;
@synthesize vsCodCor;
@synthesize vsPlanoSaude;
@synthesize vsCategoria;






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    

//    self.navigationController.navigationBar.translucent = NO;
    
 //   self.navigationController.navigationBar.barTintColor = vcCor;
    
//    //branco botoes do navegador
//    
//    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];
    

    
    [self Loading];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Item";
    
    cell_especialistas *cell = (cell_especialistas *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell= [[cell_especialistas alloc]initWithStyle:
               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }


    
    
    cell.lbTexto.text = [[news objectAtIndex:indexPath.row] objectForKey:@"nome"];
    cell.lbTexto.textColor = vcCor;
    
    NSURL * urlImage = [NSURL URLWithString:[[news objectAtIndex:indexPath.row] objectForKey:@"url_icone"]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:urlImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell_especialistas * updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.imgIcone.image = image;
                });
            }
        }
    }];
    [task resume];
    
    return cell;
}

//--------------- Verificar a internet -----------------//
-(void) viewWillAppear:(BOOL)animated {
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    hostReachable = [Reachability reachabilityWithHostName:@"www.revide.com.br"];
    [hostReachable startNotifier];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
            [self Loading];
            
            break;
        }
        case ReachableViaWWAN: {
            self->internetActive = YES;
            [self Loading];
            break;
        }
    }
    
}


-(void)Loading {
    if (internetActive){
        
        self.progressView = [[UCZProgressView alloc] initWithFrame:self.view.bounds];
        self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.progressView];
        
//        NSDictionary *views = NSDictionaryOfVariableBindings(_progressView);
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_progressView]-0-|" options:0 metrics:nil views:views]];
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_progressView]-0-|" options:0 metrics:nil views:views]];
        
        self.progressView.indeterminate = YES;
        self.progressView.tintColor = vcCor;
        
        self.progressView.radius = 40.0;
        
        self.progressView.lineWidth = 6.0;
        
        if (vsPlanoSaude == nil)
            vsPlanoSaude = @"";
        
        NSString * porPlano = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/menu_especializacoes_porplano.php?tipo_os=IOS&menu=%@&idconv=%@&categ=%@", vsEspecialista, vsPlanoSaude, vsCategoria];
        
        
        NSString * porGeral = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/menu_especializacoes.php?tipo_os=IOS&menu=%@", vsEspecialista];
        
        if ([vsPlanoSaude  isEqual: @""])
             url = [NSURL URLWithString:porGeral];
        else
             url = [NSURL URLWithString:porPlano];
        
        NSLog(@"%@", url);
        
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSError * parseError = nil;
                news = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@", news);
                    [self.tableView reloadData];
                    [self.progressView removeFromSuperview];
                    
                });
            }
        }];
        [task resume];

        
        
        
        
//        NSURLSession * session = [NSURLSession sharedSession];
//        
//        NSURLSessionDownloadTask * task =
//        [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//            NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
//            
//            news = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//                [self.progressView removeFromSuperview];
//                
//
//            });
//            
//            
//        }];
//        [task resume];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ObjetoJson = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSString * Categoria = [ObjetoJson objectForKey:@"nome"];
    NSString * IdEspec   = [ObjetoJson objectForKey:@"id"];
    
    if ([[segue identifier] isEqualToString:@"segueEspecialistas"]) {
        tv_clientes_especialistas * destViewController = segue.destinationViewController;
        destViewController.title = Categoria;
        destViewController.vcCor = vcCor;
        destViewController.vsCodCor = vsCodCor;
        destViewController.vsIdPlano = vsPlanoSaude;
        destViewController.vsIdEspecialista = IdEspec;
        destViewController.vsIdCategoria = vsCategoria;
        
    }
}



@end
