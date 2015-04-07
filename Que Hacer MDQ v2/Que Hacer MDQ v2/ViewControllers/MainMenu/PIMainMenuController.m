//
//  PIMainMenuController.m
//  Que Hacer MDQ v2
//
//  Created by Matias Gelos on 07/10/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "PIMainMenuCell.h"
#import "PIMainMenuController.h"

@interface PIMainMenuController ()

@property (nonatomic, retain) UIImageView *accesoryImageView;

@end

@implementation PIMainMenuController



#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.alwaysBounceVertical = NO;
    [self configureForOSVersion];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)configureForOSVersion {
    CGRect frame = self.mainTableView.frame;
    frame.origin.y = 20;
    self.mainTableView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PIMainMenuCell *menuCell = [self.mainTableView dequeueReusableCellWithIdentifier:[PIMainMenuCell cellIdentifier]];
    
    if (!menuCell) {
        menuCell = [PIMainMenuCell buildWithOwner:self];
    }
    
    switch (indexPath.row) {
        case 0:
            [menuCell configureWithTitle:@"Search"];
            break;
        
        case 1:
            [menuCell configureWithTitle:@"Mis Intereses"];
            break;
            
        case 2:
            [menuCell configureWithTitle:@"Todos los Eventos"];
            break;
            
        case 3:
            [menuCell configureWithTitle:@"Favorito"];
            break;
            
        case 4:
            [menuCell configureWithTitle:@"Gastronomia"];
            break;
            
        default:
            break;
    }
    
    return menuCell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.delegate didSelectSearch];
            break;
            
        case 1:
            [self.delegate didSelectInteres];
            break;
            
        case 2:
            [self.delegate didSelectAllEvent];
            break;
            
        case 3:
            [self.delegate didSelectFavorite];
            break;

        case 4:
            [self.delegate didSelectGastronomia];
            break;
            
        default:
            break;
    }
}

@end
