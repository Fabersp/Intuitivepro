//
//  ViewControllerCellHeader.h
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerCellHeader : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbTitle;

@property (strong, nonatomic) IBOutlet UIButton *btnShowHide;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;

@property (weak, nonatomic) IBOutlet UIButton *btnTouchHeader;

@end
