//
//  BeachesViewController.h
//  SOAPTest2
//
//  Created by Lucas on 1/28/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeachesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *beachesTableView;

@property (nonatomic, strong) NSMutableArray *elements;

@property (nonatomic, strong) NSString *latitud;

@property (nonatomic, strong) NSString *longitud;

@property (nonatomic, strong) NSString *distancia;

@end
