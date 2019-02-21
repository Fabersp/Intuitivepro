//
//  ViewResultado.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 12/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewResultado : UIViewController <UIScrollViewDelegate> {
    
    NSArray * lista, * horarios, * fotos;
    NSString * Id_Galeria, * Operacao,  * Valor, * Municipio, * Endereco, * Descricao_Completa ;
    
    NSURL * UrlImagem;
}



@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, retain) NSString *Id_Galeria, * Operacao,  * Valor, * Municipio, * Endereco, * Descricao_Completa ;

@property (weak, nonatomic) IBOutlet UILabel *lb_Operacao;

@property (weak, nonatomic) IBOutlet UILabel *lb_Valor;

@property (weak, nonatomic) IBOutlet UILabel *lb_CodigoAnuncio;
@property (weak, nonatomic) IBOutlet UILabel *lb_Municipio;

@property (weak, nonatomic) IBOutlet UILabel *lb_Endereco;
@property (weak, nonatomic) IBOutlet UITextView *lb_Descricao_Completa;
@property (weak, nonatomic) IBOutlet UIButton *btn_Ligar;

@property (weak, nonatomic) IBOutlet UIButton *ligar;


@end
