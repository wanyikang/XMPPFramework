//
//  Message+XMPP.h
//  coldplay_ios
//
//  Created by richard on 15/5/26.
//  Copyright (c) 2015年 janady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPMessage.h"

@interface XMPPMessage (ImageMessge)

- (NSString *)mid;

- (BOOL)isOrderMessage;
- (BOOL)isOrderCreateMessage;
- (BOOL)isOrderUpdateMessage;
- (BOOL)hasReceiverFlagInOrderMessage;
- (NSString *)oid;
- (NSString *)orderAction;

- (BOOL)isGoodsMessage;
- (NSString *)gid;
- (long)cidOfGoods;

- (BOOL)isCompanyMemberMessage;
- (BOOL)isCompanyPrinterMessage;
- (long)cidOfCompany;
- (NSString *)name;
- (NSString *)uuidOfPrinter;
- (BOOL)isAddMemberAction;
- (BOOL)isRemoveMemberAction;
- (BOOL)isAddPrinterAction;
- (BOOL)isRemovePrinterAction;

- (BOOL)isImageMessage;
- (NSString *)imageName;

+ (XMPPMessage *)generateImageMessageNodeToJid:(XMPPJID *)jid messageId:(NSString *)mid lifecycleName:(NSString *)imageName;
@end