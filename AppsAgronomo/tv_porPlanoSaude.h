//
//  tv_porPlanoSaude.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 01/10/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UCZProgressView/UCZProgressView.h>

@interface tv_porPlanoSaude : UITableViewController  {
    
    NSArray * news;
    NSDictionary * ObjetoJson;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    
}
@property (nonatomic, retain) NSDictionary * ObjetoJson;

@property (nonatomic, retain) NSString * vsEspecialista, *vsCategoria;

@property (nonatomic) IBOutlet UCZProgressView *progressView;

@property (nonatomic, retain) UIColor  * vcCor;

@property (nonatomic, retain) NSString * vsCodCor;




@end
