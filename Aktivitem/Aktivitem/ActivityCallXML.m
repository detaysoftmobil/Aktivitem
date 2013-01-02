//
//  ActivityCallXML.m
//  Aktivitem
//
//  Created by Tahir on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityCallXML.h"
#import "UserControl.h"

@implementation ActivityCallXML
@synthesize isConnectionFinished,webData;

static NSString *getXML; 

-(NSString*)callXML:(NSString*)_personelNumber HighDate:(NSString*)_hdate LowDate:(NSString*)_ldate{
    
    
    [self getXML:_personelNumber HighDate:_hdate LowDate:_ldate];
    
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

-(void)getXML:(NSString*)_personelNumber HighDate:(NSString*)_hdate LowDate:(NSString*)_ldate{
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:sap-com:document:sap:soap:functions:mc-style\">"
                             "<soapenv:Header/>"
                             "<soapenv:Body>"
                             "<urn:_-dsl_-akF01603>"
                             "<IDateHigh>%@</IDateHigh>"
                             "<IDateLow>%@</IDateLow>"
                             "<IPersonnel>%@</IPersonnel>"
                             "</urn:_-dsl_-akF01603>"
                             "</soapenv:Body>"
                             "</soapenv:Envelope>",_hdate,_ldate,_personelNumber];
	
	NSURL *url = [NSURL URLWithString:@"http://www.detaysap.com/sap/bc/srt/rfc/dsl/ak_f016_03/100/z_dsl_ak_f016_03/dsl/ak_f016_03"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:sap-com:document:sap:soap:functions:mc-style/_-DSL_-AK_F016_03/_-dsl_-akF01603Request" forHTTPHeaderField:@"SOAPAction"];
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
//          NSLog(theXML);
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
