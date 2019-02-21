//
//  tbv_estado.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 17/02/18.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import "tbv_estado.h"
#import "Reachability.h"
#import <TSMessages/TSMessageView.h>
#import "tbv_cidade.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface tbv_estado ()

@end

@implementation tbv_estado

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * StrEstado = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/lista_estados.php?tipo_os=IOS"];
    
    [self loading_estado:StrEstado];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return lista_estado.count;
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

-(void)loading_estado:(NSString *) StrSobreEspec {
    
    NSURL * url = [NSURL URLWithString:StrSobreEspec];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            lista_estado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        
        }
    }];
    [task resume];
}

-(void)viewDidAppear:(BOOL)animated{
    
    // branco
    self.navigationController.navigationBar.barTintColor = Rgb2UIColor(255,255,255);
    
    // cinza
    //self.navigationItem.leftBarButtonItem.tintColor = Rgb2UIColor(142, 142, 142);
    
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(142, 142, 142);
    
    // cinza
    // self.navigationItem.rightBarButtonItem.tintColor = Rgb2UIColor(142, 142, 142);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(142, 142, 142)}];
    
    //[self loading_favoritos];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"estado";
    
     UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    // Configure the cell...
    cell.textLabel.text = [[lista_estado objectAtIndex:indexPath.row] objectForKey:@"nome"];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ObjetoJson = [lista_estado objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSString * estado = [ObjetoJson objectForKey:@"nome"];
    NSString * id_uf   = [ObjetoJson objectForKey:@"id_uf"];
    
    if ([[segue identifier] isEqualToString:@"segueCidade"]) {
        tbv_cidade * destViewController = segue.destinationViewController;
        destViewController.title = estado;
        destViewController.Id_Estado = id_uf;
       // destViewController.vcCor = vcCor;
    }
}


@end
