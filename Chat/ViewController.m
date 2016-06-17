//
//  ViewController.m
//  Chat
//
//  Created by Mars on 16/6/3.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Server.hidden = YES;
    self.Server_Access.hidden = YES;
    self.Server_local_ip.hidden = YES;
    self.Client_Access.hidden = NO;
    self.Server_local_ip.text = [IP getIPAddress:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0){
        self.Server.hidden = YES;
        self.Server_Access.hidden = YES;
        self.Server_local_ip.hidden = YES;
        self.Client_Access.hidden = NO;
    
    }else {
        self.Client_Access.hidden = YES;
        self.Server.hidden = NO;
        self.Server_Access.hidden = NO;
        self.Server_local_ip.hidden = NO;
    }
}
@end
