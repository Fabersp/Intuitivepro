//
//  CellEspecialistas.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 27/08/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "Cell_Clientes_Especialistas.h"

#import <QuartzCore/QuartzCore.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@implementation Cell_Clientes_Especialistas


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Natigator - cor - rgb(26,188,156) Verde
    // Natigator - cor - rgb(3,169,244) Azul
    // Natigator - cor - rgb(255,82,82) Vermelho
    // Natigator - cor - rgb(255,199,0) Amarelo

    self.imgAvatarProf.layer.cornerRadius = 30;
    self.imgAvatarProf.clipsToBounds = YES;
    self.imgAvatarProf.layer.borderWidth = 1.0;
    self.imgAvatarProf.layer.masksToBounds = YES;
    
    
}

@end
