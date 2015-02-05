//
//  BeachesViewController.m
//  SOAPTest2
//
//  Created by Lucas on 1/28/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "BeachesViewController.h"
#import "BeachesTableViewCell.h"

@interface BeachesViewController ()

@end

@implementation BeachesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.beachesTableView registerNib:[UINib nibWithNibName:@"BeachesTableViewCell" bundle:[NSBundle mainBundle]]
       forCellReuseIdentifier:@"BeachCellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"COUNT : %lu",[self.elements count],nil);
    return (NSInteger)[self.elements count];

}

-(BeachesTableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeachesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeachCellId"];
    if (cell == nil)
    {
        //cell = [[BeachesTableViewCell alloc] init];
        cell = [[BeachesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BeachCellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell configureCellWithDictionary:[[self elements] objectAtIndex:indexPath.row]];
    
    return cell;
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
