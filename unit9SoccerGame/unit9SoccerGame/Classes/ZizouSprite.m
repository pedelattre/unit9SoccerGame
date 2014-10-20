//
//  ZizouSprite.m
//  Unit9SoccerGame
//
//  Created by pepe on 18/10/2014.
//  Copyright (c) 2014 pepe. All rights reserved.
//

#import "ZizouSprite.h"


@implementation ZizouSprite

@synthesize body;
@synthesize leftLeg;
@synthesize leftPant;
@synthesize rightArm;
@synthesize leftArm;

-(id)initWithSpriteBatchNode:(CCSpriteBatchNode *)batchNode{
    self = [super init];
    
    spriteBatchNode = batchNode;
    
    if (!self) return(nil);
    
    if (self) {
        self.body = [CCSprite spriteWithImageNamed:@"zizou.png"];
        self.leftLeg = [CCSprite spriteWithImageNamed:@"leftLeg.png"];
        self.leftPant = [CCSprite spriteWithImageNamed:@"leftPant.png"];
        self.rightArm = [CCSprite spriteWithImageNamed:@"rightArm.png"];
        self.leftArm = [CCSprite spriteWithImageNamed:@"leftArm.png"];
        
        [spriteBatchNode addChild:body z:0 ];
        [spriteBatchNode addChild:leftLeg z:2 ];
        [spriteBatchNode addChild:leftPant z:3 ];
        [spriteBatchNode addChild:rightArm z:-1 ];
        [spriteBatchNode addChild:leftArm z:1 ];
        
    }
    
    return self;
}

-(void)dealloc{
    if (spriteBatchNode != nil) {
        [spriteBatchNode removeChild:body cleanup:YES];
        [spriteBatchNode removeChild:leftLeg cleanup:YES];
        [spriteBatchNode removeChild:leftPant cleanup:YES];
        [spriteBatchNode removeChild:rightArm cleanup:YES];
        [spriteBatchNode removeChild:leftArm cleanup:YES];
    }
    
    self.body = nil;
    self.leftLeg = nil;
    self.leftPant = nil;
    self.rightArm = nil;
    self.leftArm = nil;
}

@end
