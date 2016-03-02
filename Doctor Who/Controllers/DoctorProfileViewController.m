//
//  DoctorProfileViewController.m
//  Doctor Who
//
//  Created by Appmonkeyz on 2/24/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//

#import "DoctorProfileViewController.h"

@interface DoctorProfileViewController ()

@end

@implementation DoctorProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DOCTOR PROFILE";
    
    NSLog(@"%@",self.hospitalsArray);
    
    self.btnShowReviews.layer.cornerRadius=BUTTON_RADIUS;
    self.btnWriteReview.layer.cornerRadius=BUTTON_RADIUS;
    
    self.lblDoctorName.numberOfLines = 1;
    self.lblDoctorName.adjustsFontSizeToFitWidth = YES;
    
    self.profileImage.image = [UIImage imageNamed:self.selectedName];
    
    self.lblDoctorName.text = [NSString stringWithFormat:@"Dr. %@",self.selectedName];
    self.lblSpeciality.text = [NSString stringWithFormat:@"%@",self.selectedSpeciality];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated {
    self.hospitalsArray = NULL;
}

#pragma mark - TableView Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger number = [self.hospitalsArray count];
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *hospitalName = [self.hospitalsArray objectAtIndex:indexPath.row];
    
    cell.layer.cornerRadius = BUTTON_RADIUS;
    cell.textLabel.text=hospitalName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"DOCTOR_REVIEW" sender:self];
}

#pragma mark - Button Actions

- (IBAction)showReviews:(id)sender {
}

- (IBAction)writeReview:(id)sender {
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
