//
//  EventosViewController.m
//  SOAPTest2
//
//  Created by Lucas on 2/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "EventosViewController.h"


@interface EventosViewController ()

@property (nonatomic, strong) WSMGPCulturaEnVivoEventos *connector;
@property (nonatomic, strong) NSDictionary *response;
@property (nonatomic, strong) NSArray *eventsList;
@property (strong, nonatomic) IBOutlet UITableView *eventosTableView;

@end

@implementation EventosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.eventosTableView registerNib:[UINib nibWithNibName:@"GenericTableViewCell" bundle:[NSBundle mainBundle]]
                forCellReuseIdentifier:@"GenericCellId"];
    
    self.response = [[NSDictionary alloc] init];
    
    // Do any additional setup after loading the view from its nib.
    self.connector = [[WSMGPCulturaEnVivoEventos alloc] init];
    __weak EventosViewController *weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.connector getEvents:^(NSDictionary *response)
     {
         
         //This is the actual success block
         weakSelf.response = response;
         weakSelf.eventsList = [self.connector eventsListFromResponse:response];
         [weakSelf populateCategoriesTableView];
         
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         
         
         
         
     }
                      failure:^(NSError *error)
     {
         //Failure block
         NSLog(@"UPS! OCURRIO UN ERROR!");
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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
    NSLog(@"Categories dictionary: %@", self.response);
    [self.eventosTableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GenericTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCellId"];
    if (cell == nil)
    {
        GenericTableViewCell *cell = [[GenericTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    [cell setDataWithDictionary:[self.eventsList objectAtIndex:indexPath.row]];
    
    return cell;
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.eventsList count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end
