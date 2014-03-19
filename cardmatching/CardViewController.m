//
//  CardGameViewController.m
//  matchismo
//
//  Created by Kai Pervölz on 28.02.14.
//  Copyright (c) 2014 kpervoelz. All rights reserved.
//

#import "CardViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()

@property (nonatomic, strong) CardMatchingGame *gameModel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegControl;

@end

@implementation CardGameViewController


-(CardMatchingGame *)gameModel{
    if(!_gameModel) _gameModel = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                                   usingDeck:[self createDeck]];
    return _gameModel;
}


- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)reDealButton:(id)sender {
    self.gameModel = nil;
    self.gameModeSegControl.enabled = YES;
    [self updateUI];
    
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if (self.gameModeSegControl.enabled){
        NSInteger selectedSegment = self.gameModeSegControl.selectedSegmentIndex;
        [self.gameModel numberOfCardsToMatch:selectedSegment+2];
        self.gameModeSegControl.enabled = NO;
    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    NSLog(@"touchCardButton index: %d", chosenButtonIndex);
    [self.gameModel chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
}

- (IBAction)selectGameMode:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    [self.gameModel numberOfCardsToMatch:selectedSegment+2];
}

-(void) updateUI{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card * card = [self.gameModel cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
    }
}

-(NSString *) titleForCard:(Card *) card {
    return card.isChosen ? card.content : @"";
}

-(UIImage *) backgroundImageForCard:(Card *) card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
