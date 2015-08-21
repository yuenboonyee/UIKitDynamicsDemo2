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
@property (weak, nonatomic) IBOutlet UIView *uiViewShelf;
@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) UICollisionBehavior *collisionBehavior;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UIDynamicItemBehavior* itemBehaviour;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    //Method for falling objects:
    //Add dynamic properties to UIViews. Instantiate UIDynamicItemBehavior object. Give dynamic behavior to an array of UIView objects:
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.imageView]];
    //Set the properties of the UIDynamicItemBehavior object:
    self.itemBehaviour.elasticity = 0.4; //Make the square somewhat bouncy.
    self.itemBehaviour.resistance = 0.99;
    
    //Add gravity behaviour to UIViews. Instantiate a UIGravityBehavior object. Make an array of UIView object subject to gravity:
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView]];
    self.gravityBehavior.magnitude = 0.7;
    
    
    
    //Add collision behaviour to UIViews. Instantiate a UICollisionBehavior object. Make an array of UIView objects collidable:
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView]];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    //Add a boundary to bounce off.
    [self.collisionBehavior addBoundaryWithIdentifier:@"barrier"
                                            fromPoint:CGPointMake(self.uiViewShelf.frame.origin.x, self.uiViewShelf.frame.origin.y)
                                              toPoint:CGPointMake(self.uiViewShelf.frame.origin.x+self.uiViewShelf.frame.size.width, self.uiViewShelf.frame.origin.y)];

    
    
    //Instantiate a UIDynamicAnimator object and add the behaviours:
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    [self.dynamicAnimator addBehavior:self.itemBehaviour];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
