//
//  ViewController.m
//  Capture
//
//  Created by Jo Albright on 1/20/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ViewController.h"
#import "FilterViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CustomButton.h"
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic) UIImagePickerController * cameraPickerController;
@property (nonatomic) UIImagePickerController * libraryPickerController;

@property (weak, nonatomic) IBOutlet UIButton * openPhotoLibraryButton;
@property (weak, nonatomic) IBOutlet UIButton * takeMediaButton;
@property (weak, nonatomic) IBOutlet UIView * cameraView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mediaChoiceButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *deviceChoiceButton;

@property (weak, nonatomic) IBOutlet CustomButton *recordButton;

@property (weak, nonatomic) IBOutlet CustomButton *stopRecordButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.recordButton.hidden = YES;
    self.stopRecordButton.hidden = YES;
    
    [self.openPhotoLibraryButton addTarget:self action:@selector(openPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];

    self.cameraPickerController = [[UIImagePickerController alloc] init];
    self.cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    self.cameraPickerController.showsCameraControls = NO;
    self.cameraPickerController.delegate = self;
    self.cameraPickerController.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
    
    self.cameraPickerController.view.frame = self.cameraView.bounds;
    
    [self.cameraView addSubview:self.cameraPickerController.view];
    
    [self.takeMediaButton addTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
    
    [self.deviceChoiceButton addTarget:self action:@selector(changeDeviceType) forControlEvents:UIControlEventValueChanged];
    
    [self.recordButton addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
    
    [self.stopRecordButton addTarget:self action:@selector(stopRecording) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)startRecording {
    [self.cameraPickerController startVideoCapture];
    self.recordButton.hidden = YES;
    self.stopRecordButton.hidden = NO;
}

-(void)stopRecording {
    [self.cameraPickerController stopVideoCapture];
    self.stopRecordButton.hidden = YES;
    self.recordButton.hidden = NO;
}

- (void)changeMediaType {
    
//    self.cameraPickerController.cameraCaptureMode = (self.mediaChoiceButton.selectedSegmentIndex == 0) ? UIImagePickerControllerCameraCaptureModePhoto : UIImagePickerControllerCameraCaptureModeVideo;
    
    // TO ADD ANIMATION TO SWITCHING MEDIA TYPE
    CATransition *animation = [CATransition animation];
    animation.duration = .5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    
    if (self.mediaChoiceButton.selectedSegmentIndex == 0) {
        self.cameraPickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        animation.subtype = kCATransitionFromBottom;
    } else {
        self.cameraPickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        animation.subtype = kCATransitionFromTop;
    }
    [self.cameraView.layer addAnimation:animation forKey:nil];   // END ANIMATION AND SWITCH
    
    
    switch (self.mediaChoiceButton.selectedSegmentIndex) {
        
        case 0: // Photo
            [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];      // WHY IS THIS NEEDED?
            
            self.takeMediaButton.hidden = NO;
            self.recordButton.hidden = YES;
            
            
            break;
            
        case 1: // Video
//            [self.takeMediaButton removeTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
            
            self.takeMediaButton.hidden = YES;
            self.recordButton.hidden = NO;
            
            break;
            
        default:
            break;
    }
    
}

- (void)changeDeviceType {
    
//    self.cameraPickerController.cameraDevice = (self.deviceChoiceButton.selectedSegmentIndex == 0) ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;
    
    // TO SWITCH BETWEEN FRONT AND REAR CAMERAS WITH FLIP ANIMATION.
    CATransition *animation = [CATransition animation];
    animation.duration = .5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    if (self.deviceChoiceButton.selectedSegmentIndex == 0) {
        self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        animation.subtype = kCATransitionFromLeft;
    } else {
        self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        animation.subtype = kCATransitionFromRight;
    }
    [self.cameraView.layer addAnimation:animation forKey:nil];
    
}

- (void)openPhotoLibrary {
    
    self.libraryPickerController = [[UIImagePickerController alloc] init];
    self.libraryPickerController.delegate = self;
    
    [self presentViewController:self.libraryPickerController animated:YES completion:nil];
    
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    NSLog(@"%@",info);
//    
//    UIImage * image = info[UIImagePickerControllerOriginalImage];
//    
//    [self gotoFilterWithImage:image];
//    
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//        
//    }];
//    
//}
//
//- (void)gotoFilterWithImage:(UIImage *)image {
//    
//    // push filter view controller
//    
//    FilterViewController * filterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"filterVC"];
//    
//    filterVC.originalImage = image;
//
//    [self.navigationController pushViewController:filterVC animated:YES];
//    
//}

////////////////////  ALL BELOW IS MY CODE FOR VIDEO. JUST UNCOMMENT THE ABOVE FOR JO'S CHANGES IF NEEDED.


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
    
    MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self.navigationController pushViewController:movieVC animated:YES];
    
}

- (void)gotoFilterWithImage:(UIImage *)image {
    
    // PUSH FILTER VIEW CONTROLLER
    
    FilterViewController *filterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"filterVC"];
    
    filterVC.originalImage = image;
    
    [self.navigationController pushViewController:filterVC animated:YES];
    
}





///////////////////


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
