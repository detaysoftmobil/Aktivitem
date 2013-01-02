//
//  PhoneListCallXML.m
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhoneListCallXML.h"
#import "UserControl.h"

@implementation PhoneListCallXML{
     NSString *getXML;
}
@synthesize webData,isConnectionFinished;

-(NSString*)callXML{
    
    getXML = [[NSString alloc] init];
    [self getXML];
    
    while (isConnectionFinished == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    }
    
    if (getXML == Nil) {
        NSLog(@"Couldn't get the XML");
    }
    else
    {
        return getXML;
    }
    
    return nil;
}

-(void)getXML{
    
    
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:sap-com:document:sap:soap:functions:mc-style\">"
                             "<soapenv:Header/>"
                             "<soapenv:Body>"
                             "<urn:_-dsl_-akF01608/>"
                             "</soapenv:Body>"
                             "</soapenv:Envelope>"];
	
    //    NSLog(@"%@",soapMessage);
	NSURL *url = [NSURL URLWithString:@"http://www.detaysap.com/sap/bc/srt/rfc/dsl/ak_f016_08/100/z_dsl_ak_f016_08/dsl/ak_f016_08"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:sap-com:document:sap:soap:functions:mc-style/_-DSL_-AK_F016_08/_-dsl_-akF01608Request" forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
//		NSLog(@"Connection is NULL");
	}
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//	NSLog(@"ERROR with Connection");
    isConnectionFinished = YES;
    
	[connection release];
	[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//	NSLog(@"DONE. Received Bytes: %d", [webData length]);
    NSString *theXML = [[NSString alloc] 
                        initWithBytes: [webData mutableBytes] 
                        length:[webData length] 
                        encoding:NSUTF8StringEncoding];
    
    isConnectionFinished = YES;
 //       NSLog(theXML);
    getXML = [[NSString alloc] initWithString:theXML];
    [theXML release];   
	[connection release];
	[webData release];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"Authetication");
    NSInteger count = [challenge previousFailureCount];
    
    if(count >= 2){
        getXML = @"AuthEr";
        isConnectionFinished = YES;
    } else {
        
        NSString *uName = [UserControl getUsername];
        NSString *password = [UserControl getPassword];
        
        NSURLCredential* credential = [NSURLCredential credentialWithUser:uName password:password persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        //  [credential release];
    }
}

@end
