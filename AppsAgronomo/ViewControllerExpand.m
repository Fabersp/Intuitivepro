//
//  ViewController.m
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import "ViewControllerExpand.h"
#import "Reachability.h"
#import "ViewControllerCell.h"
#import <Photos/Photos.h>
#import "IDMPhotoBrowser.h"
#import "ViewControllerCellHeader.h"
#import <TSMessages/TSMessageView.h>
#import <UCZProgressView/UCZProgressView.h>
#include <stdlib.h>
#import <QuartzCore/QuartzCore.h>
#import "FCAlertView.h"

#import "Map.h"

#import "SSPopup_Verde.h"
#import "SSPopup_Vermelho.h"
#import "SSPopup_Azul.h"
#import "SSPopup_Amarelo.h"




#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]



@interface ViewControllerExpand ()<UITableViewDataSource, UITableViewDelegate, IDMPhotoBrowserDelegate, SSPopupDelegate>
{
    IBOutlet UITableView *tblView;
    NSMutableArray *arrSelectedSectionIndex;
    BOOL isMultipleExpansionAllowed;
    
}
@end

@implementation ViewControllerExpand

#pragma mark - View Life Cycle

@synthesize tipoProfiss;
@synthesize vsCor;
@synthesize vcCor;
@synthesize ObjetoJson_Convenio;
@synthesize Id_Profissional;
@synthesize btnLigar;
@synthesize btnFavoritos;
@synthesize imgAvatar;
@synthesize imgBackGround;
@synthesize imgGaleria;
@synthesize url_facebook, Url_Site, Url_instagram, Email, telefone1, telefone2, telefone2WhatsApp, celular;
@synthesize viewSobra;
@synthesize vsCodCor;
@synthesize alertImage;
@synthesize   logradouro,   numero,   complemento,  bairro,   cidade,  estado ;
@synthesize Favoritos;
@synthesize  Endereco;

@synthesize  WhatAppConcat;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    verifica_favorito = false;
    
    // abrir NSUserDefaults * btnDownload pra ver se foi setado o valor true
    NSManagedObjectContext * moc = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Favoritos"];
    lista_Id_Profissionais = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    for (NSInteger i = 0; i < lista_Id_Profissionais.count; i ++) {
        
        NSManagedObject * favoritos = [lista_Id_Profissionais objectAtIndex:i];
        
        NSString * id_prof = [favoritos valueForKey:@"id_favoritos"];
        
        if ([id_prof isEqual:Id_Profissional]) {
            verifica_favorito = true;
        }
    }
    
    btnFavoritos.hidden = verifica_favorito;
    
    self.navigationController.navigationBar.barTintColor = vcCor;
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];

//    self.navigationController.navigationBar.translucent = NO;
    
    [btnLigar setTitleColor:vcCor forState:UIControlStateNormal];

    imgAvatar.layer.cornerRadius = imgAvatar.frame.size.height/2;
    imgAvatar.clipsToBounds = YES;
    imgAvatar.layer.borderWidth = 1.0;
    
    btnFavoritos.layer.cornerRadius = 10;
    
    btnLigar.layer.cornerRadius = 20;
    btnLigar.layer.borderWidth = 1.0;
    btnLigar.layer.borderColor = [vcCor CGColor];
    
    
    
//    self.navigationController.navigationBar.barTintColor = vcCor;
//    
//    //branco botoes do navegador
//    
//    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];
    
    //Set isMultipleExpansionAllowed = true is multiple expanded sections to be allowed at a time. Default is NO.
    isMultipleExpansionAllowed = YES;
    
     // se for area medica
    
    if ([tipoProfiss  isEqual: @"1"]) {
        
        if ([vsCodCor  isEqual: @"1"]) {
            tituloHeader = [NSArray arrayWithObjects: @"Áreas de atuação", @"Endereço", @"Convênios", @"Currículo", @"Site/Rede Social", nil];
        } else {
            
            tituloHeader = [NSArray arrayWithObjects: @"Área de atuação", @"Endereço", @"Currículo", @"Site/Rede Social", nil];
        }
        
    
    } else {
         if ([vsCodCor  isEqual: @"1"]) {
             tituloHeader = [NSArray arrayWithObjects: @"Sobre nós", @"Endereço", @"Convênios", @"Serviços", @"Site/Rede Social", nil];
         } else {
             tituloHeader = [NSArray arrayWithObjects: @"Sobre nós", @"Endereço",  @"Serviços", @"Site/Rede Social", nil];
         }
        
        
    }
    
    NSString * StrConvenio = [[NSString alloc]init];
    NSString * StrCurriculo = [[NSString alloc]init];
    NSString * StrGaleria = [[NSString alloc]init];
    
    NSString * StrSobreEspec = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/especialidades.php?tipo_os=IOS&id_prof=%@", Id_Profissional];
    
    [self Loading_zero:StrSobreEspec];
    
    
    NSString * StrEndereco = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/endereco_profiss.php?tipo_os=IOS&id_prof=%@", Id_Profissional];
    [self Loading_um:StrEndereco];
    
    
    StrCurriculo = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/curriculo.php?tipo_os=IOS&id_prof=%@", Id_Profissional];
    
    
    StrConvenio = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/convenios.php?tipo_os=IOS&id_prof=%@", Id_Profissional];
    
    StrGaleria = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/fotos.php?tipo_os=IOS&id_prof=%@", Id_Profissional];
    
    
    [self Loading_dois:StrConvenio];
    [self Loading_tres:StrCurriculo];
    
    [self Loading_Profissional];
    
    [self Loading_GalariaImagem:StrGaleria];
    
    
    //[self carregarTudo];
    
    
    arrSelectedSectionIndex = [[NSMutableArray alloc] init];
    
//    if (!_UrlArrayPhotos || !_UrlArrayPhotos.count) {
//        imgGaleria.hidden = TRUE;
//    } else {
//        imgGaleria.hidden = FALSE;
//    }

    if (!isMultipleExpansionAllowed) {
        [arrSelectedSectionIndex addObject:tituloHeader];
    }
    

}

-(void) carregarTudo {
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    hostReachable = [Reachability reachabilityWithHostName:@"www.google.com.br"];
    [hostReachable startNotifier];

}

#pragma mark - TableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tituloHeader.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        if (section == 0){
            return primeiro.count;
        } else if (section == 1){
            return segundo.count;
        } else if (section == 2){
            return terceiro.count;
        }else if (section == 3){
            return quarto.count;
        } else if (section == 4){
            return quinto.count;
        } else {
            return 0;
        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
    
    if (cell == nil)
    {
        [tblView registerClass:[ViewControllerCell class] forCellReuseIdentifier:@"ViewControllerCell"];
        
        cell = [tblView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
    }
    
    NSInteger section = indexPath.section;
    
    //sections[indexPath.section].movies[indexPath.row]
    
    
    cell.imgCell.clipsToBounds = YES;
    cell.imgCell.layer.borderWidth = 1.0;
    cell.imgCell.layer.masksToBounds = YES;
    cell.imgCell.layer.borderColor = (__bridge CGColorRef _Nullable)(vcCor);
    cell.lblName.textColor = vcCor;
    
    //@"Especialidade"
    if (section == 0) {
        
        
        cell.lblName.text = [[primeiro objectAtIndex:indexPath.row]objectForKey:@"descricao"];
        
        if ([vsCodCor  isEqual: @"1"])
            // verde medico
            cell.imgCell.image = [UIImage imageNamed:@"medCheckmark"];
        if ([vsCodCor  isEqual: @"2"])
            // azul engenharia
            cell.imgCell.image = [UIImage imageNamed:@"engMarckCheck"];
        if ([vsCodCor  isEqual: @"3"])
            // vermelho juridica
            cell.imgCell.image = [UIImage imageNamed:@"jurMackCheck"];
        if ([vsCodCor  isEqual: @"4"])
            // amarelo contabil
            cell.imgCell.image = [UIImage imageNamed:@"contMarckCheck"];
        
        cell.imgLocation.hidden = true;
    }
    //, @"Endereço",
    if (section == 1) {
        
        logradouro = [[segundo objectAtIndex:indexPath.row] objectForKey:@"logradouro"];
        numero = [[segundo objectAtIndex:indexPath.row] objectForKey:@"numero"];
        complemento = [[segundo objectAtIndex:indexPath.row] objectForKey:@"complemento"];
        bairro = [[segundo objectAtIndex:indexPath.row] objectForKey:@"bairro"];
        cidade = [[segundo objectAtIndex:indexPath.row] objectForKey:@"nome"];
        estado = [[segundo objectAtIndex:indexPath.row] objectForKey:@"sigla"];
        
        Endereco = [NSString stringWithFormat:@"%@ %@ %@ %@ %@-%@",logradouro, numero, complemento, bairro, cidade, estado];
        
        
        cell.lblName.text = Endereco;
        
        if ([vsCodCor  isEqual: @"1"]) {
            // verde medico
            
            cell.imgCell.image = [UIImage imageNamed:@"medLocation"];
        }
        if ([vsCodCor  isEqual: @"2"]) {
            // azul engenharia
            
            cell.imgCell.image = [UIImage imageNamed:@"engLocation"];
        }
        if ([vsCodCor  isEqual: @"3"]) {
            // vermelho juridica
            
            cell.imgCell.image = [UIImage imageNamed:@"jurLocation"];
        }
        if ([vsCodCor  isEqual: @"4"]) {
            // amarelo contabil
            
            cell.imgCell.image = [UIImage imageNamed:@"contLocation"];
        }
        
        cell.imgLocation.hidden = false;
    }
    // @"Convênios"
    if (section == 2) {
        cell.imgCell.layer.cornerRadius = cell.imgCell.frame.size.height/2;
        cell.imgLocation.hidden = true;
        cell.lblName.text = [[terceiro objectAtIndex:indexPath.row]objectForKey:@"nome"];
        
        NSURL * urlImage = [NSURL URLWithString:[[terceiro objectAtIndex:indexPath.row] objectForKey:@"url_imagem"]];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:urlImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ViewControllerCell * updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell)
                            updateCell.imgCell.image = image;
                    });
                }
            }
        }];
        [task resume];

    }
    //, @"Currículo"

    if (section == 3) {
        cell.imgLocation.hidden = true;
        cell.lblName.text = [[quarto objectAtIndex:indexPath.row] objectForKey:@"descricao"];
        if ([vsCodCor  isEqual: @"1"])
            // verde medico
            cell.imgCell.image = [UIImage imageNamed:@"medCheckmark"];
        if ([vsCodCor  isEqual: @"2"])
            // azul engenharia
            cell.imgCell.image = [UIImage imageNamed:@"engMarckCheck"];
        if ([vsCodCor  isEqual: @"3"])
            // vermelho juridica
            cell.imgCell.image = [UIImage imageNamed:@"jurMackCheck"];
        if ([vsCodCor  isEqual: @"4"])
            // amarelo contabil
            cell.imgCell.image = [UIImage imageNamed:@"contMarckCheck"];
        

    }
    //, @"Site/Rede Social", nil];
    if (section == 4) {
        cell.imgLocation.hidden = true;
        cell.imgCell.layer.cornerRadius = 0;
        if ([[quinto objectAtIndex:indexPath.row] containsString:@"@"]) {
            cell.lblName.text = @"E-mail";
            
            if ([vsCodCor  isEqual: @"1"])
                // verde medico
                cell.imgCell.image = [UIImage imageNamed:@"medEmail"];
            if ([vsCodCor  isEqual: @"2"])
                // azul engenharia
                cell.imgCell.image = [UIImage imageNamed:@"engEmail"];
            if ([vsCodCor  isEqual: @"3"])
                // vermelho juridica
                cell.imgCell.image = [UIImage imageNamed:@"jurEmail"];
            if ([vsCodCor  isEqual: @"4"])
                // amarelo contabil
                cell.imgCell.image = [UIImage imageNamed:@"contEmail"];
        
        }
        
        
        NSRange rangeAt = [[quinto objectAtIndex:indexPath.row] rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        NSRange rangefacebook = [[quinto objectAtIndex:indexPath.row] rangeOfString:@"facebook" options:NSCaseInsensitiveSearch];
        
        NSRange rangeInstagram = [[quinto objectAtIndex:indexPath.row] rangeOfString:@"instagram" options:NSCaseInsensitiveSearch];
        
        if ([[quinto objectAtIndex:indexPath.row] containsString:@"http"] &&
            rangeAt.location == NSNotFound  &&
            rangefacebook.location == NSNotFound  &&
            rangeInstagram.location == NSNotFound ) {
           
            cell.lblName.text = @"Site";
            if ([vsCodCor  isEqual: @"1"])
                // verde medico
                cell.imgCell.image = [UIImage imageNamed:@"medSite"];
            if ([vsCodCor  isEqual: @"2"])
                // azul engenharia
                cell.imgCell.image = [UIImage imageNamed:@"engSite"];
            if ([vsCodCor  isEqual: @"3"])
                // vermelho juridica
                cell.imgCell.image = [UIImage imageNamed:@"jurSite"];
            if ([vsCodCor  isEqual: @"4"])
                // amarelo contabil
                cell.imgCell.image = [UIImage imageNamed:@"contSite"];
            
        }
        if ([[quinto objectAtIndex:indexPath.row] containsString:@"facebook"]) {
            cell.lblName.text = @"Facebook";
            if ([vsCodCor  isEqual: @"1"])
                // verde medico
                cell.imgCell.image = [UIImage imageNamed:@"medFacebook"];
            if ([vsCodCor  isEqual: @"2"])
                // azul engenharia
                cell.imgCell.image = [UIImage imageNamed:@"engFacebook"];
            if ([vsCodCor  isEqual: @"3"])
                // vermelho juridica
                cell.imgCell.image = [UIImage imageNamed:@"jurFacebook"];
            if ([vsCodCor  isEqual: @"4"])
                // amarelo contabil
                cell.imgCell.image = [UIImage imageNamed:@"contFacebook"];
        }
        if ([[quinto objectAtIndex:indexPath.row] containsString:@"instagram"]) {
            cell.lblName.text = @"Instagram";
            if ([vsCodCor  isEqual: @"1"])
                // verde medico
                cell.imgCell.image = [UIImage imageNamed:@"medInstagram"];
            if ([vsCodCor  isEqual: @"2"])
                // azul engenharia
                cell.imgCell.image = [UIImage imageNamed:@"engInstagram"];
            if ([vsCodCor  isEqual: @"3"])
                // vermelho juridica
                cell.imgCell.image = [UIImage imageNamed:@"jurInstagram"];
            if ([vsCodCor  isEqual: @"4"])
                // amarelo contabil
                cell.imgCell.image = [UIImage imageNamed:@"contInstagram"];
        }
    
    }
    
    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 58.0f;

}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 55.0f;
//}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ViewControllerCellHeader *headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    
    if (headerView ==nil)
    {
        [tblView registerClass:[ViewControllerCellHeader class] forCellReuseIdentifier:@"ViewControllerCellHeader"];

        headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    }

    //headerView.backgroundColor = vcCor;
    headerView.contentView.backgroundColor = vcCor;
    
    NSString *titulo =[tituloHeader objectAtIndex:section];
    
    headerView.lbTitle.text = titulo;
    
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        headerView.btnShowHide.selected = YES;
        headerView.btnTouchHeader.selected = YES;
    }
    
    [[headerView btnShowHide] setTag:section];
    
    [[headerView btnShowHide] addTarget:self action:@selector(btnTapShowHideSection:) forControlEvents:UIControlEventTouchUpInside];
    
    [[headerView btnTouchHeader] setTag:section];
    
    [[headerView btnTouchHeader] addTarget:self action:@selector(btnTapShowHideSection:) forControlEvents:UIControlEventTouchUpInside];
    
  // @"Especialidade", @"Endereço", @"Currículo", @"Convênios", @"Site/Rede Social", nil];
    if (section == 0 ) {
        if ([tipoProfiss  isEqual: @"1"]){
            headerView.imgHeader.image = [UIImage imageNamed:@"cap.png"];
        } else {
            headerView.imgHeader.image = [UIImage imageNamed:@"copyAndPaste.png"];
        }
    }
    //Endereço
    if (section == 1 ) {
        headerView.imgHeader.image = [UIImage imageNamed:@"locationPin.png"];
    }
    //Currículo
    if (section == 2 ) {
        
        if (tituloHeader.count == 5) {
            headerView.imgHeader.image = [UIImage imageNamed:@"cruz.png"];
        } else {
           headerView.imgHeader.image = [UIImage imageNamed:@"list.png"];
        }
    }
    //Convênios
    if (section == 3) {
        // se for 5 linhas tem convenio
        if (tituloHeader.count == 5) {
            headerView.imgHeader.image = [UIImage imageNamed:@"list.png"];
        } else {
            // se for 4 linhas
            headerView.imgHeader.image = [UIImage imageNamed:@"globeBranco.png"];
        }

    }
    //Site/Rede Social
    if (section == 4) {
        headerView.imgHeader.image = [UIImage imageNamed:@"globeBranco.png"];
    }
    
    
//    [headerView.contentView setBackgroundColor:section%2==0?[UIColor groupTableViewBackgroundColor]:[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5f]];

    return headerView.contentView;
}


-(IBAction)btnTapShowHideSection:(UIButton*)sender
{
    if (!sender.selected)
    {
        if (!isMultipleExpansionAllowed) {
            [arrSelectedSectionIndex replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:sender.tag]];
        }else {
            [arrSelectedSectionIndex addObject:[NSNumber numberWithInteger:sender.tag]];
        }

        sender.selected = YES;
    }else{
        sender.selected = NO;
        
        if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:sender.tag]])
        {
            [arrSelectedSectionIndex removeObject:[NSNumber numberWithInteger:sender.tag]];
        }
    }

    if (!isMultipleExpansionAllowed) {
        [tblView reloadData];
    }else {
        [tblView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    
    NSString * latitude = [[Profissional objectAtIndex:0] objectForKey:@"latitude_prof"];
    
    NSString * longitude = [[Profissional objectAtIndex:0] objectForKey:@"longitude_prof"];
    
    
    NSLog(@"%@", latitude);
    
    NSLog(@"%@", longitude);
    
    NSString * lat_long = [NSString stringWithFormat:@"comgooglemaps://?daddr=%@,%@&zoom=30", latitude, longitude];
    
    
    
    if (section == 1) {
        // Endereço - Google Map
        if (index == 0) {
            if ([[UIApplication sharedApplication] canOpenURL:
                 [NSURL URLWithString:@"comgooglemaps://"]]) {
                [[UIApplication sharedApplication] openURL:
                 [NSURL URLWithString:lat_long]];
            } else {
                
                Map * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"1234"];
                
                vc.endereco = Endereco;
                vc.cinema = @"Como chegar";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    }
     if (section == 4) {
         
         // Email
         
         
         
         if ([[quinto objectAtIndex:indexPath.row] containsString:@"@"]) {
            
             
             if ([MFMailComposeViewController canSendMail])
             {
                 MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                 
                 mailer.mailComposeDelegate = self;
                 
                 [mailer setSubject:@"Contato App IntuitivePro"];
                 
                 NSArray *toRecipients = [NSArray arrayWithObjects:[quinto objectAtIndex:indexPath.row], nil];
                 [mailer setToRecipients:toRecipients];
                 // only for iPad
                 mailer.modalPresentationStyle = UIModalPresentationPageSheet;
                 [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
             }
             else
             {
                 UIAlertController * view =  [UIAlertController
                                              alertControllerWithTitle:@"Erro"
                                              message:@"Este dispositivo não suporta o envio de e-mail!"
                                              preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction * ok = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           
                                           [view dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
                 
                 [view addAction:ok];
                 [self presentViewController:view animated:NO completion:nil];
   
             }

         }
         NSRange rangeAt = [[quinto objectAtIndex:indexPath.row] rangeOfString:@"@" options:NSCaseInsensitiveSearch];
         
         NSRange rangefacebook = [[quinto objectAtIndex:indexPath.row] rangeOfString:@"facebook" options:NSCaseInsensitiveSearch];
         
         NSRange rangeInstagram = [[quinto objectAtIndex:indexPath.row] rangeOfString:@"instagram" options:NSCaseInsensitiveSearch];
         
         
         if (rangeAt.location == NSNotFound  &&
             rangefacebook.location == NSNotFound  &&
             rangeInstagram.location == NSNotFound ) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[quinto objectAtIndex:indexPath.row]]];
            
            NSLog(@"site");
        
        }
        if ([[quinto objectAtIndex:indexPath.row] containsString:@"facebook"]) {
            // Check if FB app installed on device
            
            NSString * UrlFacebook = [quinto objectAtIndex:indexPath.row];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UrlFacebook]];

            
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {
//
//                NSString * profileFacebook = [NSString stringWithFormat:@"fb://profile/%@", [[Profissional objectAtIndex:0] objectForKey:@"id_facebook"] ];
//
//                //NSLog(@"%@", profileFacebook);
//
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"facebook://user?screen_name=medeimagem"]];
//            }
//            else {
//
//            }
            
            NSLog(@"facebook");
        }
        
         if ([[quinto objectAtIndex:indexPath.row] containsString:@"instagram"]) {
             
             NSString * UrlInstagram = [quinto objectAtIndex:indexPath.row];
             
             NSString * profile = [NSString stringWithFormat:@"instagram://user?username=%@", [[Profissional objectAtIndex:0] objectForKey:@"id_instagram"] ];
            
             NSURL *instagramURL = [NSURL URLWithString:profile];
            
             
             if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
                [[UIApplication sharedApplication] openURL:instagramURL];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UrlInstagram]];
            }

             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[quinto objectAtIndex:indexPath.row]]];
            NSLog(@"instagram");
        }
        
     }

   
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //	[self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}




#pragma mark - Memory Warning
- (NSManagedObjectContext *) managedObjectContext
{
    NSManagedObjectContext * context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)btnFavoritos:(id)sender {
    

    UIAlertController * view =  [UIAlertController
                                 alertControllerWithTitle:@"Mensagem"
                                 message:@"Deseja adicionar em seus favoritos?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction
                          actionWithTitle:@"Sim"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action) {
                              
                              NSManagedObjectContext * context = [self managedObjectContext];
                              //criar novo favorito
                              NSManagedObject * novoFavorito = [NSEntityDescription insertNewObjectForEntityForName:@"Favoritos" inManagedObjectContext:context];
                              [novoFavorito setValue:Id_Profissional forKey:@"id_favoritos"];
                              
                              NSError * error = nil;
                              if (![context save:&error]) {
                                  
                              } else {
                                 btnFavoritos.hidden = true;
                              }
                              
                              [view dismissViewControllerAnimated:YES completion:nil];
                          }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Não"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [view addAction:ok];
    [view addAction:cancel];
    [self presentViewController:view animated:NO completion:nil];
    
}

- (IBAction)btnGaleria:(id)sender {

    // Create an array to store IDMPhoto objects
    _photos = [NSMutableArray new];
    
    // Or use this constructor to receive an NSArray of IDMPhoto objects from your NSURL objects
    _photos = [IDMPhoto photosWithURLs:[_UrlArrayPhotos valueForKey:@"url_foto"]];
    
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:_photos];
    
    //browser.actionButtonTitles = [_UrlArrayPhotos valueForKey:@"descricao"];
    
    browser.displayActionButton = YES;
    browser.displayArrowButton = YES;
    browser.displayCounterLabel = YES;
    
    browser.autoHideInterface = YES;
    browser.usePopAnimation = YES;
    browser.forceHideStatusBar = YES;
    
    [self presentViewController:browser animated:YES completion:nil];

}



- (NSUInteger)numberOfPhotosInPhotoBrowser:(IDMPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <IDMPhoto>)photoBrowser:(IDMPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(IDMPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(IDMPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}
    

-(NSString * ) removerCaracatersTelefone:(NSString *) telefone{
    
    //NSString * retornoTelefone = [[NSString alloc] init];
    
    NSCharacterSet *unwantedChars = [NSCharacterSet characterSetWithCharactersInString:@"\"()- "];
    NSString *requiredString = [[telefone componentsSeparatedByCharactersInSet:unwantedChars] componentsJoinedByString: @""];
    
    return requiredString;
}

    

- (IBAction)btnLigar:(id)sender {
    
    NSLog(@"tele 1 ->> %@", telefone1);
    NSLog(@"tele 2 ->> %@", telefone2);
    NSLog(@"celular ->> %@", celular);
    NSLog(@"whats ->> %@", telefone2WhatsApp);
    
    if (telefone1 == nil) { telefone1 = @"";  }
    if (telefone2 == nil) { telefone2 = @"";  }
    if (celular == nil) {  celular = @"";  }
    
    // 1  sem numero de telefones disponiveis //
    if ([telefone1 isEqual: @""] && [telefone2 isEqual: @""] && [celular isEqual: @""] ) {
        
        UIAlertController * view =  [UIAlertController
                                     alertControllerWithTitle:@"Erro"
                                     message:@"No momento não há telefone disponível!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction
                              actionWithTitle:@"Ok"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        
        [view addAction:ok];
        [self presentViewController:view animated:NO completion:nil];
    }
    
    // 1 somente telefone 1
    if (! [telefone1 isEqual: @""] && [telefone2 isEqual: @""] && [celular isEqual: @""]){
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
    }
    
    // 2 somente telefone 2
    if ( [telefone1 isEqual: @""] && ![telefone2 isEqual: @""] && [celular isEqual: @""]){
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
    }
    
    // 3 somente celular
    if ( [telefone1 isEqual: @""] && [telefone2  isEqual: @""] &&
        ! [celular isEqual: @""] && [telefone2WhatsApp isEqual: @"0"]){

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
    }
    // telefone 1 e telefone 2
    if (! [telefone1 isEqual: @""] && ![telefone2 isEqual: @""] && [celular isEqual: @""]) {
        
        if ([telefone2WhatsApp isEqual: @"1"]) {
            WhatAppConcat = [NSString stringWithFormat:@"%@ - WhatsApp", celular];
        } else {
            WhatAppConcat = celular;
        }
        
        NSArray *QArray=[[NSArray alloc]initWithObjects: telefone1, telefone2,  nil];
        
        if ([vsCodCor  isEqual: @"1"]) {
            // verde medico
            SSPopup_Verde * selection = [[SSPopup_Verde alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //            selection.SSPopupDelegate=self;
            
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
            }];

        
        } else if ([vsCodCor  isEqual: @"2"]) {
            // azul engenharia
            SSPopup_Azul * selection = [[SSPopup_Azul alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //            selection.SSPopupDelegate=self;
            
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
            }];

        
        } else if ([vsCodCor  isEqual: @"3"]) {
            // vermelho juridica
            SSPopup_Vermelho * selection = [[SSPopup_Vermelho alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //            selection.SSPopupDelegate=self;
            
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
            }];

        
        } else if ([vsCodCor  isEqual: @"4"]) {
            // amarelo contabil
            SSPopup_Amarelo * selection = [[SSPopup_Amarelo alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //            selection.SSPopupDelegate=self;
            
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
            }];

        }
        
    
                
    }

    // telefone 1 e celular
    if (! [telefone1 isEqual: @""] && [telefone2 isEqual: @""] && ![celular isEqual: @""]) {
        
        if ([telefone2WhatsApp isEqual: @"1"]) {
            WhatAppConcat = [NSString stringWithFormat:@"%@ - WhatsApp", celular];
        } else {
            WhatAppConcat = celular;
        }
        
        NSArray *QArray=[[NSArray alloc]initWithObjects: telefone1, WhatAppConcat,  nil];
        
        if ([vsCodCor  isEqual: @"1"]) {
            // verde medico
            SSPopup_Verde * selection = [[SSPopup_Verde alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"2"]) {
            // azul engenharia
            SSPopup_Azul * selection = [[SSPopup_Azul alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"3"]) {
            // vermelho juridica
            SSPopup_Vermelho * selection = [[SSPopup_Vermelho alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"4"]) {
            // amarelo contabil
            SSPopup_Amarelo * selection = [[SSPopup_Amarelo alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

        }

        
        
    }
    
    // 4   somente celular WhatsApp
    if ( [telefone1 isEqual: @""] && [telefone2  isEqual: @""] &&
        ! [celular  isEqual: @""] && [telefone2WhatsApp  isEqual: @"1"]) {
        
        WhatAppConcat = [NSString stringWithFormat:@"%@ - WhatsApp", celular];
        
        NSArray * QArray = [[NSArray alloc]initWithObjects:WhatAppConcat,  nil];
        
        if ([vsCodCor  isEqual: @"1"]) {
            // verde medico
            SSPopup_Verde * selection = [[SSPopup_Verde alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
           // selection.SSPopupDelegate = self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];
        } else if ([vsCodCor  isEqual: @"2"]) {
            // azul engenharia
            SSPopup_Azul * selection = [[SSPopup_Azul alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            // selection.SSPopupDelegate = self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];
            

            
        } else if ([vsCodCor  isEqual: @"3"]) {
            // vermelho juridica
            SSPopup_Vermelho * selection = [[SSPopup_Vermelho alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            // selection.SSPopupDelegate = self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];
            

            
        } else if ([vsCodCor  isEqual: @"4"]) {
            // amarelo contabil
            SSPopup_Amarelo * selection = [[SSPopup_Amarelo alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            // selection.SSPopupDelegate = self;
            [self.view  addSubview:selection];
            
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];
            

        }

        
    }
    
    
    
    // telefone 2 e celular
    if ([telefone1 isEqual: @""] && ![telefone2 isEqual: @""] && ![celular isEqual: @""]){
        
        if ( [telefone2WhatsApp  isEqual: @"1"]) {
            WhatAppConcat = [NSString stringWithFormat:@"%@ - WhatsApp", celular];
        } else {
            WhatAppConcat = celular;
        }
        
        NSArray * QArray= [[NSArray alloc]initWithObjects: telefone2, WhatAppConcat,  nil];
        
        if ([vsCodCor  isEqual: @"1"]) {
            // verde medico
            SSPopup_Verde * selection = [[SSPopup_Verde alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
            
        } else if ([vsCodCor  isEqual: @"2"]) {
            // azul engenharia
            SSPopup_Azul * selection = [[SSPopup_Azul alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"3"]) {
            // vermelho juridica
            SSPopup_Vermelho * selection = [[SSPopup_Vermelho alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"4"]) {
            // amarelo contabil
            SSPopup_Amarelo * selection = [[SSPopup_Amarelo alloc]init];
            selection.backgroundColor= [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

        }

        
            }
    
    // todos os telefones
    if (! [telefone1 isEqual: @""] && ![telefone2 isEqual: @""] && ![celular isEqual: @""]){
    
        if ( [telefone2WhatsApp isEqual: @"1"]) {
            WhatAppConcat = [NSString stringWithFormat:@"%@ - WhatsApp", celular];
        } else {
            WhatAppConcat = celular;
        }
        
        NSArray *QArray=[[NSArray alloc]initWithObjects:telefone1, telefone2, WhatAppConcat,  nil];
        
        if ([vsCodCor  isEqual: @"1"]) {
            // verde medico
            SSPopup_Verde * selection = [[SSPopup_Verde alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 2 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"2"]) {
            // azul engenharia
            SSPopup_Azul * selection = [[SSPopup_Azul alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 2 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"3"]) {
            // vermelho juridica
            SSPopup_Vermelho * selection = [[SSPopup_Vermelho alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 2 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

            
        } else if ([vsCodCor  isEqual: @"4"]) {
            // amarelo contabil
            SSPopup_Amarelo * selection = [[SSPopup_Amarelo alloc]init];
            selection.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,
                                         self.view.frame.size.height);
            //selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:QArray withSender:sender  withTitle:@"Selecione" setCompletionBlock:^(int tag){
                
                if (tag == 0 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone1]]]];
                }
                if (tag == 1 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:telefone2]]]];
                }
                
                if (tag == 2 ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self removerCaracatersTelefone:celular]]]];
                }
            }];

        }

        
    }
}


//--------------- Verificar a internet -----------------//

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)MensagemErro{
    
        // Add a button inside the message
        [TSMessage showNotificationInViewController:self
                                              title:@"Sem conexão com a intenet"
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeError
                                           duration:10.0
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:^{
                                         NSLog(@"User tapped the button");

                                     }
                                         atPosition:TSMessageNotificationPositionTop+20
                               canBeDismissedByUser:YES];
}


-(void) checkNetworkStatus:(NSNotification *)notice {
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable: {
            [self MensagemErro];
            self->internetActive = NO;
            break;
        }
        case ReachableViaWiFi: {
            self->internetActive = YES;
           [self carregarTudo];
            
            break;
        }
        case ReachableViaWWAN: {
            self->internetActive = YES;
            [self carregarTudo];
            break;
        }
    }
}



-(void)Loading_zero:(NSString *) StrSobreEspec {

    url = [NSURL URLWithString:StrSobreEspec];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            primeiro = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        }
    }];
    [task resume];
}

-(void)Loading_um :(NSString *) StrEndereco {
    
    url = [NSURL URLWithString:StrEndereco];
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            segundo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            
        }
    }];
    [task resume];
    
//    NSURLSession * session = [NSURLSession sharedSession];
//    
//    NSURLSessionDownloadTask * task =
//    [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
//        
//        segundo = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//        
//    }];
//    
//    [task resume];
    
}


-(void)Loading_dois:(NSString *) StrConvenio {
    
    url = [NSURL URLWithString:StrConvenio];
    
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            terceiro = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            
        }
    }];
    [task resume];
    
//    NSURLSession * session = [NSURLSession sharedSession];
//    
//    NSURLSessionDownloadTask * task =
//    [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
//        
//        
//        terceiro = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//        
//    }];
//    [task resume];
    
}


-(void)Loading_tres:(NSString *) StrCurriculo {
    
    url = [NSURL URLWithString:StrCurriculo];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            if (tituloHeader.count == 4) {
                terceiro = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            } else {
                quarto = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            }
            
        }
    }];
    [task resume];

    
    
    
//    NSURLSession * session = [NSURLSession sharedSession];
//    
//    NSURLSessionDownloadTask * task =
//    [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
//        
//        if (tituloHeader.count == 4) {
//            terceiro = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//        } else {
//            quarto = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//        }
//    }];
//    [task resume];
    
}


-(void)Loading_GalariaImagem:(NSString *) StrGaleria {
    
    url = [NSURL URLWithString:StrGaleria];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            _UrlArrayPhotos =  [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!_UrlArrayPhotos || !_UrlArrayPhotos.count) {
                            imgGaleria.hidden = TRUE;
                        } else {
                            
                            imgGaleria.hidden = FALSE;
                        }
                        
                    });
        }
    }];
    [task resume];
    
}




-(void)Loading_Profissional {
    
    self.progressView = [[UCZProgressView alloc] initWithFrame:self.view.bounds];
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.progressView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_progressView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_progressView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_progressView]-0-|" options:0 metrics:nil views:views]];
    
    self.progressView.indeterminate = YES;
    self.progressView.tintColor = vcCor;
    
    self.progressView.radius = 40.0;
    
    self.progressView.lineWidth = 6.0;
    
    NSString * StrProfissonal = [NSString stringWithFormat:@"http://www.promastersolution.com.br/guia/api/dados_profissionais.php?tipo_os=IOS&id_prof=%@", Id_Profissional];
    
    NSLog(@"%@", StrProfissonal);
    
    url = [NSURL URLWithString:StrProfissonal];
    
//    NSURLSession * session = [NSURLSession sharedSession];
//    
//    NSURLSessionDownloadTask * task =
//    [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * parseError = nil;
            Profissional = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    
//        Profissional = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            
            NSString * SrUrlAvatar = [[Profissional objectAtIndex:0] objectForKey:@"url_foto"];
            
            if (SrUrlAvatar != nil) {
                
                NSURL * urlImageAvatar = [NSURL URLWithString:SrUrlAvatar];
                NSURLSession * session = [NSURLSession sharedSession];
                
                NSURLSessionDownloadTask * task = [session downloadTaskWithURL:urlImageAvatar
                                                             completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                 
                                                                 NSData * imageData = [[NSData alloc] initWithContentsOfURL:location];
                                                                 UIImage *img = [UIImage imageWithData:imageData];
                                                                 
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     imgAvatar.image = img;
                                                                 });
                                                             }];
                [task resume];
            
            }
            
            NSString * StrImgBack = [[Profissional objectAtIndex:0] objectForKey:@"url_background"];
            
            if (StrImgBack != nil) {
                NSURL * urlImageback = [NSURL URLWithString:StrImgBack];
                temImagemFundo = true;
                NSURLSession * sessionback = [NSURLSession sharedSession];
                
                NSURLSessionDownloadTask * taskBack = [sessionback downloadTaskWithURL:urlImageback
                                                                     completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                         
                                                                         NSData * imageData = [[NSData alloc] initWithContentsOfURL:location];
                                                                         UIImage *img = [UIImage imageWithData:imageData];
                                                                         
                                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                                             imgBackGround.image = img;
                                                                             
                                                                             
                                                                             // mostrar a imagem de fundo
                                                               
                                                                             
                                                                         });
                                                                     }];
                
                
                [taskBack resume];
            } else {
                temImagemFundo = false;
                // mostrar a imagem de fundo
                
            }

            NSString * Nome = [[Profissional objectAtIndex:0] objectForKey:@"nome_prof"];
            NSString * Tratamento = [[Profissional objectAtIndex:0] objectForKey:@"tratamento"];
            
            if ([Tratamento  isEqual: @""]) {
                _lbNome.text = Nome;
                
            } else {
                _lbNome.text = [NSString stringWithFormat:@"%@ %@", Tratamento,Nome] ;
            }
            
            _lbEspecializacao.text = [[Profissional objectAtIndex:0] objectForKey:@"espec"];
            _lbConselho.text = [[Profissional objectAtIndex:0] objectForKey:@"conselho"];
            
            _lbAtende.text = [[Profissional objectAtIndex:0] objectForKey:@"atende_Onde"];
            
            url_facebook = [[[Profissional objectAtIndex:0] objectForKey:@"url_facebook"] stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
            
            
            if (url_facebook == nil || [url_facebook isEqual: @""]) {
                _btnFacebook.hidden = true;
            } else {
                _btnFacebook.hidden = false;
            }
            
            Url_instagram = [[[Profissional objectAtIndex:0] objectForKey:@"url_instagram"] stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
            
            if (Url_instagram == nil || [Url_instagram isEqual:@""]) {
                _btnInstagram.hidden = true;
            } else {
                _btnInstagram.hidden = false;
            }
            
            Url_Site = [[[Profissional objectAtIndex:0] objectForKey:@"url_paginaweb"] stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
            
            if (Url_Site == nil || [Url_Site isEqual:@""]) {
                _btnSite.hidden = true;
            } else {
                _btnSite.hidden = false;
            }
            
            Email = [[[Profissional objectAtIndex:0] objectForKey:@"email"] stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]];
            
            if (Email == nil || [Email isEqual:@""]){
                _btnEmail.hidden = true;
            } else {
                _btnEmail.hidden = false;
            }
            
            telefone1 =  [[[Profissional objectAtIndex:0] objectForKey:@"telefone1"] stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
            
            telefone2 = [[[Profissional objectAtIndex:0] objectForKey:@"telefone2"] stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];

            telefone2WhatsApp = [[Profissional objectAtIndex:0] objectForKey:@"telefoneWhatsApp"];
            
            celular = [[[Profissional objectAtIndex:0] objectForKey:@"celular"] stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
            
            if ([tipoProfiss  isEqual: @"1"]) {
                // não mostra a image de fundo
                imgBackGround.hidden = true;
                viewSobra.hidden = true;
                // coloca a cor padrao quando nao for empresa
                imgAvatar.layer.borderColor = [vcCor CGColor];
                // muda a imagem do botao da galeria
                
                if ([vsCodCor  isEqual: @"1"]) {
                    // verde medico
                    [imgGaleria setImage:[UIImage imageNamed:@"GaleriaMed"] forState:UIControlStateNormal];
                    
                }
                if ([vsCodCor  isEqual: @"2"]) {
                    // azul engenharia
                    [imgGaleria setImage:[UIImage imageNamed:@"GaleriaEng"] forState:UIControlStateNormal];
                }
                if ([vsCodCor  isEqual: @"3"]) {
                    // vermelho juridica
                    [imgGaleria setImage:[UIImage imageNamed:@"GaleriaJur"] forState:UIControlStateNormal];
                }
                if ([vsCodCor  isEqual: @"4"]) {
                    // amarelo contabil
                    [imgGaleria setImage:[UIImage imageNamed:@"GaleriaCon"] forState:UIControlStateNormal];
                }

                // botao favoritos cor padrao fundo
                btnFavoritos.backgroundColor = vcCor;
                // texto do botao cor branca
                [btnFavoritos setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
                
                // textos
                _lbNome.textColor = vcCor;
                _lbConselho.textColor = vcCor;
                _lbEspecializacao.textColor = vcCor;
                _lbAtende.textColor = vcCor;
            } else {
                if (temImagemFundo == true) {
                    imgBackGround.hidden = false;
                    viewSobra.hidden = false;
                    
                    // coloca branco a borda da imagem
                    imgAvatar.layer.borderColor = [Rgb2UIColor(255,255,255) CGColor];
                    // coloca a borda na cor padrao
                    btnFavoritos.layer.borderColor = [vcCor CGColor];
                    btnFavoritos.clipsToBounds = YES;
                    btnFavoritos.layer.borderWidth = 1.0;
                    // muda a imagem do botao da galeria
                    UIImage *btnImageEmp = [UIImage imageNamed:@"galeriaBranca"];
                    [imgGaleria setImage:btnImageEmp forState:UIControlStateNormal];
                    // botao favoritos branco fundo
                    btnFavoritos.backgroundColor = Rgb2UIColor(255,255,255);
                    // texto do botao cor verde
                    btnFavoritos.titleLabel.textColor = vcCor;
                    // textos
                    _lbNome.textColor = Rgb2UIColor(255,255,255);
                    _lbConselho.textColor = Rgb2UIColor(255,255,255);
                    _lbEspecializacao.textColor = Rgb2UIColor(255,255,255);
                    _lbAtende.textColor = Rgb2UIColor(255,255,255);
                    
                } else {
                    // não mostra a image de fundo
                    imgBackGround.hidden = true;
                    viewSobra.hidden = true;
                    // coloca a cor padrao quando nao for empresa
                    imgAvatar.layer.borderColor = [vcCor CGColor];
                    // muda a imagem do botao da galeria
                    
                    if ([vsCodCor  isEqual: @"1"]) {
                        // verde medico
                        [imgGaleria setImage:[UIImage imageNamed:@"GaleriaMed"] forState:UIControlStateNormal];
                        
                    }
                    if ([vsCodCor  isEqual: @"2"]) {
                        // azul engenharia
                        [imgGaleria setImage:[UIImage imageNamed:@"GaleriaEng"] forState:UIControlStateNormal];
                    }
                    if ([vsCodCor  isEqual: @"3"]) {
                        // vermelho juridica
                        [imgGaleria setImage:[UIImage imageNamed:@"GaleriaJur"] forState:UIControlStateNormal];
                    }
                    if ([vsCodCor  isEqual: @"4"]) {
                        // amarelo contabil
                        [imgGaleria setImage:[UIImage imageNamed:@"GaleriaCon"] forState:UIControlStateNormal];
                    }
                    
                    // botao favoritos cor padrao fundo
                    btnFavoritos.backgroundColor = vcCor;
                    // texto do botao cor branca
                    [btnFavoritos setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
                    
                    // textos
                    _lbNome.textColor = vcCor;
                    _lbConselho.textColor = vcCor;
                    _lbEspecializacao.textColor = vcCor;
                    _lbAtende.textColor = vcCor;
                }
                
                
            }

            
            imgAvatar.hidden = false;
           // imgGaleria.hidden = false;
            
            _lbNome.hidden = false;
            _lbConselho.hidden = false;
            _lbEspecializacao.hidden = false;
            _lbAtende.hidden = false;

            quinto = [[NSMutableArray alloc] init];
            
            
        
            if (![Email isEqual: @""]){
                [quinto addObject:Email];
            }
            if (![Url_Site isEqual: @""]){
                [quinto addObject:Url_Site];
            }
            if (![url_facebook isEqual: @""]){
                [quinto addObject:url_facebook];
            }
            if (![Url_instagram isEqual: @""]){
                [quinto addObject:Url_instagram];
            }
            
            
            
            
            
           [self.progressView removeFromSuperview];
        
            
            
            
            
        });

        }
    }];
    [task resume];
    
}










@end
