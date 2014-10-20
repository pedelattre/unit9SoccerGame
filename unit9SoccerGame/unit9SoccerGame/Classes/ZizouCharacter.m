//
//  ZizouCharacter.m
//  Unit9SoccerGame
//
//  Created by pepe on 18/10/2014.
//  Copyright (c) 2014 pepe. All rights reserved.
//

#import "ZizouCharacter.h"

#define zizouCollisionType 1

@implementation ZizouCharacter

@synthesize zizouSprite;

-(id)initWithSpriteBatchNode:(CCSpriteBatchNode *)batchNode withChipmunkPhysicsSpace:(cpSpace *)pSpace{
    
    self = [super init];
    if (!self) return(nil);
    
    if (self) {
        space = pSpace;
        self.zizouSprite = [[ZizouSprite alloc] initWithSpriteBatchNode: batchNode];
        [self initZizouPhysicsWithPosition];
    }
    
    return self;
}

-(void)updateSprites{
    
    [self destroyZizouPhysicsObjects];
    self.zizouSprite = nil;    
}

-(void)initBodyWithSprite:(CCSprite *)sprite withSize:(CGSize)size withSpace:(cpSpace *)currentSpace withBody:(cpBody *)currentBody withMass:(cpFloat)mass withPartMass:(cpFloat)partMass withShape:(cpShape *)currentShape{
    
    float zizouScale = 0.05;
    float scale = 0.75;
    
    //Defines the size of each part of the body
    sprite.scale =zizouScale;
    
    //Defines the size of the physics bodies and shapes by multiplying the actual file size by the early defined scale
    size = CGSizeMake(sprite.contentSize.width * zizouScale, sprite.contentSize.height * zizouScale);
    
    //Defines the mass of each part of the body
    partMass = cpMomentForBox(mass, size.width, size.height);
    
    //Creates each body and assigns their mass
    currentBody = cpBodyNew(mass, partMass);
    cpSpaceAddBody(currentSpace, currentBody);
    
    //Creates the shapes and attaches them to the bodies
    currentShape = cpBoxShapeNew(currentBody, size.width * scale, size.height * scale, 0);
    cpSpaceAddShape(currentSpace, currentShape);
}


-(void)initZizouPhysicsWithPosition{
    
    
    //Size
    
    CGSize bodySize;
    CGSize leftLegSize;
    CGSize leftPantSize;
    CGSize rightArmSize;
    CGSize leftArmSize;
    
    
    //Mass
    
    cpFloat bodyMass;
    cpFloat leftLegMass;
    cpFloat leftPantMass;
    cpFloat rightArmMass;
    cpFloat leftArmMass;
    
    
    //Initialization of body parts
    
    [self initBodyWithSprite:zizouSprite.body withSize:bodySize withSpace:space withBody:bodyBody withMass:30 withPartMass:bodyMass withShape:bodyShape];
    [self initBodyWithSprite:zizouSprite.leftLeg withSize:leftLegSize withSpace:space withBody:leftLegBody withMass:9 withPartMass:leftLegMass withShape:leftLegShape];
    [self initBodyWithSprite:zizouSprite.leftPant withSize:leftPantSize withSpace:space withBody:leftPantBody withMass:1 withPartMass:leftPantMass withShape:leftPantShape];
    [self initBodyWithSprite:zizouSprite.rightArm withSize:rightArmSize withSpace:space withBody:rightArmBody withMass:6 withPartMass:rightArmMass withShape:rightArmShape];
    [self initBodyWithSprite:zizouSprite.leftArm withSize:leftArmSize withSpace:space withBody:leftArmBody withMass:6 withPartMass:leftArmMass withShape:leftArmShape];
    

    //Connects bodies together with pivots
    
    //Anchors on the body
    CGPoint bodyAnchorForLeftLeg = cpv(bodySize.width * 0.61, bodySize.height * 0.70);
    CGPoint bodyAnchorForLeftPant = cpv(bodySize.width * 0.54, bodySize.height * 0.70);
    CGPoint bodyAnchorForRightArm = cpv(bodySize.width * 0.09, bodySize.height * 0.34);
    CGPoint bodyAnchorForLeftArm = cpv(bodySize.width * 0.90, bodySize.height * 0.34);
    
    //Anchor on the left leg
    CGPoint leftLegAnchorForBody = cpv(leftLegSize.width * 0.37, leftLegSize.height * 0);
    
    //Anchor on the left pant
    CGPoint leftPantAnchorForBody = cpv(leftPantSize.width * 0, leftPantSize.height * 0);
    
    //Anchor on the right arm
    CGPoint rightArmAnchorForBody = cpv(rightArmSize.width * 0.5, rightArmSize.height * 0);
    
    //Anchor on the left arm
    CGPoint leftArmAnchorForBody = cpv(leftArmSize.width * 0.5, leftArmSize.height * 0);
    
    leftLegToBodyPivot = cpPivotJointNew2(bodyBody, leftLegBody, bodyAnchorForLeftLeg, leftLegAnchorForBody);
    leftPantToBodyPivot = cpPivotJointNew2(bodyBody, leftPantBody, bodyAnchorForLeftPant, leftPantAnchorForBody);
    rightArmToBodyPivot = cpPivotJointNew2(bodyBody, rightArmBody, bodyAnchorForRightArm, rightArmAnchorForBody);
    leftArmToBodyPivot = cpPivotJointNew2(bodyBody, leftArmBody, bodyAnchorForLeftArm, leftArmAnchorForBody);
    
    cpSpaceAddConstraint(space, leftArmToBodyPivot);
    cpSpaceAddConstraint(space, leftPantToBodyPivot);
    cpSpaceAddConstraint(space, rightArmToBodyPivot);
    cpSpaceAddConstraint(space, leftArmToBodyPivot);
    
    
    //Add limits
    
    leftHipMin = 0;
    leftHipMax = M_PI_2;
    rightShoulderMin = -M_PI_4;
    rightShoulderMax = M_PI_2;
    leftShoulderMin = -M_PI_4;
    leftShoulderMax = M_PI_2;
    
    leftHipRotationLimit = cpRotaryLimitJointNew(bodyBody, leftLegBody, leftHipMin, leftHipMax);
    rightShoulderRotationLimit = cpRotaryLimitJointNew(bodyBody, rightArmBody, rightShoulderMin, rightShoulderMax);
    leftShoulderRotationLimit = cpRotaryLimitJointNew(bodyBody, leftArmBody, leftShoulderMin, leftShoulderMax);
    
    cpSpaceAddConstraint(space, leftHipRotationLimit);
    cpSpaceAddConstraint(space, rightShoulderRotationLimit);
    cpSpaceAddConstraint(space, leftShoulderRotationLimit);
}



-(void)destroyPartWithSpace:(cpSpace *)currentSpace withConstraint:(cpConstraint *)constraint withShape:(cpShape *)shape withBody:(cpBody *)body{
    cpSpaceRemoveConstraint(currentSpace, constraint);
    cpConstraintFree(constraint);
    
    cpSpaceRemoveShape(currentSpace, shape);
    cpShapeFree(shape);
    
    cpSpaceRemoveBody(currentSpace, body);
    cpBodyFree(body);
}

-(void)destroyLimitsWithSpace:(cpSpace *)currentSpace withConstraint:(cpConstraint *)constraint{
    cpSpaceRemoveConstraint(currentSpace, constraint);
    cpConstraintFree(constraint);
}

-(void)destroyZizouPhysicsObjects{
    
    [self destroyLimitsWithSpace:space withConstraint:leftHipRotationLimit];
    [self destroyLimitsWithSpace:space withConstraint:leftShoulderRotationLimit];
    [self destroyLimitsWithSpace:space withConstraint:rightShoulderRotationLimit];
    
    [self destroyPartWithSpace:space withConstraint:leftLegToBodyPivot withShape:leftLegShape withBody:leftPantBody];
    [self destroyPartWithSpace:space withConstraint:leftPantToBodyPivot withShape:leftPantShape withBody:leftPantBody];
    [self destroyPartWithSpace:space withConstraint:rightArmToBodyPivot withShape:rightArmShape withBody:rightArmBody];
    [self destroyPartWithSpace:space withConstraint:leftArmToBodyPivot withShape:leftArmShape withBody:leftArmBody];
}


@end
