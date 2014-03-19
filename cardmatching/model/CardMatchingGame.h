//
//  CardMatchingGame.h
//  matchismo
//
//  Created by Kai Pervoelz on 14.03.14.
//  Copyright (c) 2014 kpervoelz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger) index;

-(Card *)cardAtIndex:(NSUInteger) index;

-(void)numberOfCardsToMatch:(NSUInteger) number;

-(void)reDealCards;


@property (nonatomic, readonly) NSInteger score;

@end
