//
//  HomeViewController.m
//  SOAPTest2
//
//  Created by Lucas on 2/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet UIButton *btnEventos;
@property (strong, nonatomic) IBOutlet UIButton *btnLugares;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnEventosAction:(id)sender {
    
    EventosViewController *eventsScreen = [[EventosViewController alloc] initWithNibName:@"EventosViewController" bundle:nil];
    
    [self.navigationController pushViewController:eventsScreen animated:YES];
}

- (IBAction)btnLugaresAction:(id)sender {
    
    
    
}



@end






