//
//  CreateActivityCallXML.m
//  Aktivitem
//
//  Created by Tahir on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateActivityCallXML.h"
#import "Activity.h"
#import "UserControl.h"

@implementation CreateActivityCallXML{
    NSString *getXML;
}
@synthesize webData,isConnectionFinished;

-(NSString*)callXML:(ActivityInfo*)_activity{
    
    getXML = [[NSString alloc] init];
    [self getXML:_activity];
    
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
-(void)getXML:(ActivityInfo*)_activity{
    
 
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:sap-com:document:sap:soap:functions:mc-style\">"
                             "<soapenv:Header/>"
                             "<soapenv:Body>"
                             "<urn:_-dsl_-akF01605>"
                             "<IActivity>"
                             "<Pernr>%@</Pernr>"
                             "<Begda>%@</Begda>"
                             "<Seqno>%@</Seqno>"
                             "<Kunnr>%@</Kunnr>"
                             "<Prjno>%@</Prjno>"
                             "<Wrhour>%@</Wrhour>"
                             "<Akhour>%@</Akhour>"
                             "<Place>%@</Place>"
                             "<Arfno></Arfno>"
                             "<Txt01>%@</Txt01>"
                             "<Txt02>%@</Txt02>"
                             "<Txt03>%@</Txt03>"
                             "<Txt04>%@</Txt04>"
                             "<Txt05>%@</Txt05>"
                             "<Status></Status>"
                             "<Stat2></Stat2>"
                             "<Stat3></Stat3>"
                             "<Stat4></Stat4>"
                             "<Stat5></Stat5>"
                             "<Locno>%@</Locno>"
                             "<CustomerName>%@</CustomerName>"
                             "<ProjectName>%@</ProjectName>"
                             "<Inptp>%@</Inptp>"
                             "</IActivity>"
                             
                             "<IMode>%@</IMode>"
                             "</urn:_-dsl_-akF01605>"
                             "</soapenv:Body>"
                             "</soapenv:Envelope>",_activity.Pernr,_activity.Begda,_activity.Seqno,_activity.Kunnr,_activity.Prjno,_activity.Wrhour,_activity.Akhour,_activity.Place,_activity.Txt01,_activity.Txt02,_activity.Txt03,_activity.Txt04,_activity.Txt05,_activity.Locno,_activity.CustomerName,_activity.ProjectName,_activity.Stat4,_activity.Stat5];
	
    NSLog(@"%@",soapMessage);
	NSURL *url = [NSURL URLWithString:@"http://www.detaysap.com/sap/bc/srt/rfc/dsl/ak_f016_05/100/z_dsl_ak_f016_05/dsl/ak_f016_05"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:sap-com:document:sap:soap:functions:mc-style/_-DSL_-AK_F016_05/_-dsl_-akF01605Request" forHTTPHeaderField:@"SOAPAction"];
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
   //         NSLog(theXML);
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
