Overview
========
This project demonstrates how to use UIKitDynamics to add physics behaviour to on-screen objects.

Method for falling objects:
Add dynamic properties to UIViews. Instantiate UIDynamicItemBehavior object. Give dynamic behavior to an array of UIView objects:
        UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.square]];
Set the properties of the UIDynamicItemBehavior object:
        itemBehaviour.elasticity = 0.6; //Make the square somewhat bouncy.

Add gravity behaviour to UIViews. Instantiate a UIGravityBehavior object. Make an array of UIView object subject to gravity:
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.square]];

Add collision behaviour to UIViews. Instantiate a UICollisionBehavior object. Make an array of UIView objects collidable:
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.square]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;


Instantiate a strongly retained UIDynamicAnimator object and add the behaviours you wish to animate:
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.dynamicAnimator addBehavior:itemBehaviour];
    [self.dynamicAnimator addBehavior:gravityBehavior];
    [self.dynamicAnimator addBehavior:collisionBehavior];



Xcode Version: 5.x
iOS Version: 7 onwards.
