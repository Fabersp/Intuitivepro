//
//  CellResultado.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellResultado : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *img_resultado;

@property (weak, nonatomic) IBOutlet UILabel *lb_codigo_anuncio;


@property (weak, nonatomic) IBOutlet UILabel *lb_valor;

@property (weak, nonatomic) IBOutlet UILabel *lb_tipo;

@property (weak, nonatomic) IBOutlet UILabel *lbMetragem;
@property (weak, nonatomic) IBOutlet UILabel *lb_cidade;

@property (weak, nonatomic) IBOutlet UILabel *lbDormitorio;

@property (weak, nonatomic) IBOutlet UILabel *lb_vagas;

@end
