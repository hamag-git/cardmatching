//
//  PlayingCard.h
//  matchismo
//
//  Created by Kai Pervölz on 06.03.14.
//  Copyright (c) 2014 kpervoelz. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSUInteger) maxRank;

@end
