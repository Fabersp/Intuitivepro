//
//  ViewPesquisa.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPesquisa : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIView *ViewApper;

@property (weak, nonatomic) IBOutlet UILabel *lboperacao;
@property (weak, nonatomic) IBOutlet UILabel *lbTipoImovel;
@property (weak, nonatomic) IBOutlet UILabel *lbcidade;
@property (weak, nonatomic) IBOutlet UILabel *lbBairro;


@end
