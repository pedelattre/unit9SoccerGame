//
//  ZizouCharacter.h
//  Unit9SoccerGame
//
//  Created by pepe on 18/10/2014.
//  Copyright (c) 2014 pepe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"
#import "ZizouSprite.h"

@class ZizouSprite;

@interface ZizouCharacter : NSObject{
    
    cpSpace *space;
    ZizouSprite *zizouSprite;
    
    
    //Bodies
    
    cpBody *bodyBody;
    cpBody *leftLegBody;
    cpBody *leftPantBody;
    cpBody *rightArmBody;
    cpBody *leftArmBody;
    
    
    //Shapes
    
    cpShape *bodyShape;
    cpShape *leftLegShape;
    cpShape *leftPantShape;
    cpShape *rightArmShape;
    cpShape *leftArmShape;
    
    
    //Constraints - LEFT LEG
    
    cpConstraint *leftLegToBodyPivot;
    
    
    //Constraints - LEFT PANT
    
    cpConstraint *leftPantToBodyPivot;
    
    
    //Constraints - RIGHT ARM
    
    cpConstraint *rightArmToBodyPivot;
    
    
    //Constraints - LEFT ARM
    
    cpConstraint *leftArmToBodyPivot;
    
    
    //Limits
    
    cpConstraint *leftShoulderRotationLimit;
    cpConstraint *rightShoulderRotationLimit;
    cpConstraint *leftHipRotationLimit;
    
    
    //Values
    
    float leftHipMax;
    float leftHipMin;
    float rightShoulderMax;
    float rightShoulderMin;
    float leftShoulderMax;
    float leftShoulderMin;
    
}

@property (nonatomic, retain) ZizouSprite *zizouSprite;

-(id)initWithSpriteBatchNode:(CCSpriteBatchNode *)batchNode withChipmunkPhysicsSpace:(cpSpace *)pSpace;

-(void)updateSprites;

-(void)initBodyWithSprite:(CCSprite *)sprite withSize:(CGSize)size withSpace:(cpSpace *)currentSpace withBody:(cpBody *)currentBody withMass:(cpFloat)mass withPartMass:(cpFloat)partMass withShape:(cpShape *)currentShape;

-(void)initZizouPhysicsWithPosition;

-(void)destroyPartWithSpace:(cpSpace *)currentSpace withConstraint:(cpConstraint *)constraint withShape:(cpShape *)shape withBody:(cpBody *)body;

-(void)destroyLimitsWithSpace:(cpSpace *)currentSpace withConstraint:(cpConstraint *)constraint;

-(void)destroyZizouPhysicsObjects;

@end
