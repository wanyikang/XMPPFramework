//
//  Message+XMPP.h
//  coldplay_ios
//
//  Created by richard on 15/5/26.
//  Copyright (c) 2015年 janady. All rights reserved.
//

#import "Message+XMPP.h"
#import "NSXMLElement+XMPP.h"

@implementation XMPPMessage (ImageMessage)

#pragma mark - genenal
- (NSString *)mid{
    return [[self attributeForName:@"id"] stringValue];
}

#pragma mark - order
- (BOOL)isOrderCreateMessage{
    BOOL result = NO;
    if ([self isOrderMessage]) {
        NSXMLElement *detailsElement = [self elementForName:@"body"];
        NSString *action = [[detailsElement attributeForName:@"action"] stringValue];
        if ([action isEqualToString:@"create_order"]) {
            result = YES;
        }
    }
    return result;
}

- (BOOL)isOrderUpdateMessage{
    BOOL result = NO;
    if ([self isOrderMessage]) {
        NSXMLElement *detailsElement = [self elementForName:@"body"];
        NSString *action = [[detailsElement attributeForName:@"action"] stringValue];
        if (![action isEqualToString:@"create_order"]) {
            result = YES;
        }
    }
    return result;
}

- (BOOL)hasReceiverFlagInOrderMessage{
    BOOL result = NO;
    if ([self isOrderCreateMessage]) {
        NSXMLElement *detailsElement = [self elementForName:@"body"];
        NSString *isReceiver = [[detailsElement attributeForName:@"is_receiver"] stringValue];
        if (isReceiver) {
            result = YES;
        }
    }
    return result;
}

- (BOOL)isOrderMessage{
	return [[[self attributeForName:@"type"] stringValue] isEqualToString:@"order_alert"];
}

- (NSString *)orderAction{
    NSString *action;
    if ([self isOrderMessage]) {
        NSXMLElement *detailsElement = [self elementForName:@"body"];
        action = [[detailsElement attributeForName:@"action"] stringValue];
    }
    return action;
}

- (NSString *)oid{
    NSString *oid;
    if ([self isOrderMessage]) {
        NSXMLElement *detailsElement = [self elementForName:@"body"];
        oid = [[detailsElement attributeForName:@"order_id"] stringValue];
    }
    return oid;
}

#pragma mark - goods
- (BOOL)isGoodsMessage{
    return [[[self attributeForName:@"type"] stringValue] isEqualToString:@"goods_alert"];
}

- (NSString *)gid{
    NSString *gid;
    if ([self isGoodsMessage]) {
        NSXMLElement *bodyElement = [self elementForName:@"body"];
        gid = [[bodyElement attributeForName:@"name"] stringValue];
    }
    return gid;
}

- (long)cidOfGoods{
    long cid;
    if ([self isGoodsMessage]) {
        NSXMLElement *bodyElement = [self elementForName:@"body"];
        cid = (long)[bodyElement attributeInt64ValueForName:@"cid" withDefaultValue:0];
    }
    return cid;
}

#pragma mark - company
- (BOOL)isCompanyMessage{
    return [[[self attributeForName:@"type"] stringValue] isEqualToString:@"company_alert"];
}

- (long)cidOfCompany{
    long cid;
    if ([self isCompanyMessage]) {
        NSXMLElement *bodyElement = [self elementForName:@"body"];
        cid = (long)[bodyElement attributeInt64ValueForName:@"cid" withDefaultValue:0];
    }
    return cid;
}

- (NSString *)name{
    NSString *name;
    if ([self isCompanyMessage]) {
        NSXMLElement *bodyElement = [self elementForName:@"body"];
        name = [[bodyElement attributeForName:@"name"] stringValue];
    }
    return name;
}

- (NSString *)uuidOfPrinter{
    NSString *uuid;
    if ([self isCompanyMessage]) {
        NSXMLElement *bodyElement = [self elementForName:@"body"];
        uuid = [[bodyElement attributeForName:@"uuid"] stringValue];
    }
    return uuid;
}

- (NSString *)companyAction{
    NSString *action;
    if ([self isCompanyMessage]) {
        NSXMLElement *bodyElement = [self elementForName:@"body"];
        action = [[bodyElement attributeForName:@"action"] stringValue];
    }
    return action;
}

- (BOOL)isAddMemberAction{
    BOOL result = NO;
    NSString *action = [self companyAction];
    if ([action isEqualToString:@"add_employee"]) {
        result = YES;
    }
    return result;
}

- (BOOL)isRemoveMemberAction{
    BOOL result = NO;
    NSString *action = [self companyAction];
    if ([action isEqualToString:@"remove_employee"]) {
        result = YES;
    }
    return result;
}

- (BOOL)isCompanyMemberMessage{
    BOOL result = NO;
    if ([self isAddMemberAction] || [self isRemoveMemberAction]) {
        result = YES;
    }
    return result;
}

- (BOOL)isAddPrinterAction{
    BOOL result = NO;
    NSString *action = [self companyAction];
    if ([action isEqualToString:@"add_printer"]) {
        result = YES;
    }
    return result;
}

- (BOOL)isRemovePrinterAction{
    BOOL result = NO;
    NSString *action = [self companyAction];
    if ([action isEqualToString:@"remove_printer"]) {
        result = YES;
    }
    return result;
}

- (BOOL)isCompanyPrinterMessage{
    BOOL result = NO;
    if ([self isAddPrinterAction] || [self isRemovePrinterAction]) {
        result = YES;
    }
    return result;
}

#pragma mark - image
+ (XMPPMessage *)generateImageMessageNodeToJid:(XMPPJID *)jid messageId:(NSString *)mid lifecycleName:(NSString *)imageName{
    if (!jid || !mid || !imageName) {
        return nil;
    }
    NSXMLElement *imageElement = [NSXMLElement elementWithName:@"body" stringValue:imageName];
    XMPPMessage *xMsg = [XMPPMessage messageWithType:@"image" to:jid elementID:mid];
    [xMsg addChild:imageElement];
    return xMsg;
}

- (BOOL)isImageMessage{
    NSString *type = [[self attributeForName:@"type"] stringValue];
	if ([type isEqualToString:@"image"])
	{
		return YES;
	}

	return NO;
}

- (NSString *)imageName{
    NSString *name;
    if ([self isImageMessage]) {
        NSXMLElement *nameElement = [self elementForName:@"body"];
        name = [nameElement stringValue];
    }
    return name;
}

@end