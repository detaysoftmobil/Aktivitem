//
//  FavoriteCallXML.m
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteCallXML.h"
#import "UserControl.h"

@implementation FavoriteCallXML
@synthesize webData,isConnectionFinished;

static NSString *getXML; 


-(NSString*)callXML:(NSString*)_personelNumber Date:(NSString*)_date{
    
    
    [self getXML:_personelNumber Date:_date];

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

-(void)getXML:(NSString*)_personelNumber Date:(NSString*)_date{
    
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:sap-com:document:sap:soap:functions:mc-style\">"
                             "<soapenv:Header/>"
                             "<soapenv:Body>"
                             "<urn:_-dsl_-akF01601>"
                             "<IDate>%@</IDate>"
                             "<IPersonnel>%@</IPersonnel>"
                             "</urn:_-dsl_-akF01601>"
                             "</soapenv:Body>"
                             "</soapenv:Envelope>",_date,_personelNumber];
	
	NSURL *url = [NSURL URLWithString:@"http://www.detaysap.com/sap/bc/srt/rfc/dsl/ak_f016_01/100/zdsl_ak_f016_01/dsl/ak_f016_01"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:sap-com:document:sap:soap:functions:mc-style/_-DSL_-AK_F016_01/_-dsl_-akF01601Request" forHTTPHeaderField:@"SOAPAction"];
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
		NSLog(@"Connection is NULL");
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
	NSLog(@"ERROR with Connection");
    isConnectionFinished = YES;
    
	[connection release];
	[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
    NSString *theXML = [[NSString alloc] 
                        initWithBytes: [webData mutableBytes] 
                        length:[webData length] 
                        encoding:NSUTF8StringEncoding];
    
    isConnectionFinished = YES;
       NSLog(theXML);
    getXML = [[NSString alloc] initWithString:theXML];
    [theXML release];   
	[connection release];
	[webData release];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"Authetication");
    NSInteger count = [challenge previousFailureCount];
    
    if(count >= 2){
        [connection release];
        /* UIAlertView *alert = [[ UIAlertView alloc ] initWithTitle:@"Error" message:@"Please check username & password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
         [alert release]; */
    } else {
        
        NSString *uName = [UserControl getUsername];
        NSString *password = [UserControl getPassword];
        
        NSURLCredential* credential = [NSURLCredential credentialWithUser:uName password:password persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        //  [credential release];
    }
}




@end
