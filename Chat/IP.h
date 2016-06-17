//
//  IP.h
//  Chat
//
//  Created by Mars on 16/6/5.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface IP : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end
