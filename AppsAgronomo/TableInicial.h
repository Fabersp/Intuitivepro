//
//  TableInicial.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 26/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableInicial : UITableViewController {
    
    NSDictionary * ObjetoJson;
    
}


@property (nonatomic, retain) NSMutableArray * lista_Itens;
@property (nonatomic, retain) NSString * operacao, * tipo_Imovel, * cidade;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIView *ViewApper;


@end
