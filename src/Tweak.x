#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <substrate.h>
#import <CustomURLProtocol.h>

%hook ISURLOperation

-(BOOL)_runRequestWithURL:(NSURL*)URL {
    NSString *origURL = [URL absoluteString];
    NSString *urlString = origURL;

    if ([urlString rangeOfString:@"browse.geekbench.ca"].location != NSNotFound) {
        NSLog(@"Attempting to replace browse.geekbench.ca");
        urlString = [urlString stringByReplacingOccurrencesOfString:@"browse.geekbench.ca" withString:@"browser.primatelabs.com"];
    }

    NSURL *newURL = [NSURL URLWithString:urlString];
    return %orig(newURL);
}

%end

%hook ISCertificate

-(BOOL)checkData:(id)arg1 againstSignature:(id)arg2 {
    return YES;
}

%end

%hook NSURLRequest

static void RegisterCustomURLProtocol() {
    [NSURLProtocol registerClass:[CustomURLProtocol class]];
}

__attribute__((constructor))
static void init_hook() {
    RegisterCustomURLProtocol();
}

%end
