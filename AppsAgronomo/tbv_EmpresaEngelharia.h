//
//  tbv_EmpresaEngelharia.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 23/11/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h" 

@interface tbv_EmpresaEngelharia : UITableViewController {
    
    
    UIColor *verde, *vermelho, *azul, *amarelo;
    
    
    Reachability * internetReachable;
    Reachability * hostReachable;
    bool internetActive;
    bool hostActive;
    
    
    
}

-(void)MensagemErro;


@end
