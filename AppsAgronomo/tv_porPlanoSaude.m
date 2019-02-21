//
//  tv_porPlanoSaude.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 01/10/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "tv_porPlanoSaude.h"
#import "cellPorPlano.h"
#import "tvc_especialistas.h"
#import <TSMessages/TSMessageView.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface tv_porPlanoSaude ()

@end

@implementation tv_porPlanoSaude

@synthesize ObjetoJson;
@synthesize vsEspecialista;
@synthesize vcCor;
@synthesize vsCodCor;
@synthesize vsCategoria;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationController.navigationBar.translucent = NO;
//    
//    self.navigationController.navigationBar.barTintColor = vcCor;
//    
//    //branco botoes do navegador
//    
//    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];
    vsCategoria = @"1";
    
    [self Loading];

 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Item";
    
    cellPorPlano *cell = (cellPorPlano *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell= [[cellPorPlano alloc]initWithStyle:
               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.imgPlano.layer.borderColor = [vcCor CGColor];
    
    NSURL * urlImage = [NSURL URLWithString:[[news objectAtIndex:indexPath.row] objectForKey:@"url_imagem"]];
    
    cell.lbNome.text = [[news objectAtIndex:indexPath.row] objectForKey:@"nome"];
    
    cell.lbNome.textColor = vcCor;
    
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:urlImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cellPorPlano * updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.imgPlano.image = image;
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
            [self MensagemErro];
            self->internetActive = NO;
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
        

        
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/lista_especporplano.php?tipo_os=IOS&categ=%@", vsCategoria] ];
        
        
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSError * parseError = nil;
                news = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                    [self.progressView removeFromSuperview];
                    
                });
            }
        }];
        [task resume];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ObjetoJson = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSString * idPlano = [ObjetoJson objectForKey:@"id"];
    
    
    if ([[segue identifier] isEqualToString:@"segueEspecialistas"]) {
        tvc_especialistas * destViewController = segue.destinationViewController;
        destViewController.title = @"ESPECIALISTAS";
        destViewController.vcCor = vcCor;
        destViewController.vsCodCor = vsCodCor;
        destViewController.vsPlanoSaude = idPlano;
        destViewController.vsCategoria = vsCategoria;
        destViewController.vsEspecialista = @"1";
    }
}

@end
