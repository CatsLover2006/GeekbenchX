#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <substrate.h>

%hook NSURLRequest

- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
    // Check if the URL host is "browse.geekbench.ca" and redirect to "browser.primatelabs.com"
    if ([[URL host] isEqualToString:@"browse.geekbench.ca"]) {
        NSString *newURLString = [[URL absoluteString] stringByReplacingOccurrencesOfString:@"browse.geekbench.ca" withString:@"browser.primatelabs.com"];
        NSURL *newURL = [NSURL URLWithString:newURLString];
        return %orig(newURL, cachePolicy, timeoutInterval);
    }
    return %orig(URL, cachePolicy, timeoutInterval);
}

%end
