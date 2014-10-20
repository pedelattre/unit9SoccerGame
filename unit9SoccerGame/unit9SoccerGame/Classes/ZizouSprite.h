//
//  ZizouSprite.h
//  Unit9SoccerGame
//
//  Created by pepe on 18/10/2014.
//  Copyright (c) 2014 pepe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ZizouSprite : NSObject{
    
    CCSprite *body;
    CCSprite *leftLeg;
    CCSprite *leftPant;
    CCSprite *rightArm;
    CCSprite *leftArm;
    
    CCSpriteBatchNode *spriteBatchNode;
}

@property (nonatomic, retain) CCSprite *body;
@property (nonatomic, retain) CCSprite *leftLeg;
@property (nonatomic, retain) CCSprite *leftPant;
@property (nonatomic, retain) CCSprite *rightArm;
@property (nonatomic, retain) CCSprite *leftArm;

-(id)initWithSpriteBatchNode:(CCSpriteBatchNode *)batchNode;

@end
