//
//  PlayScene.h
//  Unit9SoccerGame
//
//  Created by pepe on 18/10/2014.
//  Copyright (c) 2014 pepe. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "IntroScene.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "chipmunk.h"

@interface PlayScene : CCScene
{
    CCSprite *background;
    CCSprite *field;
    CCSprite *player;
    CCSprite *goal;
    CCSprite *ball;
    
    cpSpace *space;
    
    
}

+ (PlayScene *)scene;
- (id)init;


@end
