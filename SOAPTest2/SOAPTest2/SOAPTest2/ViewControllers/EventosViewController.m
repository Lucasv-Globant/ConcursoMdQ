//
//  EventosViewController.m
//  SOAPTest2
//
//  Created by Lucas on 2/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "EventosViewController.h"

@interface EventosViewController ()

@property (nonatomic, strong) WSMGPEventos *conector;

@property (nonatomic, strong) NSDictionary *categoriesList;

@end

@implementation EventosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.beachesTableView registerNib:[UINib nibWithNibName:@"GenericTableViewCell" bundle:[NSBundle mainBundle]]
                forCellReuseIdentifier:@"GenericCellId"];

    self.categoriesList = [[NSDictionary alloc] init];
    
    // Do any additional setup after loading the view from its nib.
    self.conector = [[WSMGPEventos alloc] init];
    __weak EventosViewController *weakSelf = self;
    [self.conector getEventsCategories:^(NSDictionary *response)
                                        {
                                            //Success block
                                            weakSelf.categoriesList = response;
                                            [weakSelf populateCategoriesTableView];
                                        }
                               failure:^(NSError *error)
                                        {
                                            //Failure block
                                            NSLog(@"UPS! OCURRIO UN ERROR!");
                                        }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateCategoriesTableView
{
    NSLog(@"Called populateCategoriesTableView");
    NSLog(@"Categories dictionary: %@", self.categoriesList);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCellId"];
    
    [cell setData: self.categoriesList
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
