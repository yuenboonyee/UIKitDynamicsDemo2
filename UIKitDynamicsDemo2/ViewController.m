//
//  ViewController.m
//  UIKitDynamicsDemo2
//
//  Created by Serene IT on 21/08/2015.
//  Copyright (c) 2015 Serene IT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) CGRect originalImageFrame;
@property (nonatomic) CGAffineTransform originalTransform;
@property (weak, nonatomic) IBOutlet UIView *uiViewShelf;
/*!
 @brief  This object must be retained. If it is a local variable and is auto-released, nothing will animate.
 */
@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

/*!
 @brief  The behaviour of the image view.
 */
@property (strong, nonatomic) UIDynamicItemBehavior *itemBehaviour;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)viewDidAppear:(BOOL)animated{
    self.originalImageFrame = self.imageView.frame;
    self.originalTransform = self.imageView.transform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
/*!
 @brief  Gravity demonstration
 @param sender	The UIButton.
 */
-(IBAction)gravityDemo:(id)sender{
    [self resetViews];
    //Method for falling objects:
    //Add dynamic properties to UIViews. Instantiate UIDynamicItemBehavior object. Give dynamic behavior to an array of UIView objects:
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.imageView]];
    //Set the properties of the UIDynamicItemBehavior object:
    self.itemBehaviour.elasticity = 0.5; //Make the square somewhat bouncy.
    
    //Add gravity behaviour to UIViews. Instantiate a UIGravityBehavior object. Make an array of UIView object subject to gravity:
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView]];
    gravityBehavior.magnitude = 0.6;
    
    
    
    //Add collision behaviour to UIViews. Instantiate a UICollisionBehavior object. Make an array of UIView objects collidable:
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    //Add a boundary to bounce off.
    [collisionBehavior addBoundaryWithIdentifier:@"barrier"
                                       fromPoint:CGPointMake(self.uiViewShelf.frame.origin.x, self.uiViewShelf.frame.origin.y+1)
                                         toPoint:CGPointMake(self.uiViewShelf.frame.origin.x+self.uiViewShelf.frame.size.width, self.uiViewShelf.frame.origin.y+1)];
    
    
    //Instantiate a UIDynamicAnimator object and add the behaviours:
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.dynamicAnimator addBehavior:gravityBehavior];
    [self.dynamicAnimator addBehavior:collisionBehavior];
    [self.dynamicAnimator addBehavior:self.itemBehaviour];

}

/*!
 @brief  Spring demonstration.
 @param sender	The UIButton.
 */
-(IBAction)snapToPointDemo:(id)sender{
    [self resetViews];
    //Add dynamic properties to UIViews. Instantiate UIDynamicItemBehavior object. Give dynamic behavior to an array of UIView objects:
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.imageView]];
    //Set the properties of the UIDynamicItemBehavior object:
    self.itemBehaviour.allowsRotation = NO;  //Don't allow the image to rotate.
    
    //Add snap to point behaviour to UIViews.
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(self.view.center.x, self.view.center.y)];
    snapBehavior.damping = 0.0; //Lots of oscillation.
    
    
    //Instantiate a UIDynamicAnimator object and add the behaviours:
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.dynamicAnimator addBehavior:snapBehavior];
    [self.dynamicAnimator addBehavior:self.itemBehaviour];
    
}

/*!
 @brief Push demonstration.
 @param sender	The UIButton.
 */
-(IBAction)pushDemo:(id)sender{
    [self resetViews];
    //Add dynamic properties to UIViews. Instantiate UIDynamicItemBehavior object. Give dynamic behavior to an array of UIView objects:
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.imageView]];
    //Set the properties of the UIDynamicItemBehavior object:
    self.itemBehaviour.allowsRotation = NO;  //Don't allow the image to rotate.
    self.itemBehaviour.resistance = 2;
    
    //Add push behaviour to UIViews.
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.imageView]
                                                                    mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setAngle:3.141/2 magnitude:3.5];
    
    
    //Instantiate a UIDynamicAnimator object and add the behaviours:
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.dynamicAnimator addBehavior:pushBehavior];
    [self.dynamicAnimator addBehavior:self.itemBehaviour];
    
}

/*!
 @brief Push demonstration, without resetting the behaviours.
 @param sender	The UIButton.
 */
-(IBAction)pushWithoutResetDemo:(id)sender{
    //Add behaviour to UIViews.
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.imageView]
                                                                    mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setAngle:3.141/2 magnitude:3.5];
    
    
    //Instantiate a UIDynamicAnimator object and add the behaviours:
    [self.dynamicAnimator addBehavior:pushBehavior];
}

/*!
 @brief Push demonstration, without resetting the behaviours.
 @param sender	The UIButton.
 */
-(IBAction)spinRight:(id)sender{
    //Add behaviour to UIViews.
    self.itemBehaviour.allowsRotation = YES;
    [self.itemBehaviour addAngularVelocity:10 forItem:self.imageView];
}

-(IBAction)spinLeft:(id)sender{
    //Add behaviour to UIViews.
    self.itemBehaviour.allowsRotation = YES;
    [self.itemBehaviour addAngularVelocity:-10 forItem:self.imageView];
}

/*!
 @brief  Resets all animated views to the original location. Removes all dynamic behaviors.
 */
-(void)resetViews{
    [self.dynamicAnimator removeAllBehaviors];
    self.itemBehaviour = nil;
    self.imageView.frame = self.originalImageFrame;
    self.imageView.transform = self.originalTransform;
}
@end
