//
//  ViewController.m
//  Lab04
//
//  Created by Martin Leon Preciado on 22/06/16.
//  Copyright © 2016 MartinLP. All rights reserved.
//

#import "Start.h"

@interface Start ()

@end

@implementation Start
/***************************************************************************************************************/
#pragma mark - Initialization methods
/***************************************************************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController {
    maIntroTitles   = [[NSMutableArray alloc] initWithObjects: @"Descubre los mejores clasicos", @"De la familia Nintendo", @"Creados Para el Mundo", nil];
    
    maIntroImgs     = [[NSMutableArray alloc] initWithObjects: @"SNES.png", @"mario.png", @"link.png", nil];
    
    [self createPageViews];
}

/**********************************************************************************************/
#pragma mark - Page controller methods and delegates
/**********************************************************************************************/
- (void)createPageViews {
    // Create page view controller
    self.pageViewController             = [self.storyboard instantiateViewControllerWithIdentifier:@"PageIntroController"];
    self.pageViewController.dataSource  = self;
    
    Intro *startingViewController       = [self viewControllerAtIndex:0];
    NSArray *viewControllers            = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Change the size of page view controller
    self.pageViewController.view.frame  = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    NSArray *subviews = self.pageViewController.view.subviews;
    UIPageControl *thisControl = nil;
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
            thisControl = (UIPageControl *)[subviews objectAtIndex:i];
        }
    }
    thisControl.hidden = true;
}
//-------------------------------------------------------------------------------
- (Intro *)viewControllerAtIndex:(NSUInteger)index
{
    if (([maIntroTitles count] == 0) || (index >= [maIntroTitles count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    Intro *pageIntro        = [self.storyboard instantiateViewControllerWithIdentifier:@"Intro"];
    pageIntro.iPageIndex    = index;
    
    return pageIntro;
}
//-------------------------------------------------------------------------------
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((Intro*) viewController).iPageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}
//-------------------------------------------------------------------------------
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((Intro*) viewController).iPageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}
//-------------------------------------------------------------------------------
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [maIntroTitles count];
}
//-------------------------------------------------------------------------------
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}




@end
