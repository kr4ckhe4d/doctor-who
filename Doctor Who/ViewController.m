//
//  ViewController.m
//  Doctor Who
//
//  Created by Appmonkeyz on 2/23/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//

#import "ViewController.h"
#import "DoctorProfileViewController.h"

@interface ViewController  ()

@end

NSArray *specialities;
NSArray *locations;
NSArray *doctorsArray;
NSArray *hospitalsArray;

NSMutableArray * matches;

NSString *searchString;
NSString *selectedSpeciality;
NSString *selectedName;

NSInteger locationIndex;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HOME";
    _btnDoctor.layer.cornerRadius = BUTTON_RADIUS;
    
    //Assigning Array Values
    specialities = [NSArray arrayWithArray:SPECIALITIES_ARRAY];
    locations = [NSArray arrayWithArray:LOCATIONS_ARRAY];
    doctorsArray = [NSArray arrayWithArray:DOCTORS_ARRAY];
    hospitalsArray = [NSArray arrayWithArray:HOSPITALS_ARRAY];
    
    //Specialities Drop down configuration
    self.specialityPicker = [[DownPicker alloc] initWithTextField:self.txtSpeciality withData:specialities];
    [self.specialityPicker setPlaceholder:@"- Speciality -"];
    [self.specialityPicker addTarget:self action:@selector(sp_Selected:) forControlEvents:UIControlEventValueChanged];
    
    //Locations Dropdown configuration
    self.locationsPicker = [[DownPicker alloc] initWithTextField:self.txtLocation withData:locations];
    [self.locationsPicker setPlaceholder:@"- Location -"];
    [self.locationsPicker addTarget:self action:@selector(location_Selected:) forControlEvents:UIControlEventValueChanged];
    
    //Search by name Text Field change event
    [_txtName addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    //hospitalsArray = [NSArray arrayWithArray:[self readData:@"Hospitals"]];
    //specialities = [NSArray arrayWithArray:[self readData:@"Specialities"]];
    NSLog(@"%@",[self readData:@"test"]);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Actions
- (IBAction)btnSearch:(id)sender {
    
}

#pragma mark - Custom Methods
-(void)sp_Selected:(id)dp{
    NSLog(@"%@",[self.specialityPicker text]);
}

-(void)location_Selected:(id)dp{
    NSLog(@"%@",[self.locationsPicker text]);
}

-(void)textFieldDidChange:(id)dp{
    searchString = [self.txtName text];
    NSString *predicate = [NSString stringWithFormat:@"SELF contains[c] '%@'",searchString];
    
    matches = [NSMutableArray arrayWithArray:doctorsArray];
    [matches filterUsingPredicate:[NSPredicate predicateWithFormat:predicate]];
    
    //NSMutableSet * notmatches = [NSMutableSet setWithArray:doctorsArray];
    // [notmatches  minusSet:matches];
    
   // NSLog(@"%@",matches);
    [self.tableView reloadData];
    
}

-(NSArray *)readData:(NSString *)fileName{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:[[NSData alloc]
                                                             initWithContentsOfFile:jsonPath]
                                                    options:0
                                                      error:&error];
    if (error)
    {
        NSLog(@"Could not serialize JSON file");
        return 0;
    }
    else
    {
        return json;
    }
}

#pragma mark - Keyboard Dismiss
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark - Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger number = [matches count];
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *doctorName = [matches objectAtIndex:indexPath.row];
    NSString *doctorSpeciality = [specialities objectAtIndex:indexPath.row];
    
    cell.textLabel.text=doctorName;
    cell.detailTextLabel.text=doctorSpeciality;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"DOCTOR_PROFILE" sender:self];
}

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    // now you can use cell.textLabel.text
    
    selectedName = cell.textLabel.text;
    selectedSpeciality = cell.detailTextLabel.text;
    
    DoctorProfileViewController *doctorprofile = (DoctorProfileViewController *)segue.destinationViewController;
    
    doctorprofile.selectedName = selectedName;
    doctorprofile.selectedSpeciality = selectedSpeciality;
    doctorprofile.hospitalsArray = [hospitalsArray objectAtIndex:indexPath.row];
    
    //[self.tableView reloadData];
}





@end
