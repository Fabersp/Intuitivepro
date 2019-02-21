//
//  ViewEdicaoAtual.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 30/06/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"



@interface ViewEdicaoAtual : UIViewController {
    
    NSArray * EdicaoAtual, * PathsPaginas;
    
    NSDictionary * ObjetoJson;
    NSMutableArray * _selections;
    NSArray * lista_Id_Profissionais, *lista_estado, *lista_cidade;
    
    NSString * Edicao, * ID_Edicao;
    Reachability * internetReachable;
    Reachability * hostReachable;
    bool internetActive;
    bool hostActive;
   
    double x;
    double w;
    double h;
    double radiunBtn;
    
    UIColor *verde, *vermelho, *azul, *amarelo;

}

-(void)MensagemErro;


@property (nonatomic, retain) NSString * Id_Cidade;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;



@property (nonatomic, retain) NSDictionary * ObjetoJson;
@property (strong, nonatomic) NSMutableArray *pageImages;
@property (strong, nonatomic) NSString * pastaEdicao, * pasta, * ID_Edicao, * Edicao;

@property (nonatomic, strong) NSMutableArray *photos;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *ViewApper;


@property (weak, nonatomic) IBOutlet UIImageView *imgCapa;

@property (weak, nonatomic) IBOutlet UIButton *btnDownload;

@property (weak, nonatomic) IBOutlet UIButton *btnMedica;

@property (weak, nonatomic) IBOutlet UIButton *btnJuridica;

@property (weak, nonatomic) IBOutlet UIButton *btnEngenheria;

@property (weak, nonatomic) IBOutlet UIButton *btnContabil;


@end
