//
//  ViewController.h
//  Doctor Who
//
//  Created by Appmonkeyz on 2/23/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "Constants.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnDoctor;

@property (weak, nonatomic) IBOutlet UITextField *txtSpeciality;
@property (weak, nonatomic) IBOutlet UITextField *txtLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) DownPicker *specialityPicker;
@property (strong, nonatomic) DownPicker *locationsPicker;

- (IBAction) btnSearch : (id) sender;

- (void) specialitiesSelected : (id) pickerData;
- (void) locationSelected : (id) pickerData; //get location by  index


@end
