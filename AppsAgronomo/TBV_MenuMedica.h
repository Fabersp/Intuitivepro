//
//  TBV_MenuMedica.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 26/08/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"


@interface TBV_MenuMedica : UITableViewController
{
    UIColor *verde, *vermelho, *azul, *amarelo;
    
    
    Reachability * internetReachable;
    Reachability * hostReachable;
    bool internetActive;
    bool hostActive;
    
    
    
}

-(void)MensagemErro;

@end
