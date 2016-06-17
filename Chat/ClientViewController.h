//
//  ClientViewController.h
//  Chat
//
//  Created by Mars on 16/6/3.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import CocoaAsyncSocket;
#import "AsyncSocket.h"


@interface ClientViewController : UIViewController <UITextFieldDelegate, AsyncSocketDelegate,UITextFieldDelegate>
{
    AsyncSocket *_socket;
}

@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UITextField *Client_textEdit;

- (IBAction)Client_SendMessage:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *receiveData;

@property (weak, nonatomic) IBOutlet UITextField *clientIPAddress;
- (IBAction)Connect:(id)sender;
@end
