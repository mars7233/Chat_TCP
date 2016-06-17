//
//  ServerViewController.m
//  Chat
//
//  Created by Mars on 16/6/3.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController ()

@end

@implementation ServerViewController

bool isRunning = NO;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _receiveData.editable = NO;

//socket初始化
    listenrSocket = [[AsyncSocket alloc] initWithDelegate:self];
    _Server_textEdit.delegate = self;
    connnectionSocketsArray = [[NSMutableArray alloc]initWithCapacity:40];
    [self sendMsg];
    
    //self.Scroll.contentInset.top = 0.0f;
    self.navigationItem.title = @"服务器端";
}




- (void)append:(NSString *)text {
    NSMutableString *string = [NSMutableString stringWithString:_receiveData.text];
    [string appendFormat:@"\n%@", text];
    _receiveData.text = string;
    
}

- (void)sendMsg {
    if (!isRunning) {
        NSError *error = nil;
        if (![listenrSocket acceptOnPort:8080 error:&error]) {
            return;
        }
        isRunning = YES;
        NSLog(@"开始监听");
    } else {
        NSLog(@"重新监听");
        //断开当前监听
        [listenrSocket disconnect];
        //断开所有connectionSocket
        for (int i = 0; i < connnectionSocketsArray.count; i++) {
            [[connnectionSocketsArray objectAtIndex:i] disconnect];
        }
        isRunning = NO;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    //[self onSocketDidSecure:listenrSocket];
}



- (IBAction)Server_SendMessage:(id)sender {
    if ((_Server_textEdit.text.length) != 0)
    {
        [listenrSocket writeData:[_Server_textEdit.text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];
        [self append:[NSString stringWithFormat:@"Me:%@",_Server_textEdit.text]];
        //[_Server_receiveDatas setObject:_Server_textEdit.text forKey:@"send"];
        self.Server_textEdit.text = @"";
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Waring!"
                              message:@"Please Input Message"
                              delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self Server_SendMessage:nil];
    return YES;
}

#pragma mark socketDeleaget

//连接socket出错
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    
    NSLog(@"error:%@", err.localizedDescription);
}

// 收到新的socket连接
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket {
    [connnectionSocketsArray addObject:newSocket];
    
}

//读取数据
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
    [sock readDataWithTimeout:-1 tag:0];
}

//与服务器建立连接,并发送消息
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    
    listenrSocket = sock;
    NSLog(@"host:%@", host);
    NSString *msg = @"Welcome To Socket Test Server";
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:data withTimeout:-1 tag:0];
}

//读取客户端发来的数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //获取当前的socket
    for (int i = 0; i < connnectionSocketsArray.count; i++) {
        AsyncSocket *socket = (AsyncSocket *)[connnectionSocketsArray objectAtIndex:i];
        
        //if ([socket.connectedHost isEqualToString:ip]) {
            //[socket writeData:data withTimeout:-1 tag:0];
            //记录接收的信息
            if (msg) {
                [self append:[[NSString alloc] initWithFormat:@"He:%@",msg]];
                NSLog(@"%@", msg);
            } else {
                
                NSLog(@"error!");
            }
        //}
        //客户端未连接
        /*
            else {
            NSString *returnMsg = @"The Other Is Not Online";
            NSData *returnData = [returnMsg dataUsingEncoding:NSUTF8StringEncoding];
            [sock writeData:returnData withTimeout:-1 tag:0];
        }*/
    }
}

//断开
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    [connnectionSocketsArray removeObject:sock];
}

@end
