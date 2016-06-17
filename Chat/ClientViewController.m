//
//  ClientViewController.m
//  Chat
//
//  Created by Mars on 16/6/3.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import "ClientViewController.h"

@interface ClientViewController ()

@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户端";
     _receiveData.editable = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)append:(NSString *)text {
    
    _receiveData.text = [_receiveData.text stringByAppendingFormat:@"%@\n", text];
}

-(IBAction)Client_SendMessage:(id)sender{
    if ((_Client_textEdit.text.length != 0) && (_clientIPAddress.text.length != 0))
    {
        
        if (_socket == nil) {
            _socket = [[AsyncSocket alloc] init];
        }
        [_socket writeData:[_Client_textEdit.text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
        [_Client_textEdit resignFirstResponder];
        [self append:[NSString stringWithFormat:@"Me:%@", _Client_textEdit.text]];
        [_socket readDataWithTimeout:-1 tag:0];
        self.Client_textEdit.text = @"";
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Waring!"
                              message:@"Please Input Message/ClientIP"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
}
/*
- (IBAction)repeats:(id)sender {
    NSTimeInterval timeInterval = 1.0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(Send:) userInfo:nil repeats:YES];
    [timer fire];
}
*/
- (IBAction)Connect:(id)sender{
    
    if (_socket == nil) {
        _socket = [[AsyncSocket alloc] initWithDelegate:self];
        NSError *error = nil;
        if (![_socket connectToHost:_clientIPAddress.text onPort:8080 error:&error]) {
            _status.text = @"Could't Connect Server";
        } else {
            _status.text = @"Connect Server Successfully";
        }
    } else {
        _status.text = @"Connect Server Successfully";
    }
}

#pragma mark AsyncSocket Delegate

//建立连接
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    
    [self append:[NSString stringWithFormat:@"ConnectToHost:%@", host]];
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
    [sock readDataWithTimeout:-1 tag:0];
}

//读取数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self append:[NSString stringWithFormat:@"He:%@", newMessage]];
    //[_socket readDataWithTimeout:-1 tag:0];//可以省略
}

//是否加密
- (void)onSocketDidSecure:(AsyncSocket *)sock {
    NSLog(@"onSocket:%p", sock);
    
}

//遇到错误时断开连接
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    [self append:[NSString stringWithFormat:@"onSocket:%p, error:%@", sock, err.localizedDescription]];
}

//断开连接
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSString *msg = @"Connect is disconnect";
    _status.text = msg;
    //[msg release];
    _socket = nil;
}



@end
