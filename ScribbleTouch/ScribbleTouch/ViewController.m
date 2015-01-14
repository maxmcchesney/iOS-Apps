//
//  ViewController.m
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/14/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"
#import "ScribbleView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableDictionary *currentScribble;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = touches.allObjects.firstObject;  // This will get the first touch w/in this NSSet.
    CGPoint location = [touch locationInView:self.view];
//    NSLog(@"x %f y %f", location.x, location.y);    // We use %f here because x and y coords are Floats.
 
    currentScribble = [@{
                         
                         @"type":@"path",
                         @"fillColor":[UIColor clearColor],
                         @"strokeColor":[UIColor blackColor],
                         @"strokeWidth":@4,
                         @"points":[@[[NSValue valueWithCGPoint:location]] mutableCopy]
                         
                         } mutableCopy];
    
    ScribbleView *sView = (ScribbleView *)self.view;    // Here we're 'casting' self.view as a Scribbleview*.
    [sView.scribbles addObject:currentScribble];   // Calls .scribbles getter method and adds currentScribble Object to it.
//    [((ScribbleView*)self.view).scribbles addObject:currentScribble];   //This does the above couple of lines in one.
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.allObjects.firstObject;  // This will get the first touch w/in this NSSet.
    CGPoint location = [touch locationInView:self.view];
    
    [currentScribble[@"points"] addObject:[NSValue valueWithCGPoint:location]];
    
    [self.view setNeedsDisplay];
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
