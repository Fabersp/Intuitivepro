//
//  TableResultado.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableResultado : UITableViewController {
    
    NSDictionary * ObjetoJson;
    
}


@property (nonatomic, retain) NSMutableArray * lista_Itens;
@property (nonatomic, retain) NSString * operacao, * tipo_Imovel, * cidade;
@end
