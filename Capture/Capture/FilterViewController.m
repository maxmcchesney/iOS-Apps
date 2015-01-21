//
//  FilterViewController.m
//  Capture
//
//  Created by Michael McChesney on 1/20/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "FilterViewController.h"
// DONE - Add segment control for choosing front or rear camera.
    // DONE - Add target method that changes the camera device

// DONE - Add methods to allow for video capture and stopping (when this stops should run a delegate method "FinishPickingMedia". Can use the same take picture button.)

// Add a UICollectionView to filterVC (storyboard) at the bottom
    // Take Inpiration from Instagrams filter scroller (1 row of square filters)

// DONE - Extra: find out how to flip camera view when changing between front and rear. This is referring to the animated "flip" that you can add for the switch action.


@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;

@end

@implementation FilterViewController

- (void)setOriginalImage:(UIImage *)originalImage {
    
    _originalImage = originalImage;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.filterImageView.image = self.originalImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
