//
//  vc_SemDestaque.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 28/09/17.
//  Copyright © 2017 Fabricio Padua. All rights reserved.
//

#import "vc_SemDestaque.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface vc_SemDestaque ()

@end

@implementation vc_SemDestaque


@synthesize vsTelefone;
@synthesize vsNomeProfissional;
@synthesize lbNomeProfissional;
@synthesize vsTipo;

@synthesize vsCategoria;
@synthesize VsSexo;
@synthesize vcCor;
@synthesize vsCodCor;
@synthesize imgLogo;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = vsCategoria;
    
    // Do any additional setup after loading the view.
    // Natigator - cor - rgb(26,188,156) Verde
    verde    = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    // Natigator - cor - rgb(3,169,244) Azul
    azul     = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1];
    // Natigator - cor - rgb(255,82,82) Vermelho
    vermelho = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    // Natigator - cor - rgb(255,199,0) Amarelo
    amarelo  = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:0/255.0 alpha:1];
    
    // primeira verificacao = Cor
    // segunda - tipo
    // terceira - sexo
    
    
    
    if ([vsCodCor isEqual: @"1"]) {
        cor = verde;
        if ([vsTipo isEqual: @"0"]) {
            _ImgAvatar.image = [UIImage imageNamed:@"avatarCompanyVerde"];
        } else {
            if ([VsSexo isEqual: @"0"])
                _ImgAvatar.image = [UIImage imageNamed:@"avatarMulherVerde"];
            else
                _ImgAvatar.image = [UIImage imageNamed:@"avatarHomemVerde"];
        }
    }
    if ([vsCodCor isEqual: @"2"]) {
        cor = azul;
        if ([vsTipo isEqual: @"0"]) {
            _ImgAvatar.image = [UIImage imageNamed:@"avatarCompanyAzul"];
        } else {
            if ([VsSexo isEqual: @"0"])
                _ImgAvatar.image = [UIImage imageNamed:@"avatarMulherAzul"];
            else
                _ImgAvatar.image = [UIImage imageNamed:@"avatarHomemAzul"];
        }
    }

    if ([vsCodCor isEqual: @"3"]) {
        cor = vermelho;
        if ([vsTipo isEqual: @"0"]) {
            _ImgAvatar.image = [UIImage imageNamed:@"avatarCompanyVermelho"];
        } else {
            if ([VsSexo isEqual: @"0"])
                _ImgAvatar.image = [UIImage imageNamed:@"avatarMulherVermelho"];
            else
                _ImgAvatar.image = [UIImage imageNamed:@"avatarHomemVermelho"];
        }
    }

    
    if ([vsCodCor isEqual: @"4"]) {
        cor = amarelo;
    
        if ([vsTipo isEqual: @"0"]) {
            _ImgAvatar.image = [UIImage imageNamed:@"avatarCompanyAmarelo"];
        } else {
            if ([VsSexo isEqual: @"0"])
                _ImgAvatar.image = [UIImage imageNamed:@"avatarMulherAmarelo"];
            else
                _ImgAvatar.image = [UIImage imageNamed:@"avatarHomemAmarelo"];
        }
    }

    
   
    
    // self.ImgAvatar.frame.size.width/2;
    self.ImgAvatar.layer.cornerRadius = 40;
;
    self.ImgAvatar.clipsToBounds = YES;
    self.ImgAvatar.layer.borderWidth = 1.0;
//    self.ImgAvatar.layer.masksToBounds = YES;
    self.ImgAvatar.layer.borderColor = [cor CGColor];
    
    
    
    _btnLigar.layer.masksToBounds = YES;
    
    [_btnLigar setBackgroundColor:cor];

    lbNomeProfissional.text = vsNomeProfissional;
    lbNomeProfissional.textColor = cor;
    [self orientarBotoesImagem];
    
}


-(void) orientarBotoesImagem {
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        int altura = ((int)[[UIScreen mainScreen] nativeBounds].size.height);
        int largura = ((int)[[UIScreen mainScreen] nativeBounds].size.width);
        
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                
            case 480:
                printf("iPhone 4");
                imgLogo.frame  = CGRectMake(20, 120, 284, 156);
                _ImgAvatar.frame = CGRectMake( 117, 287, 100, 100);
                lbNomeProfissional.frame = CGRectMake(16, 362, 288, 48);
                _btnLigar.frame = CGRectMake(16, 486, 288, 50);
                radiunBtn = 30.0f;
                _btnLigar.layer.cornerRadius = radiunBtn;
                break;
            
            case 960:
                printf("iPhone 5");
                valor = 50.0f;
                imgLogo.frame  = CGRectMake(20, 120-valor, 284, 156);
                _ImgAvatar.frame = CGRectMake( 117, 287-valor, 80, 80);
                lbNomeProfissional.frame = CGRectMake(16, 372-valor, 288, 48);
                _btnLigar.frame = CGRectMake(16, 420-valor, 288, 50);
                radiunBtn = 25.0f;
                _btnLigar.layer.cornerRadius = radiunBtn;
                break;
                
            case 1136:
                printf("iPhone 5 or 5S or 5C");
                valor = 50.0f;
                imgLogo.frame  = CGRectMake(20, 142-valor, 284, 159);
                _ImgAvatar.frame = CGRectMake(117, 326-valor, 80, 80);
                lbNomeProfissional.frame = CGRectMake(16, 426-valor, 288, 54);
                _btnLigar.frame = CGRectMake(16, 486-valor, 288, 50);
                
                radiunBtn = 25.0f;
                _btnLigar.layer.cornerRadius = radiunBtn;
                break;
            case 1334:
                printf("iPhone 6/6S/7/8");
                valor = 70.0f;
                imgLogo.frame  = CGRectMake(20, 170-valor, 339, 185);
                _ImgAvatar.frame = CGRectMake( 139, 371-valor, 100, 100);
                lbNomeProfissional.frame = CGRectMake(16, 476-valor, 343, 61);
                _btnLigar.frame = CGRectMake(38, 547-valor, 298, 50);
                radiunBtn = 25.0f;
                _btnLigar.layer.cornerRadius = radiunBtn;
                break;
            case 2208:
                printf("iPhone 6+/6S+/7+/8+");
                valor = 80.0f;
                imgLogo.frame  = CGRectMake(43, 104, 329, 180);
                _ImgAvatar.frame = CGRectMake( 162, 316, 90, 90);
                lbNomeProfissional.frame = CGRectMake(43, 441, 329, 48);
                _btnLigar.frame = CGRectMake(43, 514, 329, 46);
                radiunBtn = 25.0f;
                _btnLigar.layer.cornerRadius = radiunBtn;
            
                break;
            case 2436:
                printf("iPhone X");
                valor = 50.0f;
                imgLogo.frame  = CGRectMake(46, 175, 284, 156);
                _ImgAvatar.frame = CGRectMake( 152, 363, 70, 70);
                lbNomeProfissional.frame = CGRectMake(18, 444, 341, 48);
                _btnLigar.frame = CGRectMake(18, 507, 341, 46);
                radiunBtn = 25.0f;
                _btnLigar.layer.cornerRadius = radiunBtn;
                break;
           
            default:
                printf("unknown");
                NSLog(@"altura ->> %d", altura);
                NSLog(@"Largura ->> %d", largura);
        }
    }
    
}


-(NSString * ) removerCaracatersTelefoneTudo:(NSString *) telefone{
    
    //NSString * retornoTelefone = [[NSString alloc] init];
    
    NSCharacterSet *unwantedChars = [NSCharacterSet characterSetWithCharactersInString:@"\"()- "];
    NSString *requiredString = [[telefone componentsSeparatedByCharactersInSet:unwantedChars] componentsJoinedByString: @""];
    
    return requiredString;
}


- (IBAction)btnLigar:(id)sender {
    
    // remover tudo pra telefone pequeno
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self removerCaracatersTelefoneTudo : vsTelefone]]];
}



@end
