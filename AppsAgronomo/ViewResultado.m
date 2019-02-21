//
//  ViewResultado.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 12/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import "ViewResultado.h"

@interface ViewResultado ()

@end

@implementation ViewResultado

@synthesize imageArray;
@synthesize scrollView;
@synthesize pageControl;
@synthesize Id_Galeria, Operacao,  Valor, Municipio, Endereco, Descricao_Completa;
@synthesize lb_Valor, lb_Endereco, lb_Operacao, lb_Municipio, lb_CodigoAnuncio, lb_Descricao_Completa;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView* imglog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_banner_80-40-transparente"]];
//    self.navigationItem.titleView = imglog;
    
    
    self.title = @"Detalhes";
    
    
    lb_CodigoAnuncio.text = [NSString stringWithFormat:@"Código: %@", Id_Galeria];
    lb_Valor.text = Valor;
    NSLog(@"%@", Valor);
    
    lb_Endereco.text = Endereco;
    NSLog(@"%@", Endereco);
    
    lb_Operacao.text = Operacao;
    NSLog(@"%@", Operacao);
    
    lb_Municipio.text = Municipio;
    NSLog(@"%@", Municipio);
    
    lb_Descricao_Completa.text = Descricao_Completa;
    NSLog(@"%@", Descricao_Completa);
    
   //  add Id_Galeria na url galeria.
    NSString * Urlfotos = [NSString stringWithFormat:@"http://www.promastersolution.com.br/x7890_IOS/imoveis/rejane/imagens_anuncio_ios.php?id=%@",Id_Galeria];
    
    [self LoadingFotos:[NSURL URLWithString:Urlfotos]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_ligar:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:3535317988"]];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

-(void) LoadingFotos:(NSURL *) urlLista {
    
        NSURLSession * session = [NSURLSession sharedSession];
        
        NSURLSessionDownloadTask * task =
        [session downloadTaskWithURL:urlLista completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
            fotos = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (fotos == nil || [fotos count] == 0) {
                    pageControl.hidden = YES;
                    
                    CGRect frame;
                    
                    frame.origin.x = scrollView.frame.size.width * 0;
                    frame.origin.y = 0;
                    frame.size = scrollView.frame.size;
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
                    
                    dispatch_async(dispatch_get_global_queue(0,0), ^{
                        NSData * data = [[NSData alloc] initWithContentsOfURL:UrlImagem];
                        if ( data == nil )
                            return;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // WARNING: is the cell still using the same data by this point??
                            imageView.image = [UIImage imageWithData: data];
                        });
                        
                    });
                    
                    [scrollView addSubview:imageView];
                    
                    scrollView.pagingEnabled = YES;
                    scrollView.delegate = self;
                    scrollView.userInteractionEnabled = YES;
                    scrollView.showsHorizontalScrollIndicator = NO;
                    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
                    
                    pageControl.hidden = YES;
                    pageControl.currentPage = 0;
                    
                    //Set the content size of our scrollview according to the total width of our imageView objects.
                    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 0, scrollView.frame.size.height);
                    
                    
                } else {
                    
                    
                    for (int i = 0; i < [fotos count]; i++) {
                        //We'll create an imageView object in every 'page' of our scrollView.
                        CGRect frame;
                        
                        frame.origin.x = scrollView.frame.size.width * i;
                        frame.origin.y = 0;
                        frame.size = scrollView.frame.size;
                        
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            NSURL * urlImage = [NSURL URLWithString:[[fotos objectAtIndex:i] objectForKey:@"imagem"]];
                            
                            NSURLSession * session = [NSURLSession sharedSession];
                            
                            NSURLSessionDownloadTask * task = [session downloadTaskWithURL:urlImage
                                                                         completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                             
                                                                             NSData * imageData = [[NSData alloc] initWithContentsOfURL:location];
                                                                             UIImage *img = [UIImage imageWithData:imageData];
                                                                             
                                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                                 imageView.image = img;
                                                                                 
                                                                                 
                                                                             });
                                                                         }];
                            [task resume];
                            
                        });
                        
                        [scrollView addSubview:imageView];
                    }
                    
                    // a page is the width of the scroll view
                    scrollView.pagingEnabled = YES;
                    scrollView.delegate = self;
                    scrollView.userInteractionEnabled = YES;
                    scrollView.showsHorizontalScrollIndicator = NO;
                    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
                    
                    pageControl.hidden = NO;
                    pageControl.numberOfPages = fotos.count;
                    pageControl.currentPage = 0;
                    
                    //Set the content size of our scrollview according to the total width of our imageView objects.
                    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [fotos count], scrollView.frame.size.height);
                    
                }
            });
            
        }];
        [task resume];
    
}




@end
