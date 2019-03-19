//
//  ViewController.m
//  decodeStr
//
//  Created by 小华 on 2019/3/18.
//  Copyright © 2019年 小华. All rights reserved.
//

#import "ViewController.h"

#import "NSString+URLEncode.h"

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)clear:(id)sender
{
   
    [self.textView setStringValue:@""];

    [self.decoderL setStringValue:@""];

    [self.view.window setContentSize:NSMakeSize(400, 80)];
    
}

- (IBAction)transferBTN:(id)sender
{
    if (!self.textView.stringValue.length) return;
    
    NSString *DecodeStr= [self.textView.stringValue URLDecodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString *uniCode=[DecodeStr stringByReplacingOccurrencesOfString:@"[" withString:@"\\u"];
    
    NSString *uniCode2=[uniCode stringByReplacingOccurrencesOfString:@"]" withString:@""];
    
    NSString *uniCode3 = [uniCode2 stringByRemovingPercentEncoding];
    
    NSString *tempStr1 = [uniCode3 stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    NSString *finish= [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
    NSLog(@"%@",finish);
    
    [self.decoderL setStringValue:finish];
    
//    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
//    [pasteboard clearContents];  //必须清空，否则setString会失败。
//    [pasteboard setString:finish forType:NSStringPboardType];
    

}


@end
