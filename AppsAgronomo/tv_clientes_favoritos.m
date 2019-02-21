//
//  tv_clientes_especialistas.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 27/09/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "tv_clientes_favoritos.h"
#import "Reachability.h"
#import "Cell_Clientes_Especialistas.h"
#import "vc_SemDestaque.h"
#import "AppDelegate.h"

#import "ViewControllerExpand.h"
#import "ViewControllerExpand2.h"
#import <TSMessages/TSMessageView.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface tv_clientes_favoritos ()

@end

@implementation tv_clientes_favoritos

@synthesize ObjetoJson;
@synthesize vsEspecialista;
@synthesize vcCor;
@synthesize vsIdCategoria;
@synthesize vsCodCor;
@synthesize vsIdEspecialista;
@synthesize vsIdPlano;
@synthesize toggleEdit;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Excluir" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];


    // self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // self.navigationController.navigationBar.translucent = NO;
    
    
    // Do any additional setup after loading the view.  Codigo cor  1
    // Natigator - cor - rgb(26,188,156) Verde
    verde    = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    // Natigator - cor - rgb(3,169,244) Azul     Codigo cor  2
    azul     = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1];
    // Natigator - cor - rgb(255,82,82) Vermelho   Codigo cor  3
    vermelho = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    // Natigator - cor - rgb(255,199,0) Amarelo   Codigo cor  4
    amarelo  = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:0/255.0 alpha:1];

    self.title = @"FAVORITOS";
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self loading_favoritos];
    
    }

- (NSManagedObjectContext *) managedObjectContext
{
    NSManagedObjectContext * context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void) loading_favoritos {
    
    NSManagedObjectContext * moc = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Favoritos"];
    lista_Id_Profissionais = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    
    
    if (lista_Id_Profissionais != nil ) {
        [self Loading];
        
    }

    
}



-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Excluir";
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        ObjetoJson = [news objectAtIndex:indexPath.row];
        NSString * id_prof = [ObjetoJson objectForKey:@"id"];
        
        NSManagedObjectContext * context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favoritos" inManagedObjectContext:context];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_favoritos like %@",id_prof];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:predicate];
        
        NSError *error;
        NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
        
        for (NSManagedObject *managedObject in items)
        {
            [context deleteObject:managedObject];
        }

        if (![context save:&error]) {
            NSLog(@"Não foi possível deletar!");
            return;
        }

        [self loading_favoritos];
        self.navigationItem.rightBarButtonItem.enabled = true;
    }
}

- (void)done:(id)sender {
    BOOL editing = !self.tableView.editing;
    self.navigationItem.rightBarButtonItem.enabled = !editing;
    if (editing) {
        self.navigationItem.leftBarButtonItem.title = @"Ok";
        //Added in the edition for this button has the same color of the UIBarButtonSystemItemDone
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
    }
    else{
        self.navigationItem.leftBarButtonItem.title = @"Editar";
        //Added in the edition for this button has the same color of the UIBarButtonSystemItemDone
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStylePlain;
    }
    [self.tableView setEditing:editing animated:YES];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Item";
    
    Cell_Clientes_Especialistas *cell = (Cell_Clientes_Especialistas *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (cell == nil) {
//        cell= [[Cell_Clientes_Especialistas alloc]initWithStyle:
//               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    
    
    
    NSInteger destaque = [ [[news objectAtIndex:indexPath.row] objectForKey:@"destaque"] intValue];
    
    NSString * atende = [[news objectAtIndex:indexPath.row] objectForKey:@"atende_onde"];
    
    vsCodCor = [[news objectAtIndex:indexPath.row] objectForKey:@"categoria_id"];

    if ([atende isEqual: @""]) {
        cell.lbAtende.hidden = true;
    } else {
        cell.lbAtende.hidden = false;
    }
    
    
    NSString * Nome = [[news objectAtIndex:indexPath.row] objectForKey:@"nome_prof"];
    NSString * Tratamento = [[news objectAtIndex:indexPath.row] objectForKey:@"tratamento"];
    
    if ([Tratamento  isEqual: @""]) {
        cell.lbNome.text = Nome;
        
    } else {
        cell.lbNome.text = [NSString stringWithFormat:@"%@ %@", Tratamento,Nome] ;
    }

    
    if (destaque == 1) {
        
        cell.imgAvatarProf.image = [UIImage imageNamed:@"loadingImg"];
        
        NSURL * urlImage = [NSURL URLWithString:[[news objectAtIndex:indexPath.row] objectForKey:@"url_foto"]];
        
        cell.lbAtende.hidden = false;
       
        cell.lbAtende.text = atende;
            
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:urlImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        Cell_Clientes_Especialistas * updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell)
                            updateCell.imgAvatarProf.image = image;
                    });
                }
            }
        }];
        [task resume];
    
        
        if ([vsCodCor isEqual: @"1"]) {
            
            cell.imgAvatarProf.layer.borderColor = [verde CGColor];
            cell.lbNome.textColor = verde;
            cell.lbAtende.textColor = verde;
            
            
        }
        
        
        if ([vsCodCor isEqual: @"2"]) {
            cell.imgAvatarProf.layer.borderColor = [azul CGColor];
            cell.lbNome.textColor = azul;
            cell.lbAtende.textColor = azul;
        }
        
        if ([vsCodCor isEqual: @"3"]) {
            cell.imgAvatarProf.layer.borderColor = [vermelho CGColor];
            cell.lbNome.textColor = vermelho;
            cell.lbAtende.textColor = vermelho;
            
            
        }
        
        
        if ([vsCodCor isEqual: @"4"]) {
            cell.imgAvatarProf.layer.borderColor = [amarelo CGColor];
            cell.lbNome.textColor = amarelo;
            cell.lbAtende.textColor = amarelo;
            vcCor = amarelo;

        }
   
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ObjetoJson = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    vsCodCor = [ObjetoJson objectForKey:@"categoria_id"] ;
    
    
    NSString * tipo = [ObjetoJson objectForKey:@"tipo"];
    NSString * id_profissional = [ObjetoJson objectForKey:@"id"];

    if ([vsCodCor isEqual:@"1"]) {
        vcCor = verde;
    }
    if ([vsCodCor isEqual:@"2"]) {
        vcCor = azul;
    }
    if ([vsCodCor isEqual:@"3"]) {
        vcCor = vermelho;
    }
    if ([vsCodCor isEqual:@"4"]) {
        vcCor = amarelo;
    }
    

    if ([vsCodCor isEqual:@"1"]) {
        ViewControllerExpand * vcComDestaque = [self.storyboard instantiateViewControllerWithIdentifier:@"expandable"];
        
        vcComDestaque.title = self.title;
        vcComDestaque.vsCodCor = vsCodCor;
        
        vcComDestaque.Id_Profissional = id_profissional;
        vcComDestaque.tipoProfiss = tipo;
        vcComDestaque.vcCor = vcCor;
        [self.navigationController pushViewController:vcComDestaque animated:YES];
        
    } else {
        ViewControllerExpand2 * vcComDestaque = [self.storyboard instantiateViewControllerWithIdentifier:@"expandable2"];
        
        vcComDestaque.title = self.title;
        vcComDestaque.vsCodCor = vsCodCor;
        vcComDestaque.Id_Profissional = id_profissional;
        vcComDestaque.tipoProfiss = tipo;
        vcComDestaque.vcCor = vcCor;
        
        [self.navigationController pushViewController:vcComDestaque animated:YES];
    }
    
    
    
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
           // [self setar_ids_Default];
            
            break;
        }
        case ReachableViaWWAN: {
            self->internetActive = YES;
            //[self setar_ids_Default];
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

//-(void) setar_ids_Default{
//    
//    
//    NSURL * url_lista = [NSURL URLWithString:@"http://www.promastersolution.com.br/guia/api/lista_id_profissional.php?tipo_os=IOS"];
//    
//    NSLog(@"%@", url_lista);
//    
//    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url_lista completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (data) {
//            NSError * parseError = nil;
//            lista_Id_Profissionais = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//               
//                [self Loading];
//                
//            });
//        }
//    }];
//    [task resume];
//}



-(void)Loading {
    if (internetActive){
        self.progressView = [[UCZProgressView alloc] initWithFrame:self.view.bounds];
        self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.progressView];
        
        self.progressView.indeterminate = YES;
        self.progressView.tintColor = vcCor;
        
        self.progressView.radius = 40.0;
        
        self.progressView.lineWidth = 6.0;
    
        
        lista_favoritos = @"";
        
        
        for (NSInteger i = 0; i < lista_Id_Profissionais.count; i ++) {
            
            NSManagedObject * favoritos = [lista_Id_Profissionais objectAtIndex:i];
            
            NSString * id_prof = [favoritos valueForKey:@"id_favoritos"];
            

            if ([lista_favoritos isEqual: @""]) {
                lista_favoritos = id_prof;
            } else {
                lista_favoritos = [NSString stringWithFormat:@"%@,%@",lista_favoritos, id_prof];
            }
            
        }
        
        NSLog(@"%@", lista_favoritos);
            
        if (lista_favoritos != NULL) {
            NSString * porGeral = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/listarFavoritos.php?tipo_os=IOS&listaCli=%@", lista_favoritos];
            
            url = [NSURL URLWithString:porGeral];
            
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
        }
    }
}


@end
