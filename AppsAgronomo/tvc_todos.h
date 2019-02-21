//
//  tvc_todos.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 21/01/18.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UCZProgressView/UCZProgressView.h>

@interface tvc_todos : UITableViewController <UISearchBarDelegate> {
    
    
    NSArray * news;
    NSArray * filtered;
    bool isFiltered;
    NSDictionary * ObjetoJson;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    NSURL * url;
    
}

@property (weak, nonatomic) IBOutlet UISearchBar *buscar;


@property (nonatomic, retain) NSDictionary * ObjetoJson;

@property (nonatomic, retain) NSString * vsEspecialista, *vsCor, *vsIdCategoria, *vsIdEspecialista, *vsCodCor, *vsIdPlano;

@property (nonatomic, retain) UIColor  * vcCor;

@property (nonatomic) IBOutlet UCZProgressView *progressView;

-(void) BtnBuscar;

@end
