//
//  OnayRedPermissionCallXML.m
//  Aktivitem
//
//  Created by Detay on 12/19/12.
//
//

#import "OnayRedPermissionCallXML.h"
#import "PermissionStruct.h"
#import "UserControl.h"


@implementation OnayRedPermissionCallXML
{
    NSString *getXML;
}
@synthesize webData,isConnectionFinished;

-(NSString*)callXML:(PermissionStruct*)_permission{
    getXML = [[NSString alloc] init];
    [self getXML:_permission];
    
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
-(void)getXML:(PermissionStruct*)_permission {
    NSString *soapMessage =[NSString stringWithFormat:
                            @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:sap-com:document:sap:soap:functions:mc-style\">"
                            "<soapenv:Header/>"
                                "<soapenv:Body>"
                                    "<urn:_-dsl_-izinF00102>"
                                        "<IUname></IUname>"
                                        "<LsT001>"
                                            "<Mandt></Mandt>"
                                            "<Pernr>%@</Pernr>"
                                            "<Begda>%@</Begda>"
                                            "<Endda></Endda>"
                                            "<Beguz></Beguz>"
                                            "<Enduz></Enduz>"
                                            "<Ename></Ename>"
                                            "<Iztip></Iztip>"
                                            "<Sure></Sure>"
                                            "<Iztur></Iztur>"
                                            "<Odurm>%@</Odurm>"
                                            "<Opernr></Opernr>"
                                            "<Oname></Oname>"
                                            "<Acik1></Acik1>"
                                            "<Acik2></Acik2>"
                                            "<Acik3></Acik3>"
                                            "<Acik4></Acik4>"
                                            "<Acik5></Acik5>"
                                            "<Aciklama></Aciklama>"
                                            "<TlpYapan></TlpYapan>"
                                            "<TlpTrh></TlpTrh>"
                                            "<Application></Application>"
                                            "<Rednedeni></Rednedeni>"
                                        "</LsT001>"
                                    "<Odurm></Odurm>"
                                        "<ReturnT>"
                                        "<item>"
                                            "<Messageid></Messageid>"
                                            "<Message></Message>"
                                        "</item>"
                                    "</ReturnT>"
                                "</urn:_-dsl_-izinF00102>"
                            "</soapenv:Body>"
                            "</soapenv:Envelope>",
                            _permission.Pernr,
                            _permission.Begda,
                            _permission.Odurm];
    
    NSLog(@"%@",soapMessage);
	NSURL *url = [NSURL URLWithString:@"http://dtyqrt.detay.com:8005/sap/bc/srt/rfc/dsl/izin_f001_02/100/izin_f001_02/izin_f001_02"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
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
    NSLog(@"%@ : ",theXML);
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
    } else {
        NSString *uName = [UserControl getUsername];
        NSString *password = [UserControl getPassword];
        NSURLCredential* credential = [NSURLCredential credentialWithUser:uName password:password persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }
}
@end
