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
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched=YES;
                        card.matched=YES;
                    }else {
                        self.score -= MATCH_PENALTY;
                        otherCard.chosen=NO;
                    }
                    break;
                    
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen= YES;
        }
        
        
        
    }
    
    
    
    
}




@end
