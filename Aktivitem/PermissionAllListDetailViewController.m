//
//  PermissionAllListDetailViewController.m
//  Aktivitem
//
//  Created by Detay on 12/3/12.
//
//

#import "PermissionAllListDetailViewController.h"
#import "OnayRedPermissionCallXML.h"
#import "CreatePermissionXMLParser.h"

@interface PermissionAllListDetailViewController ()
{
    NSMutableArray *array;
}
@end

@implementation PermissionAllListDetailViewController

@synthesize selectedPermission,btnOnayla,btnRed,ustBirimKontrol;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Detay";
        array = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [array addObject:[self getPermissionType:selectedPermission.Iztip]];
    [array addObject:[self getPermissionStyle:selectedPermission.Iztur]];
    [array addObject:[self getStringToDateFormatter:selectedPermission.Begda]];
    
    if ([selectedPermission.Iztip isEqualToString:@"01"]) {
        [array addObject:[self getStringToDateFormatter:selectedPermission.Endda]];
        [array addObject:[self getResultDate]];
    }else{
        [array addObject:selectedPermission.Beguz];
        [array addObject:selectedPermission.Enduz];
    }
    [array addObject:selectedPermission.Aciklama];
    
    if (ustBirimKontrol) {
        btnOnayla.hidden = NO;
        btnRed.hidden = NO;
    }else{
        btnOnayla.hidden = YES;
        btnRed.hidden = YES;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - private method
-(NSString*)getPermissionType:(NSString*)_obj{
    if ([_obj isEqualToString:@"01"]) {
        return @"Günlük";
    }
    else if([_obj isEqualToString:@"02"]) {
        return @"Saatlik";
    }
    return @"";
}

-(NSString*)getPermissionStyle:(NSString*)_obj{
    
    if ([_obj isEqualToString:@"5031"]) {
        return @"Yıllık İzni";
    }
    else if ([_obj isEqualToString:@"5110"]) {
        return @"Mazeret İzni";
    }
    else if ([_obj isEqualToString:@"5120"]) {
        return @"Hastalık İzni";
    }
    else if ([_obj isEqualToString:@"5130"]) {
        return @"Doğum İzni";
    }
    else if ([_obj isEqualToString:@"5140"]) {
        return @"Ölüm İzni";
    }
    else if ([_obj isEqualToString:@"5150"]) {
        return @"Evlilik İzni";
    }
    else if ([_obj isEqualToString:@"5160"]) {
        return @"Süt İzni";
    }
    else if ([_obj isEqualToString:@"5501"]) {
        return @"Ücretsiz İzin G..";
    }
    return @"";
}

-(NSString*)getStringToDateFormatter:(NSString*)_obj{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *strBegdaDate = [df dateFromString:_obj];
    
    [df setDateFormat:@"dd-MM-YYYY"];
    
    return [df stringFromDate:strBegdaDate];
}

-(NSString*)getResultDate{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *strBegdaDate = [df dateFromString:selectedPermission.Begda];
    NSDate *strEndDaDate = [df dateFromString:selectedPermission.Endda];
    
    int result  = [self daysBetweenDate:strBegdaDate andDate:strEndDaDate];
    result++;
    return [NSString stringWithFormat:@"%d",result];
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}
#pragma mark - tableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == [array count] - 1 ? 88.0 : 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.row == 5) {
        UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(110, 12, 180, 60)];
        [tv setScrollEnabled:YES];
        [tv setText:[array objectAtIndex:indexPath.row]];
        [tv setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:tv];
    }else{
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(100, 12, 180, 20)];
        [lbl setFont:[UIFont fontWithName:@"Arial" size:14]];
        [lbl setText:[NSString stringWithFormat:@" :   %@",[array objectAtIndex:indexPath.row]]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
    }
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(30, 12, 180, 20)];
    [lbl setFont:[UIFont boldSystemFontOfSize:13]];
    [lbl setText:[NSString stringWithFormat:@" : %@",[array objectAtIndex:indexPath.row]]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:lbl];
    
    
    if ([selectedPermission.Iztip isEqualToString:@"01"]) {
        switch (indexPath.row) {
            case 0:
                lbl.text = [NSString stringWithFormat:@"İzin Tipi"];
                break;
            case 1:
                lbl.text  = [NSString stringWithFormat:@"İzin Türü"];
                break;
            case 2:
                lbl.text  = [NSString stringWithFormat:@"Baş.Tarihi"];
                break;
            case 3:
                lbl.text  = [NSString stringWithFormat:@"Bit.Tarihi"];
                break;
            case 4:
                lbl.text  = [NSString stringWithFormat:@"Gün Sayısı"];
                break;
            case 5:
                lbl.text  = [NSString stringWithFormat:@"Açıklama"];
                break;
            default:
                break;
        }

    }else{
        switch (indexPath.row) {
            case 0:
                lbl.text = [NSString stringWithFormat:@"İzin Tipi"];
                break;
            case 1:
                lbl.text  = [NSString stringWithFormat:@"İzin Türü"];
                break;
            case 2:
                lbl.text  = [NSString stringWithFormat:@"Baş.Tarihi"];
                break;
            case 3:
                lbl.text  = [NSString stringWithFormat:@"Baş.Saati"];
                break;
            case 4:
                lbl.text  = [NSString stringWithFormat:@"Bit.Saati"];
                break;
            case 5:
                lbl.text  = [NSString stringWithFormat:@"Açıklama"];
                break;
            default:
                break;
        }
    }
    
    
    return cell;
}

#pragma mark - button actions
-(IBAction)btnOnayla:(id)sender{
    [self showMessage:@"Onaylamak istediğinizden emin misiniz ?":1];
}
-(IBAction)btnRed:(id)sender {
    [self showMessage:@"Reddetmek istediğinizden emin misiniz ?":2];
}

-(void)showMessage:(NSString*)_mes:(int)tag{
    UIAlertView *a=[[UIAlertView alloc]initWithTitle:@"" message:_mes delegate:self cancelButtonTitle:@"Hayır" otherButtonTitles:@"Evet",nil];
    [a setTag:tag];
    [a show];
}

#pragma mark - alertview actions

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            [self OnayRedPermission:@"02"];
        }
    }else if(alertView.tag == 2){
        if (buttonIndex == 1) {
            [self OnayRedPermission:@"03"];
        }
    }
}

-(void)OnayRedPermission:(NSString*)_Odurm{
    OnayRedPermissionCallXML *xmlCall = [[OnayRedPermissionCallXML alloc]init];
    selectedPermission.Odurm = _Odurm;
    NSString *resultXML = [xmlCall callXML:selectedPermission];
    resultXML = [[CreatePermissionXMLParser getCreatePermissionXMLParser]parseXML:resultXML];
    
    [[[UIAlertView alloc]initWithTitle:@"" message:resultXML delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles:nil,nil]show];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
