//
//  OrdersDropdownSelection.m
//  CooperChimney
//
//  Created by Karthik Baskaran on 29/09/16.
//  Copyright © 2016 Karthik Baskaran. All rights reserved.
//

#import "SSPopup_Vermelho.h"

@interface SSPopup_Vermelho ()
{
    AppDelegate *appDelegate;
    
    NSArray *ordersarray;
    
    UIButton *ParentBtn;
}
@end
@implementation SSPopup_Vermelho

- (id)initWithFrame:(CGRect)frame delegate:(id<SSPopupDelegate>)delegate
{
    self = [super init];
    if ((self = [super initWithFrame:frame]))
    {
        self.SSPopup_VermelhoDelegate = delegate;
    }
    
    return self;
}


-(void)CreateTableview:(NSArray *)Contentarray withSender:(id)sender withTitle:(NSString *)title setCompletionBlock:(VSActionBlock )aCompletionBlock{
    
    
    [self addTarget:self action:@selector(CloseAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.alpha=0;
    self.backgroundColor =[UIColor colorWithWhite:0.00 alpha:0.5];
    completionBlock = aCompletionBlock;
    ParentBtn = (UIButton *)sender;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Title = title;
    
    
    DropdownTable = [[UITableView alloc]initWithFrame:CGRectMake(
                                                                 self.frame.size.width/2  - (self.frame.size.width/1.2)/2,
                                                                 self.frame.size.height/2 - (self.frame.size.height/3)/2,
                                                                 self.frame.size.width/1.2,
                                                                 self.frame.size.height/3)];
    
//    DropdownTable = [[UITableView alloc]initWithFrame:CGRectMake
    
    
    
    DropdownTable.backgroundColor = [UIColor whiteColor];
    DropdownTable.dataSource = self;
    DropdownTable.showsVerticalScrollIndicator = YES;
    DropdownTable.delegate = self;
    DropdownTable.layer.cornerRadius = 5.0f;
    DropdownTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:DropdownTable];
    
    
    ordersarray=[[NSArray alloc]initWithArray:Contentarray];
    
    
    
    NormalAnimation(self.superview, 0.10f,UIViewAnimationOptionTransitionNone,
                    
                    self.alpha=1;
                    
                    )completion:nil];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    // Aqui não
    return tableView.frame.size.height/4;
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    
    // Do any additional setup after loading the view.  Codigo cor  1
    // Natigator - cor - rgb(26,188,156) Verde
    //verde    = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    // Natigator - cor - rgb(3,169,244) Azul     Codigo cor  2
    //azul     = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1];
    // Natigator - cor - rgb(255,82,82) Vermelho   Codigo cor  3
    //vermelho = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    // Natigator - cor - rgb(255,199,0) Amarelo   Codigo cor  4
    //amarelo  = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:0/255.0 alpha:1];
    
    [myview setBackgroundColor:[UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1]];
    
    
    UILabel *headLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, myview.frame.size.width, tableView.frame.size.height/4)];
    headLbl.backgroundColor = [UIColor clearColor];
    headLbl.textColor =  RGB(255, 255, 255);
    headLbl.text = Title?Title:@"selecione";
    headLbl.textAlignment = NSTextAlignmentCenter;
    headLbl.font = AvenirMedium(18);
    
    [myview addSubview:headLbl];
    
    
    return myview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Aqui não
    return tableView.frame.size.height/4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ordersarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    for (UILabel *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UILabel class]])
        {
            [lbl removeFromSuperview];
        }
    }
    
    
    //    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UILabel *Contentlbl =[[UILabel alloc]initWithFrame:CGRectMake(10,0,tableView.frame.size.width-20,tableView.frame.size.height/4)];
    
    Contentlbl.backgroundColor = [UIColor clearColor];
    Contentlbl.text = [ordersarray objectAtIndex:indexPath.row];
    Contentlbl.textColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    Contentlbl.textAlignment = NSTextAlignmentLeft;
    Contentlbl.font = AvenirMedium(16);
    
    [cell.contentView addSubview:Contentlbl];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Contentlbl.frame.origin.y+Contentlbl.frame.size.height-2,self.frame.size.width, 1.2)];
    
    lineView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [Contentlbl addSubview:lineView];
    
    if(indexPath.row == [ordersarray count] -1){
        
        lineView.hidden=YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor=RGB(204, 204, 204);
    
    
//    [ParentBtn setTitle:[ordersarray objectAtIndex:indexPath.row] forState:UIControlStateNormal]; //Setting title for Button
//    
    
    if (completionBlock) {
        
        completionBlock((int)indexPath.row);
    }
    
    if ([self.SSPopup_VermelhoDelegate respondsToSelector:@selector(GetSelectedOutlet:)]) {
        
        [self.SSPopup_VermelhoDelegate GetSelectedOutlet:(int)indexPath.row];
    }
    
    
    [self CloseAnimation];
    
    
}

-(void)CloseAnimation{
    
    NormalAnimation(self.superview, 0.10f,UIViewAnimationOptionTransitionNone,
                    
                    DropdownTable.alpha=0;
                    
                    
                    
                    )
completion:^(BOOL finished){
    
    [DropdownTable removeFromSuperview];
    [self removeFromSuperview];
    
    
}];
}

@end
