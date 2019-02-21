//
//  tbv_cidade.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 17/02/18.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import "tbv_cidade.h"
#import "Reachability.h"
#import <TSMessages/TSMessageView.h>
#import "tbv_estado.h"
#import "ViewEdicaoAtual.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface tbv_cidade ()
  
@end

@implementation tbv_cidade

@synthesize Id_Estado;

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    

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

    return lista_cidade.count;
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
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cidade";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell= [[UITableViewCell alloc]initWithStyle:
               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[lista_cidade objectAtIndex:indexPath.row] objectForKey:@"nome"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ObjetoJson = [lista_cidade objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSString * id_cidade = [ObjetoJson objectForKey:@"id_cidade"];
    NSString * nome_cidade = [ObjetoJson objectForKey:@"nome"];
    
    
    ViewEdicaoAtual * principal = [self.storyboard instantiateViewControllerWithIdentifier:@"segue_clientes"];

    principal.Id_Cidade = id_cidade;
    principal.title = nome_cidade;
    
    [self.navigationController pushViewController:principal animated:YES];
}


@end
