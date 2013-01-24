//
//  RPPasswordManagementAppService.m
//  Riposte
//
//  Copyright (c) 2013 Riposte LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "RPSTPasswordManagementAppService.h"

#define kOnePasswordURL_v3 @"onepassword3://"
#define kOnePasswordURL_v4 @"onepassword4://"
#define kOnePasswordURL_v4_1 @"onepassword://"
#define kOnePasswordURL_v4_1b @"onepasswordb://"

@implementation RPSTPasswordManagementAppService

+ (BOOL)passwordManagementAppIsAvailable {
    BOOL canOpen = NO;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1b]]) {
        canOpen = YES;
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1]]) {
        canOpen = YES;
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4]]) {
        canOpen = YES;
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v3]]) {
        canOpen = YES;
    }
    return canOpen;
}

+ (RPSTPasswordManagementAppType)availablePasswordManagementApp {
    RPSTPasswordManagementAppType pwApp = NO;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1b]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v4;
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v4;
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v4;
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v3]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v3;
    }
    return pwApp;
}

+ (NSString *)availablePasswordManagementAppDisplayName {
    NSString *name = nil;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1b]]) {
        name = @"1Password";
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1]]) {
        name = @"1Password";
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4]]) {
        name = @"1Password";
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v3]]) {
        name = @"1Password";
    }
    return name;
}

+ (NSURL *)passwordManagementAppCompleteURLForSearchQuery:(NSString *)query {
    NSURL *fullURL = nil;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1b]]) {
        NSString *baseURL = kOnePasswordURL_v4_1b;
        NSString *fullURLString = [NSString stringWithFormat:@"%@search/%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4_1]]) {
        NSString *baseURL = kOnePasswordURL_v4_1;
        NSString *fullURLString = [NSString stringWithFormat:@"%@search/%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v4]]) {
        NSString *baseURL = kOnePasswordURL_v4;
        NSString *fullURLString = [NSString stringWithFormat:@"%@search/%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    else if ([app canOpenURL:[NSURL URLWithString:kOnePasswordURL_v3]]) {
        NSString *baseURL = kOnePasswordURL_v3;
        NSString *fullURLString = [NSString stringWithFormat:@"%@%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    return fullURL;
}

@end







