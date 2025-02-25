#import "CustomURLProtocol.h"

static NSString * const URLProtocolHandledKey = @"URLProtocolHandledKey";

@interface CustomURLProtocol () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation CustomURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString *requestURLString = request.URL.absoluteString;
    
    if ([requestURLString rangeOfString:@"browse.geekbench.ca"].location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    // Create a new request based on the original request
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    NSString *requestURLString = mutableRequest.URL.absoluteString;
    
    // Replace "dv6-storefront-p6bootstrap.js" with "browser.primatelabs.com"
    requestURLString = [requestURLString stringByReplacingOccurrencesOfString:@"browse.geekbench.ca" withString:@"browser.primatelabs.com"];
    
    mutableRequest.URL = [NSURL URLWithString:requestURLString];

    // Prevent infinite loops by marking this request as handled
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableRequest];

    // Create a connection with the modified request
    self.connection = [NSURLConnection connectionWithRequest:mutableRequest delegate:self];
}

- (void)stopLoading {
    [self.connection cancel];
}

- (void)passThroughRequest:(NSURLRequest *)request {
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

@end
