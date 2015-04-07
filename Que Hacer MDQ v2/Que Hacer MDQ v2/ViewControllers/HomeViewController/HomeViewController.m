//
//  HomeViewController.m
//  SOAPTest2
//
//  Created by Lucas on 2/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "HomeViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "MMDrawerBarButtonItem.h"

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet UIButton *btnEventos;
@property (strong, nonatomic) IBOutlet UIButton *btnLugares;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mainMenu = (PIMainMenuController *)self.mm_drawerController.leftDrawerViewController;
    self.mainMenu.delegate = self;
    [self configureSideBar];
}


- (IBAction)btnEventosAction:(id)sender {
    
    EventosViewController *eventsScreen = [[EventosViewController alloc] initWithNibName:@"EventosViewController" bundle:nil];
    
    [self.navigationController pushViewController:eventsScreen animated:YES];
}

- (IBAction)btnLugaresAction:(id)sender {
    
}

- (void)configureSideBar {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.view.frame = screenRect;
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.translucent = NO;
    } else {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    
    [self configureLeftBarButton];

    
    self.mm_drawerController.isAccessibilityElement = YES;
    self.mm_drawerController.maximumLeftDrawerWidth = 270;
    self.mm_drawerController.maximumRightDrawerWidth = 270;
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeCustom;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
    
}

- (void)configureLeftBarButton {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *leftButtonImage = [UIImage imageNamed:@"menu"];
    leftButton.frame = CGRectMake(0, 0, 40, 40);
    leftButton.contentMode = UIViewContentModeBottomLeft;
    
    [leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(didSelectMainMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *leftButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton2.frame = CGRectMake(0, 0, 15, 40);
    leftButton2.contentMode = UIViewContentModeBottomLeft;
    [leftButton2 setBackgroundColor:[UIColor clearColor]];
    [leftButton2 addTarget:self action:@selector(didSelectMainMenu:) forControlEvents:UIControlEventTouchUpInside];
    MMDrawerBarButtonItem *xxx = [[MMDrawerBarButtonItem alloc] initWithCustomView:leftButton2];
    
    [self.navigationItem setLeftBarButtonItems:@[[self spacer], leftDrawerButton, xxx]];
}

- (void)didSelectMainMenu:(id)sender {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (UIBarButtonItem *)spacer {
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -11;
    return space;
}

-(void)didSelectSearch {}

-(void)didSelectInteres {}

-(void)didSelectAllEvent {}

-(void)didSelectGastronomia {}
@end






