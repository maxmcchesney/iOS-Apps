//
//  ViewController.m
//  ScribbleTouch
//
//  Created by Michael McChesney on 1/14/15.
//  Copyright (c) 2015 Michael McChesney. All rights reserved.
//

#import "ViewController.h"
#import "ScribbleView.h"
#import "ChoiceViewController.h"
#import "roundedButton.h"
#import "CustomSlider.h"
#import "EraserButton.h"

@interface ViewController () <ChoiceViewControllerDelegate, CustomSliderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *blendModeButton;
@property (weak, nonatomic) IBOutlet UIButton *shapeTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *drawerLeftConstraint;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIView *edgeView;

@property (weak, nonatomic) IBOutlet CustomSlider *alphaSliderValue;

@property (weak, nonatomic) IBOutlet CustomSlider *strokeSliderValue;

@end

@implementation ViewController
{
    NSMutableDictionary * currentScribble;
    UIColor * selectedStrokeColor;
    int selectedStrokeWidth;
    
    UIColor * selectedFillColor;
    
    float shapeAlpha;
    
    NSString * selectedBlendMode;
    NSString * selectedShapeType;
    
    ScribbleView * sView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.alphaSliderValue.sliderType = @"alpha";
    self.alphaSliderValue.delegate = self;
    self.strokeSliderValue.delegate = self;
    self.strokeSliderValue.sliderType = @"stroke";
    
    
    selectedStrokeColor = [UIColor blackColor];
    selectedStrokeWidth = 1;
    selectedFillColor = [UIColor clearColor];
    selectedBlendMode = @"Normal";
    selectedShapeType = @"Scribble";
    shapeAlpha = 1;
    
//    TO ADD GRADIENT TO EDGEVIEW FOR SLIDER
    CAGradientLayer * gradient = [CAGradientLayer layer];
    gradient.frame = self.edgeView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithRed:0.950f green:0.950f blue:0.950f alpha:1.0f] CGColor], nil];
    gradient.startPoint = CGPointMake(0.0, 0.5);    // This part right?
    gradient.endPoint = CGPointMake(10.0, 0.0);

    [self.edgeView.layer insertSublayer:gradient atIndex:1];
    
//    THIS MAKES THE UNDO AND CLEAR BUTTONS ROTATE
//    self.undoButton.transform = CGAffineTransformRotate(self.undoButton.transform, -240);
//    self.clearButton.transform = CGAffineTransformRotate(self.clearButton.transform, -240);
    
}

- (void)sliderValue:(float)value forSlider:(NSString *)sliderType {
    
    if ([sliderType isEqualToString:@"alpha"]) {
        shapeAlpha = value;
    }
    
    if ([sliderType isEqualToString:@"stroke"]) {
        selectedStrokeWidth = value * 40;
    }
    
}

- (IBAction)changeFillColor:(UIButton *)sender {

    selectedFillColor = sender.backgroundColor;
    NSLog(@"%@",selectedFillColor);
}

- (IBAction)changeStrokeColor:(UIButton *)sender {
    
    selectedStrokeColor = sender.backgroundColor;
    NSLog(@"%@",selectedStrokeColor);
}

- (IBAction)eraserStroke:(UIButton *)sender {
    selectedStrokeColor = self.view.backgroundColor;
    NSLog(@"%@",selectedStrokeColor);
}


- (IBAction)eraserFill:(UIButton *)sender {
    selectedFillColor = self.view.backgroundColor;
    NSLog(@"%@",selectedFillColor);
}

- (IBAction)noStrokeColor:(UIButton *)sender {
    selectedStrokeColor = self.view.backgroundColor;
//    selectedStrokeColor = [UIColor clearColor];
}

- (IBAction)noFillColor:(UIButton *)sender {
    selectedFillColor = self.view.backgroundColor;
}


- (IBAction)changeStrokeWidth:(UISlider *)sender {
    
    selectedStrokeWidth = sender.value;
}

- (IBAction)flipView:(id)sender {
    self.view.transform = CGAffineTransformRotate(self.view.transform, M_PI);
}

- (void)choice:(NSString *)choice forGroup:(NSString *)group {
    
    if ([group isEqualToString:@"BlendMode"]) {
        selectedBlendMode = choice;
        [self.blendModeButton setTitle:choice forState:UIControlStateNormal];
    }

    if ([group isEqualToString:@"ShapeType"]) {
        selectedShapeType = choice;
        [self.shapeTypeButton setTitle:choice forState:UIControlStateNormal];
    }
    
    NSLog(@"Choice = %@ for Group: %@", choice, group);
    
}

- (IBAction)changeBlendMode:(id)sender {
    
    ChoiceViewController * choiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"choiceVC"];
    
    choiceVC.group = @"BlendMode";
    choiceVC.delegate = self;
    choiceVC.choices = @[
                         @"Normal",
                         @"Multiply",
                         @"Overlay",
                         @"Screen",
                         @"Clear"
                         ];
    
    [self presentViewController:choiceVC animated:NO completion:nil];
    
}

- (IBAction)changeShapeType:(id)sender {
    
    ChoiceViewController * choiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"choiceVC"];
    
    choiceVC.delegate = self;
    choiceVC.group = @"ShapeType";
    choiceVC.choices = @[
                                   @"Scribble",
                                   @"Line",
                                   @"Rectangle",
                                   @"Triangle",
                                   @"Ellipse"
                                   ];
    [self presentViewController:choiceVC animated:NO completion:nil];
}

- (IBAction)showHideDrawer:(id)sender {

    int direction = (self.drawerLeftConstraint.constant == -16) ? -1 : 1;
    
    self.toggleButton.transform = CGAffineTransformMakeScale(direction, 1);
    self.drawerLeftConstraint.constant = (self.drawerLeftConstraint.constant == -16) ? -266 : -16;
}

- (IBAction)undoLast:(UIButton *)sender {   // UNDO LAST DRAWING
    NSLog(@"Undo Last");
    [currentScribble removeAllObjects];
    [self.view setNeedsDisplay];
}

- (IBAction)clearScribbles:(UIButton *)sender { // CLEAR ALL DRAWINGS
    NSLog(@"Clear screen");
    [sView.scribbles removeAllObjects];
    [self.view setNeedsDisplay];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    
    currentScribble = [@{
                         
                         @"type":selectedShapeType,
                         @"blend":selectedBlendMode,
                         @"fillColor":selectedFillColor,
                         @"strokeColor":selectedStrokeColor,
                         @"strokeWidth":@(selectedStrokeWidth),
                         @"shapeAlpha":@(shapeAlpha),
                         @"points":[@[[NSValue valueWithCGPoint:location]] mutableCopy]
                         
                         } mutableCopy];
    
    sView = (ScribbleView *)self.view;
    [sView.scribbles addObject:currentScribble];
        
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    if ([selectedShapeType isEqualToString:@"Scribble"]) {
        [currentScribble[@"points"] addObject:[NSValue valueWithCGPoint:location]];
    } else {
        currentScribble[@"points"][1] = [NSValue valueWithCGPoint:location];
    }
    
    [self.view setNeedsDisplay];
}

@end
