//
//  ViewController.m
//  TicTacToe
//
//  Created by Michael McChesney on 1/12/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"

//  DONE - Center squares on view
//  DONE - Score Label on top that keeps track of wins for each player
//  Make buttons change colors instead of title (reset colors to play again)
//      ^ Might need 2 global instance variables that keeps track of player scores
//  Button at bottom that resets game scores


@interface ViewController () <UIAlertViewDelegate>

@end

@implementation ViewController

{
    
    int playerTurn;
    int turnCount;
    
    NSMutableArray * squares;
    
    UIButton * popUpWinner;
    
    NSMutableArray * buttons;
    
    int player1Score;
    int player2Score;
    
    UILabel * player1;
    UILabel * player2;
    
//    int winCount;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.647f green:0.722f blue:0.757f alpha:1.0f];
    
//  GET SCREEN HEIGHT AND WIDTH FOR DYNAMIC SIZING
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    NSLog(@"width: %f height: %f", (screenWidth-50)/2, screenHeight);
    
//  SCOREBOARD AT THE TOP
    player1 = [[UILabel alloc] initWithFrame:CGRectMake(((screenWidth-310)/2), 35, 310/2, 30)];    //With padding, total width is 325
    player2 = [[UILabel alloc] initWithFrame:CGRectMake(((screenWidth-310)/2) + (310/2), 35, 310/2, 30)];
    
    player1.text = [NSString stringWithFormat:@"Player One: %d", player1Score];
    player2.text = [NSString stringWithFormat:@"Player Two: %d", player2Score];
    
    player1.textColor = [UIColor colorWithRed:0.071f green:0.580f blue:0.071f alpha:1.0f];
    player2.textColor = [UIColor redColor];
    
    player1.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
    player2.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
    
//    ATTEMPT TO CHANGE FONT FOR SCORE
//    player1.font = [UIFontDescriptor fontDescriptorWithName:@"Helvetica Neue Thin" size:20];

//    TEXT ALIGNED CENTER FOR SCORE
    player1.textAlignment = NSTextAlignmentCenter;
    player2.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:player1];
    [self.view addSubview:player2];
    
//  PLACE RESET BUTTON AT THE BOTTOM
    float buttonWidth = 150;
    float buttonHeight = 50;
    UIButton * resetButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth-buttonWidth)/2, (screenHeight-310)/2+310, buttonWidth, buttonHeight)];
    resetButton.backgroundColor = [UIColor orangeColor];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    
    resetButton.layer.cornerRadius = 15;
    
    [self.view addSubview:resetButton];
    [resetButton addTarget:self action:@selector(resetScore) forControlEvents:UIControlEventTouchUpInside];
    
    
//  MAKE BUTTONS MUTABLE ARRAY
    buttons = [@[] mutableCopy];
    
//  ORIGINAL PLAYER TURN and turnCount
    playerTurn = 1;
    turnCount = 0;
//    winCount = 0;
    
//  MAKE ARRAY FOR POSITIONS
    squares = [@[
                 @0, @0, @0,
                 @0, @0, @0,
                 @0, @0, @0
                 ] mutableCopy];
  
//  MAKE BUTTONS. SIZE AND POSITION THEM.
    int rowCount = 3;
    int colCount = 3;
    
    CGFloat width = 95;
    CGFloat height = 95;
    
    int buttonCount = 0;
    
    for (int r = 0; r < rowCount; r++) {
        // Loop per row

        for (int c = 0; c < colCount; c++) {
            //Loop per column
            
            CGFloat x = (c * (width + 10));
            CGFloat y = (r * (height + 10));
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x + ((screenWidth-305)/2), y + 100, width, height)];
            button.backgroundColor = [UIColor blueColor];
            button.layer.cornerRadius = 47.5;
//            [button setTitle:[NSString stringWithFormat:@"%d", buttonCount] forState:normal];
            button.tag = buttonCount;
            
            [button addTarget:self action:@selector(squareTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:button];
            [buttons addObject:button]; // to add each button the mutable array
            
            buttonCount++;
            
        }
        
    }
    
//    NSLog(@"subviews %@", self.view.subviews);

}


- (void)squareTapped:(UIButton *)button {
//  When button / square is tapped, do this...
    
    if ([squares[button.tag] intValue] != 0) { return; }    //don't allow changing button value
    
    
    squares[button.tag] = @(playerTurn);    // This literal turns the parameter into an object
    
//    [button setTitle:[NSString stringWithFormat:@"%d", playerTurn] forState:UIControlStateNormal];
    
    //Set the color of the buttons when pressed to the player color.
    if (playerTurn == 1) {
        button.backgroundColor = [UIColor greenColor];
    } else {
        button.backgroundColor = [UIColor redColor];
    }
    

//    Change the player turn when button is pressed
    playerTurn = (playerTurn == 2) ? 1 : 2;
    
//  Increment turnCount
    turnCount += 1;
    
//    NSLog(@"button tapped: %d", (int)button.tag);
    
    [self checkForWin];
    
}

- (void)checkForWin {
//    Check for a winning combination
    
    NSArray * possibilities = @[
                                //rows
                                @[@0,@1,@2],
                                @[@3,@4,@5],
                                @[@6,@7,@8],
                                
                                //cols
                                @[@0,@3,@6],
                                @[@1,@4,@7],
                                @[@2,@5,@8],
                                
                                //diagnols
                                @[@0,@4,@8],
                                @[@2,@4,@6],
                                ];
    
//    if (winCount < 1) {
    for (NSArray * possibility in possibilities) {
        
        [self checkPossibility:possibility andPlayer:1];
        [self checkPossibility:possibility andPlayer:2];
        
//    }
    }
}

- (void)checkPossibility:(NSArray *)possibility andPlayer:(int)player {
    
    BOOL playerInSquare1 = ([squares[[possibility[0] intValue]] intValue] == player);
    BOOL playerInSquare2 = ([squares[[possibility[1] intValue]] intValue] == player);
    BOOL playerInSquare3 = ([squares[[possibility[2] intValue]] intValue] == player);
    
    if (playerInSquare1 && playerInSquare2 && playerInSquare3) {
        
        // player won
//        winCount += 1;

        //Add win to score variable
        if (player == 1) {
            player1Score += 1;
        } else if (player == 2) {
            player2Score += 1;
        }
//        NSLog(@"Player 1 Score: %d \nPlayer 2 Score: %d", player1Score, player2Score);
        player1.text = [NSString stringWithFormat:@"Player One: %d", player1Score];
        player2.text = [NSString stringWithFormat:@"Player Two: %d", player2Score];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Game Over" message:[NSString stringWithFormat:@"Player %d Wins!", player] delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles: nil];
        
        [alertView show];
        
    } else if (turnCount == 9) {
        turnCount++;
        NSLog(@"Turncount is %d", turnCount);
        NSLog(@"TIE!");
       
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"It's a tie!" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles: nil];

        [alertView show];
        
    }
    
//    else if (turnCount == 9) {
//        
////        [self clearTiles];
//        NSLog(@"Made it to Else If, turnCount is %d", turnCount);
//        turnCount++;
//        
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"It's a tie!" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles: nil];
//        
//        [alertView show];
//        return;
//    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Alert View Ran, should clear tiles as well.");
    //Reset the array, the button titles, and the playerTurn
    
    [self clearTiles];
}


- (void)resetScore {
    
    player1Score = 0;
    player2Score = 0;
    
    player1.text = [NSString stringWithFormat:@"Player One: %d", player1Score];
    player2.text = [NSString stringWithFormat:@"Player Two: %d", player2Score];
    
    [self clearTiles];
    
}

- (void)clearTiles {
 
    playerTurn = 1;

    
    for (UIButton * button in buttons) {
        [button setTitle:@"" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
    }
    
    squares = [@[
                 @0, @0, @0,
                 @0, @0, @0,
                 @0, @0, @0
                 ] mutableCopy];
    
        turnCount = 0;
//        winCount = 0;

    NSLog(@"clearTiles Ran");
    
}




//- (void)reset:(UIButton *)button {
////  Remove the popUpWinner button This is necessary for the old way to call the button after the game is over
//
//    [button removeFromSuperview];
//    
//    [self viewDidLoad];    DONT DO THIS
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
