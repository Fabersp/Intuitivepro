//
//  cellPorPlano.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 01/10/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "cellPorPlano.h"

@implementation cellPorPlano

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.imgPlano.layer.cornerRadius = self.imgPlano.frame.size.height/2;
    self.imgPlano.clipsToBounds = YES;
    self.imgPlano.layer.borderWidth = 1.0;
    self.imgPlano.layer.masksToBounds = YES;

    
}

@end
