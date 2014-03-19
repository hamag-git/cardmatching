//
//  Card.m
//  matchismo
//
//  Created by Kai Pervölz on 06.03.14.
//  Copyright (c) 2014 kpervoelz. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *) otherCards{
    int matchScore = 0;
    
    for (Card *card in otherCards) {
        if([self.content isEqualToString:card.content]){
            matchScore++;
        }
    }
    
    return matchScore;
}

@end
