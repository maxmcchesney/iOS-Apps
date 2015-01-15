//
//  ViewController.m
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/14/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"
#import "ScribbleView.h"
#import "roundedButton.h"

@interface ViewController ()

@end

@implementation ViewController
{
    
    NSMutableDictionary *currentScribble;
    UIColor *selectedColor;
    int selectedStrokeWidth;
    UIColor *selectedFillColor;
    
    BOOL switchIsOn;
    
    BOOL colorThemeChanged;
    
    ScribbleView *sView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // SET DEFAULT VALUES
    selectedColor = [UIColor blackColor];
    selectedStrokeWidth = 1;
    selectedFillColor = [UIColor clearColor];
    
//    UIAlertView * welcome = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Welcome to Maxrosoft Paint. Enjoy!" delegate:self cancelButtonTitle:@"Get Started" otherButtonTitles:nil];
//    [welcome show];
    
}

- (IBAction)changeColor:(UIButton *)sender {    // CHANGE COLOR METHOD
    selectedColor = sender.backgroundColor;
}

- (IBAction)changeStrokeWidth:(UISlider *)sender {  // CHANGE STROKE WIDTH
    selectedStrokeWidth = sender.value;
}

- (IBAction)turnOnFill:(UISwitch *)sender { // FILL SWITCH TURNS ON FILL
    switchIsOn = sender.isOn;
}

- (IBAction)undoLast:(UIButton *)sender {   // UNDO LAST DRAWING
    NSLog(@"Undo Last");
    [currentScribble removeAllObjects];
    [self.view setNeedsDisplay];
}

- (IBAction)clearScreen:(UIButton *)sender {    // CLEAR ALL DRAWINGS
    NSLog(@"Clear screen");
    [sView.scribbles removeAllObjects];
    [self.view setNeedsDisplay];
}

- (IBAction)erase:(UIButton *)sender {  // ERASER BUTTON
    
    NSLog(@"Eraser selected");
    
    selectedColor = self.view.backgroundColor;
}

- (IBAction)changeTheme:(UIButton *)sender {    // Change Color Scheme
    
    NSLog(@"change color scheme %u", colorThemeChanged);

    // CHANGES THE COLOR SCHEME WHEN PRESSED
    if (colorThemeChanged) {
        self.button1.backgroundColor = [UIColor blackColor];
        self.button2.backgroundColor = [UIColor grayColor];
        self.button3.backgroundColor = [UIColor orangeColor];
        self.button4.backgroundColor = [UIColor magentaColor];
        self.button5.backgroundColor = [UIColor purpleColor];
        self.button6.backgroundColor = [UIColor cyanColor];
        colorThemeChanged = false;
    } else {
        self.button1.backgroundColor = [UIColor redColor];
        self.button2.backgroundColor = [UIColor blueColor];
        self.button3.backgroundColor = [UIColor brownColor];
        self.button4.backgroundColor = [UIColor lightGrayColor];
        self.button5.backgroundColor = [UIColor greenColor];
        self.button6.backgroundColor = [UIColor yellowColor];
        colorThemeChanged = true;
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = touches.allObjects.firstObject;  // This will get the first touch w/in this NSSet.
    CGPoint location = [touch locationInView:self.view];
//    NSLog(@"x %f y %f", location.x, location.y);    // We use %f here because x and y coords are Floats.
    

    
    // ENSURES FILL CHANGES COLOR WITH COLOR CHANGE METHOD
    if (switchIsOn) {
        selectedFillColor = selectedColor;
    } else {
        selectedFillColor = [UIColor clearColor];
    }
    
    // CURRENT DRAWINGS HELD HERE
    currentScribble = [@{
                         @"type":@"path",
                         @"fillColor":selectedFillColor,
                         @"strokeColor":selectedColor,
                         @"strokeWidth":@(selectedStrokeWidth),
                         @"points":[@[[NSValue valueWithCGPoint:location]] mutableCopy]
                         } mutableCopy];
    
    sView = (ScribbleView *)self.view;    // Here we're 'casting' self.view as a Scribbleview*.
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
