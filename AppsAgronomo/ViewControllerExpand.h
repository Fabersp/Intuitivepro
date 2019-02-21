//
//  ViewController.h
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <UCZProgressView/UCZProgressView.h>
#import "AppDelegate.h"
#import <sqlite3.h>

#import <SafariServices/SafariServices.h>






@interface ViewControllerExpand : UIViewController <MFMailComposeViewControllerDelegate>
{
    NSArray * tituloHeader;
    NSArray * primeiro;
    NSArray * segundo;
    NSArray * terceiro;
    NSArray * quarto;
    NSMutableArray * quinto;
    NSArray * Profissional;
    NSMutableArray * _selections, * lista_Id_Profissionais;
    NSArray * Convenio_Arr;
    NSDictionary * ObjetoJson_Convenio;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    bool temImagemFundo;
    bool verifica_favorito;
    NSURL * url;
    
}


@property (nonatomic, retain) NSString * tipoProfiss, *vsCor, *Id_Profissional, * url_facebook, * Url_instagram, * Url_Site, * Email, * telefone1, * telefone2, * telefone2WhatsApp, *celular,  *vsCodCor, * logradouro, * numero, * complemento, *bairro, * cidade, *estado, * WhatAppConcat,  * Endereco;

@property (strong) NSManagedObject * Favoritos;

@property (nonatomic) IBOutlet UCZProgressView *progressView;

@property (nonatomic, strong) NSMutableArray  *UrlArrayPhotos;

@property (nonatomic, retain) UIColor  * vcCor;

@property (nonatomic, strong) NSArray * photos;

@property (nonatomic, retain) NSDictionary * ObjetoJson_Convenio;

@property (weak, nonatomic) IBOutlet UIButton *btnFavoritos;

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UIButton *imgGaleria;

@property (weak, nonatomic) IBOutlet UILabel *lbNome;
@property (weak, nonatomic) IBOutlet UIView *viewSobra;

@property (weak, nonatomic) IBOutlet UILabel *lbEspecializacao;
@property (weak, nonatomic) IBOutlet UILabel *lbConselho;

@property (weak, nonatomic) IBOutlet UILabel *lbAtende;

@property (weak, nonatomic) IBOutlet UIButton *btnLigar;

@property (weak, nonatomic) IBOutlet UIButton *btnEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnSite;

@property (weak, nonatomic) IBOutlet UIButton *btnLocalizacao;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnInstagram;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackGround;

// Aleert 
@property (retain, nonatomic) UIImage *alertImage;
@property (retain, nonatomic) NSString *alertTitle;
@property (retain, nonatomic) NSArray *arrayOfButtonTitles;





@end

