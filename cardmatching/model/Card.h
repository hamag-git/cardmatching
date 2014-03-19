//
//  Card.h
//  matchismo
//
//  Created by Kai Pervölz on 06.03.14.
//  Copyright (c) 2014 kpervoelz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *content;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) match:(NSArray *) otherCards;

@end
