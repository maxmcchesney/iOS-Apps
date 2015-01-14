//
//  ViewController.m
//  TicTacToe
//
//  Created by Jo Albright on 1/12/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// Center Squares on View
// Score label on top that keeps track of wins for each player
// Make buttons change colors instead of title (reset colors when play again)
// Button at bottom that resets game scores

@interface ViewController () <UIAlertViewDelegate>

@property (nonatomic) int player1Score;
@property (nonatomic) int player2Score;

@end

@implementation ViewController
{
    int playerTurn;
    
    NSMutableArray * squares;
    NSMutableArray * buttons;
    
    UILabel * player1ScoreLabel;
    UILabel * player2ScoreLabel;
    
    NSArray * playerColors;
    
}

- (void)setPlayer1Score:(int)player1Score {
    
    player1ScoreLabel.text = [NSString stringWithFormat:@"Player1 : %d",player1Score];
    _player1Score = player1Score;
    
}

- (void)setPlayer2Score:(int)player2Score {
    
    player2ScoreLabel.text = [NSString stringWithFormat:@"Player2 : %d",player2Score];
    _player2Score = player2Score;
    
}
    

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    playerColors = @[
                     [UIColor lightGrayColor],
                     [UIColor magentaColor],
                     [UIColor cyanColor]
                     ];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    buttons = [@[] mutableCopy];
    
    playerTurn = 1;
    
    squares = [@[
                 @0,@0,@0,
                 @0,@0,@0,
                 @0,@0,@0
                 ] mutableCopy];
    
    
    int rowCount = 3;
    int colCount = 3;
    
    CGFloat width = 120;
    CGFloat height = 120;
    
    CGFloat padding = -20;
    
    CGFloat fullWidth = (colCount * width) + (colCount - 1) * padding;
    CGFloat fullHeight = (rowCount * height) + (rowCount - 1) * padding;
    
    int buttonCount = 0;
    
    for (int r = 0; r < rowCount; r++)
    {
        
        // loop per row
        
        for (int c = 0; c < colCount; c++)
        {
            
            // loop per column
            
            CGFloat x = c * (width + padding) + (SCREEN_WIDTH - fullWidth) / 2;
            CGFloat y = r * (height + padding) + (SCREEN_HEIGHT - fullHeight) / 2;
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            button.backgroundColor = playerColors[0];
//            [button setTitle:[NSString stringWithFormat:@"%d",buttonCount] forState:UIControlStateNormal];
            button.tag = buttonCount;
            
            [button addTarget:self action:@selector(squareTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            button.layer.cornerRadius = height / 2;
            button.alpha = 0.6;
            
            [self.view addSubview:button];
            [buttons addObject:button];
            
            buttonCount++;
            
        }
        
    }
    
    player1ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
    
//    player1ScoreLabel.text = @"Player1 : 0";
    
    [self.view addSubview:player1ScoreLabel];
    
    player2ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
    
//    player2ScoreLabel.text = @"Player2 : 0";
    player2ScoreLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:player2ScoreLabel];
    
    self.player1Score = 0;
    self.player2Score = 0;
    
//    NSLog(@"subviews %@",self.view.subviews);
    
}

- (void)squareTapped:(UIButton *)button {
    
    if ([squares[button.tag] intValue] != 0) { return; }
    
    squares[button.tag] = @(playerTurn);
    
//    [button setTitle:[NSString stringWithFormat:@"%d",playerTurn] forState:UIControlStateNormal];
    
    button.backgroundColor = playerColors[playerTurn];
    
    playerTurn = (playerTurn == 2) ? 1 : 2;
    
    [self checkForWin];
    
}

- (void)checkForWin {
    
    NSArray * possibilities = @[
                                // rows
                                @[@0,@1,@2],
                                @[@3,@4,@5],
                                @[@6,@7,@8],
                                
                                // columns
                                @[@0,@3,@6],
                                @[@1,@4,@7],
                                @[@2,@5,@8],
                                
                                // diagnols
                                @[@0,@4,@8],
                                @[@2,@4,@6]
                                ];
    
    for (NSArray * possibility in possibilities) {

        [self checkPossibility:possibility withPlayer:1];
        [self checkPossibility:possibility withPlayer:2];
        
    }
    
}

- (void)checkPossibility:(NSArray *)possibility withPlayer:(int)player {
    
    BOOL playerInSquare1 = ([squares[[possibility[0] intValue]] intValue] == player);
    BOOL playerInSquare2 = ([squares[[possibility[1] intValue]] intValue] == player);
    BOOL playerInSquare3 = ([squares[[possibility[2] intValue]] intValue] == player);
    
    if (playerInSquare1 && playerInSquare2 && playerInSquare3) {
        
//        switch (player) {
//            case 1:
//                self.player1Score++;
//                break;
//                
//            case 2:
//                self.player2Score++;
//                break;
//        }
        
        if (player == 1) {
            self.player1Score++;
        } else {
            self.player2Score++;
        }
        
        
        // player won
        NSLog(@"Player %d Won",player);
        
        NSString * message = [NSString stringWithFormat:@"Player %d Won",player];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Winner" message:message delegate:self cancelButtonTitle:@"Play Again Now!" otherButtonTitles:nil];
        
        [alertView show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // square titles
    for (UIButton * button in buttons) {
        
//        [button setTitle:@"" forState:UIControlStateNormal];
        
        button.backgroundColor = playerColors[0];
        
    }
    
    playerTurn = 1;
    
    squares = [@[
                 @0,@0,@0,
                 @0,@0,@0,
                 @0,@0,@0
                 ] mutableCopy];
    
    NSLog(@"Play Again");
    
}

- (void)resetScore {
    
    self.player1Score = 0;
    self.player2Score = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
