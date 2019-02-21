//
//  ViewControllerCell.h
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UIImageView *imgCell;

@property (weak, nonatomic) IBOutlet UIImageView *imgLocation;

@property (weak, nonatomic) IBOutlet UIButton *btnComoChegar;

@end
