//
//  tbv_estado.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 17/02/18.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h" 

@interface tbv_estado : UITableViewController {
    
    NSDictionary * ObjetoJson;
    NSArray *lista_estado;
    Reachability * internetReachable;
    Reachability * hostReachable;
    
    bool internetActive;
    bool hostActive;
    
}
-(void)MensagemErro;

@end
