//
//  tvc_especialistas.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 26/09/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UCZProgressView/UCZProgressView.h>





@interface tvc_especialistas : UITableViewController  {
    

    
    NSArray * news;
    NSDictionary * ObjetoJson;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    NSURL * url;
    
}
@property (nonatomic, retain) NSDictionary * ObjetoJson;
@property (nonatomic) IBOutlet UCZProgressView *progressView;
@property (nonatomic, retain) NSString * vsEspecialista, *vsPlanoSaude, *vsCategoria;
@property (nonatomic, retain) UIColor  * vcCor;
@property (nonatomic, retain) NSString * vsCodCor;





@end
