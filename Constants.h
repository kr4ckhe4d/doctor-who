//
//  Constants.h
//  Doctor Who
//
//  Created by Appmonkeyz on 2/26/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern float const BUTTON_RADIUS;

extern NSArray *SPECIALITIES_ARRAY;

//temporary arrays
#define SPECIALITIES_ARRAY  [NSArray arrayWithObjects: @"Allergy or Immunology",@"Anesthesiology",@"Cancer Surgeon",@"Dermatologists",@"Emergency Medicine",@"Gynecologic Oncology",@"Hematology",@"Internal Medicine",@"Dentist",@"Cardiologist",@"Paediatrics",@"Neuro Surgeon",nil]
#define LOCATIONS_ARRAY  [NSArray arrayWithObjects: @"Colombo",@"Galle",@"Kandy",@"Matara",@"Negombo",@"Hambantota",@"Polonnaruwa",@"Jaffna",@"Trincomalee",nil]
#define DOCTORS_ARRAY  [NSArray arrayWithObjects: @"Peter Allen",@"Tina Arena",@"Jimmy Barnes",@"Nick Cave",@"John Farnham",@"Jimmy Fallon",@"Sean Allen",@"Jaqueline Arena",@"Missy Higgins",@"Georg Danzer",@"Rainhard Fendrich",@"Jacques Brel",nil]
#define HOSPITALS_ARRAY  [NSArray arrayWithObjects: @[@"Royal Hospital",@"Asiri Hospital",@"Asiri Surgical Hospital",@"The Central Hospital"],@[@"Royal Hospital",@"Asiri Hospital"],@[@"Asiri Surgical Hospital",@"The Central Hospital",@"Durdans Hospital"],@[@"Asiri Surgical Hospital",@"Nawaloka Hospital"],@[@"Royal Hospital",@"Asiri Hospital",@"Nawaloka Hospital"],@[@"Asiri Surgical Hospital",@"Nawaloka Hospital"],@[@"Royal Hospital",@"Durdans Hospital",@"Nawaloka Hospital"],@[@"Asiri Surgical Hospital",@"dfs"],@[@"Royal Hospital",@"Durdans Hospital",@"Nawaloka Hospital"],@[@"Royal Hospital",@"Asiri Hospital"],@[@"Asiri Hospital",@"The Central Hospital",@"Nawaloka Hospital"],@[@"Royal Hospital",@"Asiri Surgical Hospital",@"The Central Hospital"],nil]


@end
