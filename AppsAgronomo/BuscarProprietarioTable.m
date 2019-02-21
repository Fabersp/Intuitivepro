//
//  BuscarProprietarioTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 28/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "BuscarProprietarioTable.h"
#import "ViewPesquisa.h"



@interface BuscarProprietarioTable ()

@end

@implementation BuscarProprietarioTable

@synthesize lista_Itens;
@synthesize deOnde;
@synthesize TipoImovel;
@synthesize StrCidade;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
  //  self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
   
}

#pragma mark GADInterstitialDelegate implementation




-(void)viewDidAppear:(BOOL)animated{
    
    if ([deOnde isEqualToString:@"operacao"]){
        [self Loading:[NSURL URLWithString:@"http://www.promastersolution.com.br/x7890_IOS/imoveis/rejane/operacao_ios.php"]];
        
        self.title = @"Operação";
        
    } if ([deOnde isEqualToString:@"tipoimovel"]){
        [self Loading:[NSURL URLWithString:@"http://www.promastersolution.com.br/x7890_IOS/imoveis/rejane/tipo_imovel_ios.php"]];
        self.title = @"Tipos de imóveis";
        
    } if ([deOnde isEqualToString:@"cidade"]){
        [self Loading:[NSURL URLWithString:@"http://www.promastersolution.com.br/x7890_IOS/imoveis/rejane/municipios_ios.php"]];
        self.title = @"Cidades";
    }
    
//    } if ([deOnde isEqualToString:@"bairro"]){
//        
//        NSString * UrlMontadada = [NSString stringWithFormat:@"http://www.promastersolution.com.br/x7890_IOS/imoveis/rejane/bairro_por_cidade_ios.php?municipio=%@", StrCidade];
//        
//        [self Loading:[NSURL URLWithString:UrlMontadada]];
//    }
}



- (IBAction)SelecionarProprietario:(id)sender {
    
    ObjetoJson = [lista_Itens objectAtIndex:SelecionadoIndex.row];
    TipoImovel.text = [ObjetoJson valueForKey:@"titulo"];
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return lista_Itens.count;
}

-(void) Loading:(NSURL *) urlLista {
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask * task =
    [session downloadTaskWithURL:urlLista completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
        lista_Itens = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
    }];
    [task resume];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIndentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"titulo"];
    
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *oldIndex = [self.tableView indexPathForSelectedRow];
    
    [self.tableView cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
    
    [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    SelecionadoIndex = indexPath;
    
    return indexPath;
}

@end
