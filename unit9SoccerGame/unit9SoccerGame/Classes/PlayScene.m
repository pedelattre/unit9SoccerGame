//
//  PlayScene.m
//  Unit9SoccerGame
//
//  Created by pepe on 18/10/2014.
//  Copyright (c) 2014 pepe. All rights reserved.
//

#import "PlayScene.h"

@implementation PlayScene
{
    CCSprite *_sprite;
}


+ (PlayScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    //Creation of the bg
    background = [CCSprite spriteWithImageNamed:@"background.png"];
    [background setScale:0.2];
    [background setAnchorPoint: ccp(0, 0)];
    background.positionType = CCPositionTypeNormalized;
    background.position = ccp(0,0);
    [self addChild:background];
    
    //Creation of the field
    field = [CCSprite spriteWithImageNamed:@"field.png"];
    [field setScale:0.3];
    [field setAnchorPoint:ccp(0, 1)];
    field.positionType = CCPositionTypeNormalized;
    field.position = ccp(-0.01, 0.2);
    [self addChild:field];
    
    //Creation of the zizou's body
    player = [CCSprite spriteWithImageNamed:@"zizou.png"];
    [player setScale:0.05];
    [player setAnchorPoint:ccp(0.5, 0)];
    player.positionType = CCPositionTypeNormalized;
    player.position = ccp(0.75, 0.2);
    [self addChild:player];
    
    //Creation of the goal
    goal = [CCSprite spriteWithImageNamed:@"goal.png"];
    [goal setScale:0.05];
    [goal setAnchorPoint:ccp(0, 0)];
    goal.positionType = CCPositionTypeNormalized;
    goal.position = ccp(0.0,0.2);
    [self addChild:goal];
    
    //Creation of the ball
    ball = [CCSprite spriteWithImageNamed:@"ball.png"];
    [ball setScale:0.05];
    [ball setAnchorPoint:ccp(0, 0)];
    ball.positionType = CCPositionTypeNormalized;
    ball.position = ccp(0.5,0.2);
    [self addChild:ball];
    
    
    
    return self;
    
}


// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
    [_sprite runAction:actionMove];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------

@end
