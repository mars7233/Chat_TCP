//
//  ServerViewController.h
//  Chat
//
//  Created by Mars on 16/6/3.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import CocoaAsyncSocket;
#import "AsyncSocket.h"


@interface ServerViewController : UIViewController <UITextFieldDelegate, AsyncSocketDelegate> {
    //监听客户端请求
    AsyncSocket *listenrSocket;
    
    //当前请求连接的客户端
    NSMutableArray *connnectionSocketsArray;
}

//@property (nonatomic,strong) NSMutableArray* Server_receiveObject;


@property (weak, nonatomic) IBOutlet UITextView *receiveData;


@property (strong,nonatomic) NSMutableDictionary* Server_receiveDatas;

@property (weak, nonatomic) IBOutlet UITextField *Server_textEdit;
//@property (strong, nonatomic)
- (IBAction)Server_SendMessage:(id)sender;

@end
