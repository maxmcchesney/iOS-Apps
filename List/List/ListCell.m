//
//  ListCell.m
//  List
//
//  Created by Michael McChesney on 1/7/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ListCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//  ^ Constant (not global) variable, never changes. Standard is to name it all capps.


@implementation ListCell

{
    UIView * colorView;
    
    BOOL isDone;
    
    UIView * strikeThrough;
    
}

//-(BOOL)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    return 1;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = [UIColor blackColor];
    
    self.textLabel.textColor = [UIColor whiteColor];
    

    
    if (self) {

        colorView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 26.5, 20, 20)];
//        x and y for CGRectMake is refering to the upper left corner of the view (box).
//        colorView.backgroundColor = [UIColor blueColor];      Was just for testing. This is overridden below in the setter override.
        colorView.layer.cornerRadius = 10;
        [self.contentView addSubview:colorView];
        
//        strikeThrough = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-32.5, 20, 25, 2)];
        strikeThrough = [[UIView alloc] initWithFrame:CGRectMake(7, 36.5, SCREEN_WIDTH - 10, 1)];
        strikeThrough.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:strikeThrough];
        
    }
    
    return self;
    
}

- (void)setItemInfo:(NSDictionary *)itemInfo {
    
    colorView.backgroundColor = itemInfo[@"color"];
    self.textLabel.text = itemInfo[@"text"];
    isDone = [itemInfo[@"done"] boolValue];

    strikeThrough.hidden = !isDone;
    
//    ^ this is the same thing as the below if statement
//    if (isDone == NO) {
//        strikeThrough.hidden = YES;
//    }
    
    
    _itemInfo = itemInfo;
}


@end
