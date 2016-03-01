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

NSDictionary *doctorsArrayss;

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
    
    
    doctorsArrayss = @{
                      @"names" : @[
                              @"Peter Allen",@"Tina Arena",@"Jimmy Barnes",@"Nick Cave",@"John Farnham",@"Jimmy Fallon",@"Sean Allen",@"Jaqueline Arena",@"Missy Higgins",@"Georg Danzer",@"Rainhard Fendrich",@"Jacques Brel"
                              
                              ],
                      @"speciality" : @[
                              @"Allergy or Immunology",@"Anesthesiology",@"Cancer Surgeon",@"Dermatologists",@"Emergency Medicine",@"Gynecologic Oncology",@"Hematology",@"Internal Medicine",@"Dentist",@"Cardiologist",@"Paediatrics",@"Neuro Surgeon"
                              ],
                      @"hospitals" : @[
                              @[@"Royal Hospital",@"Asiri Hospital",@"Asiri Surgical Hospital",@"The Central Hospital"],
                              @[@"Royal Hospital",@"Asiri Hospital"],
                              @[@"Asiri Surgical Hospital",@"The Central Hospital",@"Durdans Hospital"],
                              @[@"Asiri Surgical Hospital",@"Nawaloka Hospital"],
                              @[@"Royal Hospital",@"Asiri Hospital",@"Nawaloka Hospital"],
                              @[@"Asiri Surgical Hospital",@"Nawaloka Hospital"],
                              @[@"Royal Hospital",@"Durdans Hospital",@"Nawaloka Hospital"],
                              @[@"Asiri Surgical Hospital",@"The Central Hospital"],
                              @[@"Royal Hospital",@"Durdans Hospital",@"Nawaloka Hospital"],
                              @[@"Royal Hospital",@"Asiri Hospital"],
                              @[@"Asiri Hospital",@"The Central Hospital",@"Nawaloka Hospital"],
                              @[@"Royal Hospital",@"Asiri Surgical Hospital",@"The Central Hospital"]
                              ],
                      @"locations" : @[
                              @"Colombo",@"Galle",@"Kandy",@"Matara",@"Negombo",@"Hambantota",@"Polonnaruwa",@"Jaffna",@"Trincomalee",@"Kurunegala",@"Kegalle",@"Jaffna"
                              ]
                      
                      };
    
    //Specialities Drop down configuration
    self.specialityPicker = [[DownPicker alloc] initWithTextField:self.txtSpeciality withData:[doctorsArrayss objectForKey:@"speciality"]];
    [self.specialityPicker setPlaceholder:@"- Speciality -"];
    [self.specialityPicker addTarget:self action:@selector(sp_Selected:) forControlEvents:UIControlEventValueChanged];
    
    //Locations Dropdown configuration
    self.locationsPicker = [[DownPicker alloc] initWithTextField:self.txtLocation withData:[doctorsArrayss objectForKey:@"locations"]];
    [self.locationsPicker setPlaceholder:@"- Location -"];
    [self.locationsPicker addTarget:self action:@selector(location_Selected:) forControlEvents:UIControlEventValueChanged];
    
    //Search by name Text Field change event
    [_txtName addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
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
    
    matches = [NSMutableArray arrayWithArray:[doctorsArrayss objectForKey:@"names"]];
    [matches filterUsingPredicate:[NSPredicate predicateWithFormat:predicate]];
    
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


#pragma mark - TableView delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger number = [matches count];
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *doctorName = [matches objectAtIndex:indexPath.row];
    NSString *doctorSpeciality = [[doctorsArrayss objectForKey:@"speciality"] objectAtIndex:indexPath.row];
    
    cell.textLabel.text=doctorName;
    cell.detailTextLabel.text=doctorSpeciality;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger anIndex=[[doctorsArrayss objectForKey:@"names"] indexOfObject:[matches objectAtIndex:indexPath.row]];
    if(NSNotFound == anIndex) {
        NSLog(@"not found");
    }
    NSLog(@"Selected index %ld",(long)anIndex);
    
    [self performSegueWithIdentifier:@"DOCTOR_PROFILE" sender:self];
}

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger anIndex=[[doctorsArrayss objectForKey:@"names"] indexOfObject:[matches objectAtIndex:indexPath.row]];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    // now you can use cell.textLabel.text
    
    selectedName = cell.textLabel.text;
    selectedSpeciality = cell.detailTextLabel.text;
    
    DoctorProfileViewController *doctorprofile = (DoctorProfileViewController *)segue.destinationViewController;
    
    doctorprofile.selectedName = selectedName;
    doctorprofile.selectedSpeciality = selectedSpeciality;
    doctorprofile.hospitalsArray = [[doctorsArrayss objectForKey:@"hospitals"] objectAtIndex:anIndex];
    
    //[self.tableView reloadData];
}





@end
