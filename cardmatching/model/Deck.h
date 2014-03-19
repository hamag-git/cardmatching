//
//  Deck.h
//  matchismo
//
//  Created by Kai Pervölz on 06.03.14.
//  Copyright (c) 2014 kpervoelz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
