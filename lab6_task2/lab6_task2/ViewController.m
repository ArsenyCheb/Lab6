//
//  ViewController.m
//  lab6_task2
//
//  Created by Arseny Cheb on 11.05.17.
//  Copyright © 2017 Arseny Cheb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelWeather;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *textBox1;
@property (weak, nonatomic) IBOutlet UITextField *textBox2;

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self infoLabel] setText:@"Enter city name:"];
    [[self textBox2]setHidden:YES];
    [[self latitudeLabel]setHidden: YES];
    [[self longitudeLabel]setHidden:YES];
    [[self labelWeather]setText:@""];
    [[self textBox1] setPlaceholder:@"Minsk"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getWeather:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *urlName;
    switch([[self segmentedControl]selectedSegmentIndex]){
        case 0:
            urlName = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?id=524901&APPID=6df03063649992e17a88f53a3d49c4a3&q=%@", [[self textBox1]text]];
            break;
        case 1:
             urlName = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?&id=524901&APPID=6df03063649992e17a88f53a3d49c4a3&lat=%@&lon=%@", [[self textBox1] text], [[self textBox2]text]];
            break;
    }
    
    NSURL *url = [[NSURL alloc]
                  initWithString:urlName];
    
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    if (contents != nil){
        NSDictionary *forcasting = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
        if (forcasting != nil){
            NSLog(@"%@", forcasting);
            NSString *degrees = [[forcasting valueForKey:@"main"] valueForKey:@"temp"];
            double x = [degrees doubleValue] - 273;
            
            [self setTextColor:x];
            [[self labelWeather] setText:[NSString stringWithFormat:@"%.1f C",x]];
        }
        else
            [[self labelWeather]setText:@"Not found"];
    }
    else
        [[self labelWeather]setText:@"Not found"];
    
}

-(void)setTextColor:(double) temp{
    if (temp <= 4)
        [[self labelWeather] setTextColor:[UIColor blueColor]];
    else if (temp > 4 && temp <= 14)
        [[self labelWeather] setTextColor:[UIColor greenColor]];
    else if (temp > 14 && temp <= 22)
        [[self labelWeather] setTextColor:[UIColor yellowColor]];
    else if (temp > 22 && temp <= 30)
        [[self labelWeather] setTextColor:[UIColor orangeColor]];
    else
        [[self labelWeather] setTextColor:[UIColor redColor]];
}
- (IBAction)indexChanged:(id)sender {
    [[self textBox2]setText:@""];
    [[self textBox1]setText:@""];
    [[self labelWeather]setText:@""];
    
    switch([[self segmentedControl]selectedSegmentIndex]){
        case 0:
            [[self infoLabel]setText:@"Enter city name:"];
            [[self textBox2]setHidden:YES];
            [[self latitudeLabel]setHidden: YES];
            [[self longitudeLabel]setHidden:YES];
            [[self textBox1] setPlaceholder:@"Minsk"];
            break;
            
        case 1:
            [[self infoLabel]setText:@"Enter coordinates:"];
             [[self textBox2]setHidden:NO];
            [[self latitudeLabel]setHidden: NO];
            [[self longitudeLabel]setHidden: NO];
             [[self textBox1] setPlaceholder:@"53.55"];
            break;
    }
}

@end
