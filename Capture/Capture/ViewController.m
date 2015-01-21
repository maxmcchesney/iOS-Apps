//
//  ViewController.m
//  Capture
//
//  Created by Michael McChesney on 1/20/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"
#import "FilterViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CustomButton.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) UIImagePickerController *cameraPickerController;
@property (nonatomic) UIImagePickerController *libraryPickerController;
@property (weak, nonatomic) IBOutlet UIButton *openPhotoLibraryButton;
@property (weak, nonatomic) IBOutlet UIButton *takeMediaButton;
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mediaChoiceButton;

@property (weak, nonatomic) IBOutlet UIButton *switchCameraButton;
@property (weak, nonatomic) IBOutlet UIButton *stopRecordingButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.openPhotoLibraryButton addTarget:self action:@selector(openPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    // TO SET UP CAMERA
    self.cameraPickerController = [[UIImagePickerController alloc] init];
    self.cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

    self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;

    self.cameraPickerController.showsCameraControls = NO;
    self.cameraPickerController.delegate = self;
    self.cameraPickerController.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    
    self.cameraPickerController.view.frame = self.cameraView.bounds;
    
    [self.cameraView addSubview:self.cameraPickerController.view];
    
    [self.takeMediaButton addTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
    
    [self.switchCameraButton addTarget:self action:@selector(switchCamera) forControlEvents:UIControlEventTouchUpInside];
    
    [self.stopRecordingButton addTarget:self.cameraPickerController action:@selector(stopVideoCapture) forControlEvents:UIControlEventTouchUpInside];
    
    self.stopRecordingButton.hidden = YES;
    
}

- (void)switchCamera {
    // TO SWITCH BETWEEN FRONT AND REAR CAMERAS WITH FLIP ANIMATION.
    CATransition *animation = [CATransition animation];
    animation.duration = .5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    if (self.cameraPickerController.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        animation.subtype = kCATransitionFromLeft;
    } else {
        self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        animation.subtype = kCATransitionFromRight;
    }
    [self.cameraView.layer addAnimation:animation forKey:nil];
}

- (void)changeMediaType {
    
//    self.cameraPickerController.cameraCaptureMode = (self.mediaChoiceButton.selectedSegmentIndex == 0) ? UIImagePickerControllerCameraCaptureModePhoto : UIImagePickerControllerCameraCaptureModeVideo;
    
    
    switch (self.mediaChoiceButton.selectedSegmentIndex) {
        case 0:  // Photo
            
            NSLog(@"PHOTO MODE");

            self.stopRecordingButton.hidden = YES;
            
            self.cameraPickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            
//            [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
            
            [self.takeMediaButton removeTarget:self.cameraPickerController action:@selector(startVideoCapture) forControlEvents:UIControlEventTouchUpInside];
            
            [self.takeMediaButton addTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
            
            [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
            
//            [self.takeMediaButton addTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
            
            
            break;
        case 1:  // Video
            
            NSLog(@"VIDEO MODE");
            
            self.stopRecordingButton.hidden = NO;
            
            [self.takeMediaButton removeTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
            
            self.cameraPickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
            
            [self.takeMediaButton addTarget:self.cameraPickerController action:@selector(startVideoCapture) forControlEvents:UIControlEventTouchUpInside];

            break;
        default:
            break;
    }
    
}



// JO LEFT US WITH THIS...
//- (void)changeMediaType {
//    
//    self.cameraPickerController.cameraCaptureMode = (self.mediaChoiceButton.selectedSegmentIndex == 0) ? UIImagePickerControllerCameraCaptureModePhoto : UIImagePickerControllerCameraCaptureModeVideo;
//    
//    switch (self.mediaChoiceButton.selectedSegmentIndex) {
//        case 0:  // Photo
//            
//            NSLog(@"PHOTO MODE");
//            [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
//            
//            break;
//        case 1:  // Video
//            
//            NSLog(@"VIDEO MODE");
//            
//            [self.takeMediaButton removeTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
//
//            break;
//        default:
//            break;
//    }
//}

- (void)openPhotoLibrary {
    
    self.libraryPickerController = [[UIImagePickerController alloc] init];
    self.libraryPickerController.delegate = self;
    
    [self presentViewController:self.libraryPickerController animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureModeVideo) {
    
        NSLog(@"video info: %@",info);
        
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        
        [self gotoFilterWithMovie:videoURL];
        
    } else {
        
        NSLog(@"photo info: %@",info);
        
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        [self gotoFilterWithImage:image];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)gotoFilterWithMovie:(NSURL *)url {
    
    MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc] init];
    
    movieVC.moviePlayer.contentURL = url;
    
    [self.navigationController pushViewController:movieVC animated:YES];
    
}

- (void)gotoFilterWithImage:(UIImage *)image {
    
    // PUSH FILTER VIEW CONTROLLER
    
    FilterViewController *filterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"filterVC"];
    
    filterVC.originalImage = image;

    [self.navigationController pushViewController:filterVC animated:YES];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
