//
//  tvc_todos.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 21/01/18.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import "tvc_todos.h"

#import "Reachability.h"
#import "Cell_Clientes_Especialistas.h"
#import "vc_SemDestaque.h"

#import "ViewControllerExpand.h"
#import "ViewControllerExpand2.h"
#import <TSMessages/TSMessageView.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]


@interface tvc_todos ()

@end

@implementation tvc_todos

@synthesize ObjetoJson;
@synthesize vsEspecialista;
@synthesize vcCor;
@synthesize vsIdCategoria;
@synthesize vsCodCor;
@synthesize vsIdEspecialista;
@synthesize vsIdPlano;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    if ([vsCodCor isEqual: @"1"]) {
       self.title = @"SAÚDE";
    }
    if ([vsCodCor isEqual: @"2"]) {
       self.title = @"ENGENHARIA";
    }
    if ([vsCodCor isEqual: @"3"]) {
        self.title = @"JURÍDICO";
    }
    if ([vsCodCor isEqual: @"4"]) {
        self.title = @"CONTÁBIL";
    }
        
        
    
    
    isFiltered = false;
    
    

    self.buscar.delegate = self;
    
    [self Loading];
}
- (IBAction)btnBuscar:(id)sender {
    
    
    
    [self.tableView reloadData];
    NSLog(@"%@", news);
    
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText == 0){
        isFiltered = false;
        
    } else {
        isFiltered = true;
        news = [[NSArray alloc]init];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nome_prof contains[cd] %@", searchText];
        
        news = [filtered filteredArrayUsingPredicate:predicate];
    
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Item";
    
    Cell_Clientes_Especialistas *cell = (Cell_Clientes_Especialistas *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //    if (cell == nil) {
    //        cell= [[Cell_Clientes_Especialistas alloc]initWithStyle:
    //               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //    }
    
    cell.imgAvatarProf.layer.borderColor = [vcCor CGColor];
    cell.lbNome.textColor = vcCor;
    cell.lbAtende.textColor = vcCor;
    
    NSInteger destaque = [ [[news objectAtIndex:indexPath.row] objectForKey:@"destaque"] intValue];
    
    NSString * sexo =  [[news objectAtIndex:indexPath.row] objectForKey:@"sexo"];
    
    NSString  * tipo =  [[news objectAtIndex:indexPath.row] objectForKey:@"tipo"];
    
    NSString * atende = [[news objectAtIndex:indexPath.row] objectForKey:@"atende_onde"];
    
    
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
        cell.lbNome.text = [NSString stringWithFormat:@"%@ %@", Tratamento, Nome];
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
        
    } else {
        cell.lbAtende.hidden = true;
        
        if ([vsCodCor isEqual: @"1"]) {
            if ([tipo isEqual: @"0"]) {
                cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarCompanyVerde"];
            } else {
                if ([sexo isEqual: @"0"])
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarMulherVerde"];
                else
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarHomemVerde"];
            }
        }
        
        
        if ([vsCodCor isEqual: @"2"]) {
            
            if ([tipo isEqual: @"0"]) {
                cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarCompanyAzul"];
            } else {
                if ([sexo isEqual: @"0"])
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarMulherAzul"];
                else
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarHomemAzul"];
            }
        }
        
        if ([vsCodCor isEqual: @"3"]) {
            
            if ([tipo isEqual: @"0"]) {
                cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarCompanyVermelho"];
            } else {
                if ([sexo isEqual: @"0"])
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarMulherVermelho"];
                else
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarHomemVermelho"];
            }
        }
        
        
        if ([vsCodCor isEqual: @"4"]) {
            if ([tipo isEqual: @"0"]) {
                cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarCompanyAmarelo"];
            } else {
                if ([sexo isEqual: @"0"])
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarMulherAmarelo"];
                else
                    cell.imgAvatarProf.image = [UIImage imageNamed:@"avatarHomemAmarelo"];
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ObjetoJson = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSInteger  destaque = [[ObjetoJson objectForKey:@"destaque"] intValue];
    
    
    NSString * tipo = [ObjetoJson objectForKey:@"tipo"];
    NSString * id_profissional = [ObjetoJson objectForKey:@"id"];
    
    NSString * Nome = [ObjetoJson  objectForKey:@"nome_prof"];
    NSString * Tratamento = [ObjetoJson  objectForKey:@"tratamento"];
    
    
    if (destaque == 0) {
        
        vc_SemDestaque * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SemDestaque"];
        
        if ([Tratamento  isEqual: @""]) {
            vc.vsNomeProfissional = Nome;
            
        } else {
            vc.vsNomeProfissional = [NSString stringWithFormat:@"%@ %@", Tratamento,Nome] ;
        }
        
        vc.VsSexo = [ObjetoJson objectForKey:@"sexo"];
        vc.vsTipo = tipo;
        vc.vcCor  = vcCor;
        vc.vsCodCor = vsCodCor;
        
        NSString * telefone1 = [ObjetoJson objectForKey:@"telefone1"];
        if (telefone1 == nil) { telefone1 = @""; }
        NSString * telefone2 = [ObjetoJson objectForKey:@"telefone2"];
        if (telefone2 == nil) { telefone2 = @""; }
        NSString * celular = [ObjetoJson objectForKey:@"celular"];
        if (celular == nil) { celular = @""; }
        
        NSString * telefone;
        
        if (![telefone1 isEqual:@""]) {
            telefone = [NSString stringWithFormat:@"telprompt:%@", telefone1];
            
        } else if (![telefone2 isEqual:@""]) {
            telefone = [NSString stringWithFormat:@"telprompt:%@",telefone2];
            
        } else if (![celular isEqual:@""]) {
            telefone = [NSString stringWithFormat:@"telprompt:%@",celular];
        }
        vc.vsTelefone = telefone;
        
        vc.vsCategoria = self.title;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
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
        
        
        self.progressView.indeterminate = YES;
        self.progressView.tintColor = vcCor;
        
        self.progressView.radius = 40.0;
        
        self.progressView.lineWidth = 6.0;
        
        
        
        NSString * porGeral = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/lista_todos_clientes.php?tipo_os=IOS&categ=%@", vsIdCategoria];
        
        
        url = [NSURL URLWithString:porGeral];
        
        
        NSLog(@"%@", url);
        
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSError * parseError = nil;
                filtered = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                   
                    [self.progressView removeFromSuperview];
                    
                    
                });
            }
        }];
        [task resume];
    
        
     }
}



@end
