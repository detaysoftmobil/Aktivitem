//
//  PermissionAllListXMLParser.m
//  Aktivitem
//
//  Created by Detay on 12/3/12.
//
//

#import "PermissionAllListXMLParser.h"
#import "UserControl.h"

static PermissionAllListXMLParser *myPermissionAllListXMLParser;

@implementation PermissionAllListXMLParser
{
    NSString *responseMessage;
    PermissionStruct *tempPermission;
}

@synthesize errorMessage,PermissionStructArray;

-(void)parseXML:(NSString*)xmlDataStr {
    BOOL success;
    
    responseMessage = [[NSString alloc] init];
    currentString = [NSMutableString string];
    PermissionStructArray = [[NSMutableArray alloc]init];
    tempPermission = [[PermissionStruct alloc]init];
    saveString = NO;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:
                           [xmlDataStr dataUsingEncoding: NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    success = [parser parse];    
    currentString = nil;
    [parser release];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"ECount"] |
        [elementName isEqualToString:@"Mandt"]  |
        [elementName isEqualToString:@"Pernr"]  |
        [elementName isEqualToString:@"Begda"]  |
        [elementName isEqualToString:@"Endda"]  |
        [elementName isEqualToString:@"Beguz"]  |
        [elementName isEqualToString:@"Enduz"]  |
        [elementName isEqualToString:@"Ename"]  |
        [elementName isEqualToString:@"Iztip"]  |
        [elementName isEqualToString:@"Sure"]   |
        [elementName isEqualToString:@"Iztur"]  |
        [elementName isEqualToString:@"Odurm"]  |
        [elementName isEqualToString:@"Opernr"] |
        [elementName isEqualToString:@"Oname"]  |
        [elementName isEqualToString:@"Acik1"]  |
        [elementName isEqualToString:@"Acik2"]  |
        [elementName isEqualToString:@"Acik3"]        |
        [elementName isEqualToString:@"Acik4"]        |
        [elementName isEqualToString:@"Acik5"]        |
        [elementName isEqualToString:@"Aciklama"]     |
        [elementName isEqualToString:@"TlpYapan"]     |
        [elementName isEqualToString:@"TlpTrh"]       |
        [elementName isEqualToString:@"Application"]  |
        [elementName isEqualToString:@"Acik5"]        |
        [elementName isEqualToString:@"Rednedeni"]    
        )
    {
        [currentString setString:@""];
        saveString = YES;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (saveString)
        [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{    
    if ([elementName isEqualToString:@"ECount"]) {
        tempPermission.ECount = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Mandt"]) {
        tempPermission.Mandt = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Pernr"]) {
        tempPermission.Pernr = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Begda"]) {
        tempPermission.Begda = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Endda"]) {
        tempPermission.Endda = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Beguz"]) {
        tempPermission.Beguz = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Enduz"]) {
        tempPermission.Enduz = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Ename"]) {
        tempPermission.Ename = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Iztip"]) {
        tempPermission.Iztip = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Iztur"]) {
        tempPermission.Iztur = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Odurm"]) {        
        tempPermission.Odurm = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Opernr"]) {
        tempPermission.Opernr = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Oname"]) {
        tempPermission.Oname = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Acik1"]) {
        tempPermission.Acik1 = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Acik2"]) {
        tempPermission.Acik2 = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Acik3"]) {
        tempPermission.Acik3 = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Acik4"]) {
        tempPermission.Acik4 = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Acik5"]) {
        tempPermission.Acik5 = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Aciklama"]) {
        tempPermission.Aciklama = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"TlpYapan"]) {
        tempPermission.TlpYapan = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"TlpTrh"]) {
        tempPermission.TlpTrh = [[NSString alloc]initWithString:currentString];
        [PermissionStructArray addObject:tempPermission];
        tempPermission = [[PermissionStruct alloc]init];
        PermissionStruct *s = [PermissionStructArray objectAtIndex:0];
        NSLog(@"COjnt : %@",s.Odurm);
    }
    if ([elementName isEqualToString:@"Application"]) {
        tempPermission.Application = [[NSString alloc]initWithString:currentString];
    }
    if ([elementName isEqualToString:@"Rednedeni"]) {
        tempPermission.Rednedeni = [[NSString alloc]initWithString:currentString];
    }
}

#pragma mark -instance
+(PermissionAllListXMLParser*)getPermissionAllListXMLParser{
    if (!myPermissionAllListXMLParser) {
        myPermissionAllListXMLParser =[[super allocWithZone:NULL]init];
    }
    return myPermissionAllListXMLParser;
}

@end
