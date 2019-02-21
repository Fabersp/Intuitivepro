//
//  vc_SemDestaque.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 28/09/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vc_SemDestaque : UIViewController {
    
    UIColor *verde, *vermelho, *azul, *amarelo, *cor;
    
    double x;
    double w;
    double h;
    double radiunBtn;
    double valor;
}



@property (weak, nonatomic) IBOutlet UIImageView *ImgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbNomeProfissional;
@property (weak, nonatomic) IBOutlet UILabel *lbEspecializacao;
@property (weak, nonatomic) IBOutlet UIButton *btnLigar;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;

@property (nonatomic, retain) NSString * vsTelefone, * vsNomeProfissional, *vsTipo, * vsCodCor, *vsCategoria, *VsSexo;

@property (nonatomic, retain) UIColor  * vcCor;


@end
