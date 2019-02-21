//
//  tbv_cidade.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 17/02/18.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h" 

@interface tbv_cidade : UITableViewController {
    
    NSDictionary * ObjetoJson;
    NSArray *lista_cidade;
    
    
    Reachability * internetReachable;
    Reachability * hostReachable;
    bool internetActive;
    bool hostActive;
    
}
-(void)MensagemErro;

@property (nonatomic, retain) NSString * Id_Estado;
@end
