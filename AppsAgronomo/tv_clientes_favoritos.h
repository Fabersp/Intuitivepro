//
//  tv_clientes_especialistas.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 27/09/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UCZProgressView/UCZProgressView.h>


@interface tv_clientes_favoritos : UITableViewController {
    
    NSMutableArray * news;
    NSString * lista_favoritos;
    NSDictionary * ObjetoJson;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    NSURL * url;
    NSMutableArray * lista_Id_Profissionais;

    
    UIColor *verde, *vermelho, *azul, *amarelo;
    
    
    
}
@property (nonatomic, retain) NSDictionary * ObjetoJson;

@property (nonatomic, retain) NSString * vsEspecialista, *vsCor, *vsIdCategoria, *vsIdEspecialista, *vsCodCor, *vsIdPlano;

@property (nonatomic, retain) UIColor  * vcCor;

@property (nonatomic) IBOutlet UCZProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *toggleEdit;

@end
