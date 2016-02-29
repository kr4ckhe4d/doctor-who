//
//  DoctorProfileViewController.h
//  Doctor Who
//
//  Created by Appmonkeyz on 2/24/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DoctorProfileViewController : UIViewController

@property (weak,nonatomic) NSString *selectedName;
@property (weak,nonatomic) NSString *selectedSpeciality;

@property (weak,nonatomic) NSArray *hospitalsArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *lblDoctorName;
@property (weak, nonatomic) IBOutlet UILabel *lblSpeciality;

@property (weak, nonatomic) IBOutlet UIButton *btnShowReviews;
@property (weak, nonatomic) IBOutlet UIButton *btnWriteReview;

@end
