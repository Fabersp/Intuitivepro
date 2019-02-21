//
//  sobreNos.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/03/18.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import "sobreNos.h"
#import "SWRevealViewController.h"

@interface sobreNos ()

@end

@implementation sobreNos

@synthesize lbTopo;
@synthesize lbMissao;
@synthesize lbVisao;
@synthesize lbValores1;
@synthesize lbValores2;
@synthesize lbValores3;

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
    
    lbTopo.text = @"\tCom o propósito de trazer algo novo e diferenciado na busca de informações, o aplicativo IntuitivePRO disponibilizará pra você, o guia mais completo da categoria, com empresas e profissionais de 4(quatro) segmentos de grande demanda. \n\tApresentando altíssima precisão nas informações, o IntuitivePRO chega ao mercado com uma plataforma intuitiva e interativa, proporcionando em poucos cliques a descrição completa sobre o profissional ou empresa que você está procurando.";
    
    lbMissao.text = @"Proporcionar ao usuário uma experiência única, oferecendo informações desde básicas às mais específicas a respeito dos profissionais e empresas cadastrados em nosso sistema.";

    lbVisao.text = @"Ser referência na busca por informações sobre empresas e profissionais da cidade nos segmentos: Saúde, Engenharia, Jurídico e Contábil.";
    
    lbValores1.text = @"• Você é o nosso foco: Sempre buscaremos adequar o aplicativo às suas necessidades. Estamos aqui para proporcionar informação rápida e precisa no seu dia a dia.";
    
    lbValores2.text = @"• O guia mais completo do segmento pra você: Nosso guia é o mais completo e intuitivo do segmento, onde em poucos cliques o usuário obterá informações desde simples até as mais detalhadas a respeito do profissional ou empresa que procura, como: áreas de atuação, serviços prestados, endereço, rotas, convênios, currículo, telefones, redes sociais, fotos, entre outros.";
    
    lbValores3.text = @"• Nossa empresa é como você: Você é único, nossa empresa é única. Você se preocupa com o seu tempo, e nós também. Por isso, acessibilidade, simplicidade e agilidade definem bem nosso compromisso com a sociedade.";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
