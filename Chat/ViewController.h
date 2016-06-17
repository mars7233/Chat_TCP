//
//  ViewController.h
//  Chat
//
//  Created by Mars on 16/6/3.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CocoaAsyncSocket;
#import "AsyncSocket.h"
#import "IP.h"

@interface ViewController : UIViewController
//IP
@property (weak, nonatomic) IBOutlet UILabel *Server_local_ip;

//文字
@property (weak, nonatomic) IBOutlet UILabel *Server;

//跳转按钮

@property (weak, nonatomic) IBOutlet UIButton *Server_Access;
@property (weak, nonatomic) IBOutlet UIButton *Client_Access;

- (IBAction)toggleControls:(UISegmentedControl *)sender;

@end

