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
    [self.connector getEvents:^(NSDictionary *response)
                                        {
                                            //Success block
                                            weakSelf.response = response;
                                            weakSelf.eventsList = [self.connector eventsListFromResponse:response];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
