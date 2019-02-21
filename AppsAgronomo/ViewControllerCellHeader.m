//
//  ViewControllerCellHeader.m
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import "ViewControllerCellHeader.h"

@implementation ViewControllerCellHeader

@synthesize btnShowHide, lbTitle;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.imgHeader.layer.cornerRadius = self.imgHeader.frame.size.height/2;
    self.imgHeader.clipsToBounds = YES;
    self.imgHeader.layer.borderWidth = 1.0;
    self.imgHeader.layer.masksToBounds = YES;
    self.imgHeader.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    
}

@end
