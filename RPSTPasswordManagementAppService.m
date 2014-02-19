//
//  RPPasswordManagementAppService.h
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

@implementation RPSTPasswordManagementAppService

#pragma mark - Constants

// Search Schemes
NSString * const RPSTOnePasswordSearch_v3 = @"onepassword3://";
NSString * const RPSTOnePasswordSearch_v4 = @"onepassword4://";
NSString * const RPSTOnePasswordSearch_v4_1 = @"onepassword://";
NSString * const RPSTOnePasswordSearch_v4_1b = @"onepasswordb://";

// Web View Schemes
NSString * const RPSTOnePasswordOpenWebURLHTTP = @"ophttp://";
NSString * const RPSTOnePasswordOpenWebURLHTTPS = @"ophttps://";

#pragma mark - Checking Availability

+ (BOOL)passwordManagementAppIsAvailable {
    BOOL canOpen = NO;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1b]]) {
        canOpen = YES;
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1]]) {
        canOpen = YES;
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4]]) {
        canOpen = YES;
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v3]]) {
        canOpen = YES;
    }
    return canOpen;
}

+ (RPSTPasswordManagementAppType)availablePasswordManagementApp {
    RPSTPasswordManagementAppType pwApp = NO;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1b]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v4_1;
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v4_1;
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v4;
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v3]]) {
        pwApp = RPSTPasswordManagementAppType1Password_v3;
    }
    return pwApp;
}

+ (NSString *)availablePasswordManagementAppDisplayName {
    NSString *name = nil;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1b]]) {
        name = @"1Password";
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1]]) {
        name = @"1Password";
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4]]) {
        name = @"1Password";
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v3]]) {
        name = @"1Password";
    }
    return name;
}

#pragma mark - Searching Entries

+ (NSURL *)passwordManagementAppCompleteURLForSearchQuery:(NSString *)query {
    NSURL *fullURL = nil;
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1b]]) {
        NSString *baseURL = RPSTOnePasswordSearch_v4_1b;
        NSString *fullURLString = [NSString stringWithFormat:@"%@search/%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4_1]]) {
        NSString *baseURL = RPSTOnePasswordSearch_v4_1;
        NSString *fullURLString = [NSString stringWithFormat:@"%@search/%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v4]]) {
        NSString *baseURL = RPSTOnePasswordSearch_v4;
        NSString *fullURLString = [NSString stringWithFormat:@"%@search/%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    else if ([app canOpenURL:[NSURL URLWithString:RPSTOnePasswordSearch_v3]]) {
        NSString *baseURL = RPSTOnePasswordSearch_v3;
        NSString *fullURLString = [NSString stringWithFormat:@"%@%@", baseURL, query];
        fullURL = [NSURL URLWithString:fullURLString];
    }
    return fullURL;
}

#pragma mark - Open Web Views

+ (BOOL)passwordManagementAppSupportsOpenWebView {
	RPSTPasswordManagementAppType availableAppType = [RPSTPasswordManagementAppService availablePasswordManagementApp];
	BOOL supportsWebViews;
	switch (availableAppType) {
		case RPSTPasswordManagementAppType1Password_v4_1: {
			supportsWebViews = YES;
		} break;
		case RPSTPasswordManagementAppType1Password_v4:
		case RPSTPasswordManagementAppType1Password_v3: {
			supportsWebViews = NO;
		} break;
		default: {
			supportsWebViews = NO;
		} break;
	}
	return supportsWebViews;
}

+ (NSURL *)passwordManagementAppCompleteURLForOpenWebViewHTTP:(NSString *)urlString {
	return [RPSTPasswordManagementAppService
			rpst_passwordManagementAppCompleteURLForOpenWebViewWithScheme:RPSTOnePasswordOpenWebURLHTTP
			urlString:urlString];
}

+ (NSURL *)passwordManagementAppCompleteURLForOpenWebViewHTTPS:(NSString *)urlString {
	return [RPSTPasswordManagementAppService
			rpst_passwordManagementAppCompleteURLForOpenWebViewWithScheme:RPSTOnePasswordOpenWebURLHTTPS
			urlString:urlString];
}

+ (NSURL *)rpst_passwordManagementAppCompleteURLForOpenWebViewWithScheme:(NSString *)scheme
															   urlString:(NSString *)urlString {
    NSURL *fullURL = nil;
    UIApplication *app = [UIApplication sharedApplication];
	
    if ([app canOpenURL:[NSURL URLWithString:scheme]]) {
		
        NSString *correctedURLString = nil;
        NSRange rangeOfSchemeSeparator;
		
        rangeOfSchemeSeparator = [urlString rangeOfString:@"://"];
		
        if (rangeOfSchemeSeparator.location != NSNotFound) {
            // Remove the scheme and the :// from the string
            NSArray *components = [urlString componentsSeparatedByString:@"://"];
            if (components.count == 2) {
                correctedURLString = [components objectAtIndex:1];
            } else {
                NSLog(@"RPSTPasswordManagementAppService: invalid URL string argument. Contains multiple :// separators.");
            }
        } else {
            correctedURLString = urlString;
        }
		
        if (correctedURLString.length > 0) {
            NSString *finalURLString = [NSString stringWithFormat:@"%@%@", scheme, correctedURLString];
            fullURL = [NSURL URLWithString:finalURLString];
        }
    }
    return fullURL;
}

@end

















