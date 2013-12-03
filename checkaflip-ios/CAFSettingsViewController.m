//
//  CAFSettingsViewController.m
//  checkaflip-ios
//
//  Created by caf on 12/2/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFSettingsViewController.h"

@implementation CAFSettingsViewController
{
    NSArray* _cities;
}
- (IBAction) manualCitySwitchChanged:(UISwitch *)sender {
    self.selectCityButton.enabled = sender.on;
    self.cityLabel.enabled = sender.on;
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"cl_manual_city"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) viewDidLoad
{
    _cities = [NSArray arrayWithObjects:@"sfbay",@"houston",@"abilene",@"akroncanton",@"albany",@"albanyga",@"albuquerque",@"altoona",@"amarillo",@"ames",@"anchorage",@"annarbor",@"annapolis",@"appleton",@"asheville",@"ashtabula",@"athensga",@"athensohio",@"atlanta",@"auburn",@"augusta",@"austin",@"bakersfield",@"baltimore",@"batonrouge",@"battlecreek",@"beaumont",@"bellingham",@"bemidji",@"bend",@"billings",@"binghamton",@"bham",@"bismarck",@"bloomington",@"bn",@"boise",@"boone",@"boston",@"boulder",@"bgky",@"bozeman",@"brainerd",@"brownsville",@"brunswick",@"buffalo",@"butte",@"capecod",@"catskills",@"cedarrapids",@"cnj",@"cenla",@"centralmich",@"chambana",@"charleston",@"charlestonwv",@"charlotte",@"charlottesville",@"chattanooga",@"chautauqua",@"chicago",@"chico",@"chillicothe",@"cincinnati",@"clarksville",@"cleveland",@"clovis",@"collegestation",@"cosprings",@"columbiamo",@"columbia",@"columbus",@"columbusga",@"cookeville",@"corpuschristi",@"corvallis",@"chambersburg",@"dallas",@"danville",@"dayton",@"daytona",@"decatur",@"nacogdoches",@"delrio",@"delaware",@"denver",@"desmoines",@"detroit",@"dothan",@"dubuque",@"duluth",@"eastidaho",@"eastoregon",@"eastco",@"newlondon",@"eastnc",@"eastky",@"montana",@"martinsburg",@"easternshore",@"eauclaire",@"elpaso",@"elko",@"elmira",@"erie",@"eugene",@"evansville",@"fairbanks",@"fargo",@"farmington",@"fayetteville",@"fayar",@"fingerlakes",@"flagstaff",@"flint",@"shoals",@"florencesc",@"keys",@"fortcollins",@"fortdodge",@"fortsmith",@"fortwayne",@"frederick",@"fredericksburg",@"fresno",@"fortmyers",@"gadsden",@"gainesville",@"galveston",@"glensfalls",@"goldcountry",@"grandforks",@"grandisland",@"grandrapids",@"greatfalls",@"greenbay",@"greensboro",@"greenville",@"gulfport",@"norfolk",@"hanford",@"harrisburg",@"harrisonburg",@"hartford",@"hattiesburg",@"honolulu",@"cfl",@"helena",@"hickory",@"rockies",@"hiltonhead",@"holland",@"houma",@"hudsonvalley",@"humboldt",@"huntington",@"huntsville",@"imperial",@"indianapolis",@"inlandempire",@"iowacity",@"ithaca",@"jxn",@"jackson",@"jacksontn",@"jacksonville",@"onslow",@"janesville",@"jerseyshore",@"jonesboro",@"joplin",@"kalamazoo",@"kalispell",@"kansascity",@"kenai",@"kpr",@"racine",@"killeen",@"kirksville",@"klamath",@"knoxville",@"kokomo",@"lacrosse",@"lasalle",@"lafayette",@"tippecanoe",@"lakecharles",@"loz",@"lakeland",@"lancaster",@"lansing",@"laredo",@"lascruces",@"lasvegas",@"lawrence",@"lawton",@"allentown",@"lewiston",@"lexington",@"limaohio",@"lincoln",@"littlerock",@"logan",@"longisland",@"losangeles",@"louisville",@"lubbock",@"lynchburg",@"macon",@"madison",@"maine",@"ksu",@"mankato",@"mansfield",@"masoncity",@"mattoon",@"mcallen",@"meadville",@"medford",@"memphis",@"mendocino",@"merced",@"meridian",@"milwaukee",@"minneapolis",@"missoula",@"mobile",@"modesto",@"mohave",@"monroemi",@"monroe",@"monterey",@"montgomery",@"morgantown",@"moseslake",@"muncie",@"muskegon",@"myrtlebeach",@"nashville",@"nh",@"newhaven",@"neworleans",@"blacksburg",@"newyork",@"lakecity",@"nd",@"newjersey",@"northmiss",@"northplatte",@"nesd",@"northernwi",@"nmi",@"wheeling",@"nwct",@"nwga",@"nwks",@"enid",@"ocala",@"odessa",@"ogden",@"okaloosa",@"oklahomacity",@"olympic",@"omaha",@"oneonta",@"orangecounty",@"oregoncoast",@"orlando",@"outerbanks",@"owensboro",@"palmsprings",@"panamacity",@"parkersburg",@"pensacola",@"peoria",@"philadelphia",@"phoenix",@"csd",@"pittsburgh",@"plattsburgh",@"poconos",@"porthuron",@"portland",@"potsdam",@"prescott",@"provo",@"pueblo",@"pullman",@"quadcities",@"raleigh",@"rapidcity",@"reading",@"redding",@"reno",@"providence",@"richmond",@"richmondin",@"roanoke",@"rmn",@"rochester",@"rockford",@"roseburg",@"roswell",@"sacramento",@"saginaw",@"salem",@"salina",@"saltlakecity",@"sanangelo",@"sanantonio",@"sandiego",@"slo",@"sanmarcos",@"sandusky",@"santabarbara",@"santafe",@"santamaria",@"sarasota",@"savannah",@"scottsbluff",@"scranton",@"seattle",@"sheboygan",@"showlow",@"shreveport",@"sierravista",@"siouxcity",@"siouxfalls",@"siskiyou",@"skagit",@"southbend",@"southcoast",@"sd",@"miami",@"southjersey",@"ottumwa",@"seks",@"juneau",@"semo",@"swv",@"carbondale",@"smd",@"swks",@"marshall",@"natchez",@"bigbend",@"swva",@"swmi",@"spacecoast",@"spokane",@"springfieldil",@"springfield",@"staugustine",@"stcloud",@"stgeorge",@"stjoseph",@"stlouis",@"pennstate",@"statesboro",@"stillwater",@"stockton",@"susanville",@"syracuse",@"tallahassee",@"tampa",@"terrehaute",@"texarkana",@"texoma",@"thumb",@"toledo",@"topeka",@"treasure",@"tricities",@"tucson",@"tulsa",@"tuscaloosa",@"tuscarawas",@"twinfalls",@"twintiers",@"easttexas",@"up",@"utica",@"valdosta",@"ventura",@"burlington",@"victoriatx",@"visalia",@"waco",@"washingtondc",@"waterloo",@"watertown",@"wausau",@"wenatchee",@"wv",@"quincy",@"westky",@"westmd",@"westernmass",@"westslope",@"wichita",@"wichitafalls",@"williamsport",@"wilmington",@"winchester",@"winstonsalem",@"worcester",@"wyoming",@"yakima",@"york",@"youngstown",@"yubasutter",@"yuma",@"zanesville", nil];
    
    [self update];
}

- (void) update
{
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    NSString* city = [prefs objectForKey:@"cl_city_name"];
    BOOL manual = [prefs boolForKey:@"cl_manual_city"];
    
    if (!city)
        city = @"wichita";
    if (!manual)
        manual = false;
    
    [self.manualCitySwitch setOn:manual];
    [self.selectCityButton setTitle:city forState:UIControlStateNormal];
    self.selectCityButton.enabled = self.manualCitySwitch.on;
    self.cityLabel.enabled = self.manualCitySwitch.on;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self update];
}

- (IBAction)showActionSheet:(id)sender {
    UIActionSheet* as = [[UIActionSheet alloc] initWithTitle:@"Craigslist City" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    for (NSString* city in _cities)
        [as addButtonWithTitle:city];
    
    as.actionSheetStyle = UIActionSheetStyleDefault;
    [as showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* city = [_cities objectAtIndex:buttonIndex];
    [self.selectCityButton setTitle:city forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"cl_city_name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
