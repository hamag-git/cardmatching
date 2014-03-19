//
//  CardMatchingGame.m
//  matchismo
//
//  Created by Kai Pervoelz on 14.03.14.
//  Copyright (c) 2014 kpervoelz. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic,strong) NSMutableArray * cards;
@property (nonatomic) NSUInteger numberCardToMatch;

@end


@implementation CardMatchingGame




- (NSMutableArray *)cards{
    if(!_cards) _cards =[[NSMutableArray alloc] init];
    return _cards;
}

-(void)reDealCards
{
    [self.cards removeAllObjects];
    
    
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if(self){
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else {
                self = nil;
                break;
            }
        }
        
        
    }
    return self;
}

- (instancetype)init{
    return nil;
}

-(Card *)cardAtIndex:(NSUInteger) index{
    return (index<[self.cards count] ? self.cards[index] : nil);
}

static const int MATCH_PENALTY=2;
static const int COST_TO_CHOOSE=1;
static const int MATCH_BONUS=4;


-(void)chooseCardAtIndex:(NSUInteger) index{
    Card *card = [self cardAtIndex:index];
    
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen= NO;
        }else {
            NSMutableArray * chosenCards = [[NSMutableArray alloc] init];
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    [chosenCards addObject:otherCard];
                }
            }
            NSLog(@"chosenCards count: %d and numberToMatch: %d", [chosenCards count],self.numberCardToMatch);
            if([chosenCards count] == self.numberCardToMatch-1){
                NSLog(@"start matching");
                int matchScore = [card match:chosenCards];
                if(matchScore){
                    self.score += matchScore * MATCH_BONUS;
                    for(Card *otherCard in self.cards){
                        if(otherCard.isChosen && !otherCard.isMatched){
                            otherCard.matched=YES;
                            card.matched=YES;
                        }
                    }
                }else {
                    self.score -= MATCH_PENALTY;
                    for(Card *otherCard in self.cards){
                        if(otherCard.isChosen && !otherCard.isMatched){
                            otherCard.chosen=NO;
                        }
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen= YES;
        }
    }
}

-(void)numberOfCardsToMatch:(NSUInteger) number{
    self.numberCardToMatch = number;
    NSLog(@"No of Card to Match: %d", self.numberCardToMatch);
    
}





@end
