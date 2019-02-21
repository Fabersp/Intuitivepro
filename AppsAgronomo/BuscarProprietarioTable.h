//
//  BuscarProprietarioTable.h
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 28/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>


@class GADBannerView, GADRequest;


@interface BuscarProprietarioTable : UITableViewController {
    
    NSIndexPath * SelecionadoIndex;
    NSString * deOnde, * StrCidade;
    NSDictionary * ObjetoJson;

    
    UILabel * TipoImovel;
//    @synthesize lbcidade;
//    @synthesize lbNumeroDormitorio;
//    @synthesize lbBairro;
//    @synthesize lbNumeroVagas;
//    @synthesize lbOrdenacao;
    
    
}

@property (nonatomic, retain) NSMutableArray * lista_Itens;
@property (nonatomic, retain) NSString * deOnde, * StrCidade;


@property (nonatomic, retain) UILabel * TipoImovel;


@end
