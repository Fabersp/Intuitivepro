//
//  TBV_MenuContabil.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 27/08/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UCZProgressView/UCZProgressView.h>

@interface TBV_MenuContabil : UITableViewController {
    
    
    NSArray * news;
    NSDictionary * ObjetoJson;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    NSURL * url;
    
    
    UIColor *verde, *vermelho, *azul, *amarelo;
    
}

@property (nonatomic, retain) NSDictionary * ObjetoJson;

@property (nonatomic) IBOutlet UCZProgressView *progressView;

@property (nonatomic, retain) NSString * vsEspecialista, *vsCategoria;

@property (nonatomic, retain) UIColor  * vcCor;

@property (nonatomic, retain) NSString * vsCodCor;

-(void)MensagemErro;




@end
