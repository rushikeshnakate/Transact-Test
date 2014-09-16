//
//  PropertyViewCell.m
//  Transact
//
//  Created by trsoft_dev1 on 16/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "PropertyViewCell.h"

@implementation PropertyViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
