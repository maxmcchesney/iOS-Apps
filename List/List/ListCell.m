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

//  William's code for touch recognition to toggle strikeThrough and colorView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([[touch.view class] isSubclassOfClass:[UIView class]]) {
        
        if (CGRectContainsPoint(colorView.frame, touchLocation)) {
            
            if (colorView.backgroundColor  == [UIColor clearColor]) {
                colorView.backgroundColor = _itemInfo[@"color"];
            }
            
            else {
                colorView.backgroundColor = [UIColor clearColor];
                
                // Try to add white border here
                
                colorView.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
                colorView.layer.borderWidth = 1;
            }
        }
        
        else {
            
            if (isDone == false) {
                strikeThrough.hidden = true;
                isDone = true;
            }
            
            else {
                strikeThrough.hidden = false;
                isDone = false;
            }
            
            
        }
    }
    
    
}




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
