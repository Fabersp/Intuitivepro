//
//  ViewPesquisa.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import "ViewPesquisa.h"
#import "SWRevealViewController.h"
#import "BuscarProprietarioTable.h"
#import "TableResultado.h"

@interface ViewPesquisa ()

@end

@implementation ViewPesquisa

@synthesize ViewApper;
@synthesize lbTipoImovel;
@synthesize lbcidade;
@synthesize lbBairro;
@synthesize lboperacao;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    
    [self.navigationController.view addSubview:ViewApper];
    
    // [self.view addSubview:ViewApper];
    
    self.title = @"Filtrar";
    
//    UIImageView* imglog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_banner_80-40-transparente"]];
//    self.navigationItem.titleView = imglog;
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lb_limpar:(id)sender {
    // limpar tudo o filtro //
    lbTipoImovel.text = @"indiferente";
    lbcidade.text = @"indiferente";
    // lbBairro.text = @"indiferente";
    lboperacao.text = @"indiferente";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Index selected: %li", (long)indexPath.row);
    

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"operacao"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.deOnde = @"operacao";
        destViewController.TipoImovel = lboperacao;
        
    } else if ([[segue identifier] isEqualToString:@"tipoimovel"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.deOnde = @"tipoimovel";
        destViewController.TipoImovel = lbTipoImovel;
        
    } else if ([[segue identifier] isEqualToString:@"cidade"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.deOnde = @"cidade";
        destViewController.TipoImovel = lbcidade;
        
    } else if ([[segue identifier] isEqualToString:@"fitrar"]) {
        TableResultado * destViewController = segue.destinationViewController;
        destViewController.cidade = lbcidade.text;
        destViewController.tipo_Imovel = lbTipoImovel.text;
        destViewController.operacao = lboperacao.text;
    }
    
//    else if ([[segue identifier] isEqualToString:@"bairro"]) {
//        BuscarProprietarioTable * destViewController = segue.destinationViewController;
//        destViewController.deOnde = @"bairro";
//        destViewController.StrCidade = lbcidade.text;
//
//        destViewController.TipoImovel = lbBairro;
//    }
    
}


@end
