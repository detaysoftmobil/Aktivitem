//
//  PermissionCreateViewController.m
//  Aktivitem
//
//  Created by Detay on 11/28/12.
//
//

#import "PermissionCreateViewController.h"
#import "PermissionStruct.h"
#import "UserControl.h"
#import "CreatePermissionCallXML.h"
#import "CheckConnection.h"
#import "CreatePermissionXMLParser.h"
#import "PermissionAllListViewController.h"

#define PERMISSION_TYPE  1
#define PERMISSION_STYLE 2
#define PERMISSION_BEGDA_DATE 3
#define PERMISSION_ENDDA_DATE 4

@interface PermissionCreateViewController ()
{
    int permissionType;

    NSDate *strBegdaDate,
           *strEndDaDate;
    
    PermissionStruct *myPermissionStruct;
}
@end

@implementation PermissionCreateViewController

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"İzin Talep";
        
        txtselectionIDArray = [[NSMutableArray alloc] init];
        txtselectionArray   = [[NSMutableArray alloc] init];

        strBegdaDate = [[NSDate alloc]init];
        strEndDaDate = [[NSDate alloc]init];
        
        myPermissionStruct = [[PermissionStruct alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self defaultValues];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark private methods
-(void)allArrayRemoveObjects {
    [txtselectionArray removeAllObjects];
    [txtselectionIDArray removeAllObjects];
}

-(void)textFieldsSetBackgroundColor{
    txtPermissionStyle.backgroundColor = [UIColor whiteColor];
    txtPermissionType.backgroundColor = [UIColor whiteColor];
    txtBegdaDate.backgroundColor = [UIColor whiteColor];
    txtEnddaDate.backgroundColor = [UIColor whiteColor];
}

-(void)defaultValues {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Kaydet" style:UIBarButtonItemStylePlain target:self action:@selector(permissionSave:)];    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    scrollView.contentSize = CGSizeMake(0, 670);
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

#pragma mark buttons Actions
-(IBAction)permissionSave:(id)sender{
    
    if (![CheckConnection internetConnection])
        return;
    
    myPermissionStruct.Pernr = [UserControl getPernr];
    myPermissionStruct.Aciklama = textViewAciklama.text;
    
    myPermissionStruct.Endda = myPermissionStruct.Begda;
    
    if ([myPermissionStruct.Iztip rangeOfString:@"#"].location != NSNotFound) {
        NSArray *testArray = [myPermissionStruct.Iztip componentsSeparatedByString:@"#"];
        myPermissionStruct.Iztip = [testArray objectAtIndex:0];
        myPermissionStruct.IzinSaat = [testArray objectAtIndex:1];
    }
    
    CreatePermissionCallXML *myCreatePermissionCall = [[CreatePermissionCallXML alloc]init];
    NSString *resultXML = [myCreatePermissionCall callXML:myPermissionStruct];
    resultXML = [[CreatePermissionXMLParser getCreatePermissionXMLParser]parseXML:resultXML];

    if ([resultXML isEqualToString:@""]) {
        [[[UIAlertView alloc]initWithTitle:@""
                                   message:@"İzin talebiniz oluşturuldu"
                                  delegate:nil
                         cancelButtonTitle:@"tamam"
                         otherButtonTitles:nil,nil]show];
        
        [[PermissionAllListViewController getPermissionAllListViewController] setPermissionCreateStatus:@"S"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[[UIAlertView alloc]initWithTitle:@""
                                   message:resultXML
                                  delegate:nil
                         cancelButtonTitle:@"tamam"
                         otherButtonTitles:nil,nil]show];
    }
}

#pragma mark txts Actions
-(IBAction)permissionTypeSelection:(id)sender{
    permissionType = PERMISSION_TYPE;
    [sender resignFirstResponder];
    [self allArrayRemoveObjects];
    
    [txtselectionIDArray addObject:@"01"];
    [txtselectionArray addObject:@"Günlük"];

    [txtselectionIDArray addObject:@"02#01"];
    [txtselectionArray addObject:@"Saatlik (09:00-14:00)"];

    [txtselectionIDArray addObject:@"02#02"];
    [txtselectionArray addObject:@"Saatlik (14:00-18:00)"];
    [pickerView reloadAllComponents];
    
    if ([txtPermissionType.text isEqualToString:@""]) {
        myPermissionStruct.Iztip = @"01";
         txtPermissionType.text = @"Günlük";
    }
}

-(IBAction)permissionStyleSelection:(id)sender{
    permissionType = PERMISSION_STYLE;
    [sender resignFirstResponder];
    [self allArrayRemoveObjects];
    
    [txtselectionIDArray addObject:@"5031"];
    [txtselectionArray addObject:@"Yıllık İzni"];
    
    [txtselectionIDArray addObject:@"5110"];
    [txtselectionArray addObject:@"Mazeret İzni"];
    
    [txtselectionIDArray addObject:@"5120"];
    [txtselectionArray addObject:@"Hastalık İzni"];
    
    [txtselectionIDArray addObject:@"5130"];
    [txtselectionArray addObject:@"Doğum İzni"];
    
    [txtselectionIDArray addObject:@"5140"];
    [txtselectionArray addObject:@"Ölüm İzni"];
    
    [txtselectionIDArray addObject:@"5150"];
    [txtselectionArray addObject:@"Evlilik İzni"];
    
    [txtselectionIDArray addObject:@"5160"];
    [txtselectionArray addObject:@"Süt İzni"];
    
    [txtselectionIDArray addObject:@"5501"];
    [txtselectionArray addObject:@"Ücretsiz İzin G.."];

    [pickerView reloadAllComponents];
    if ([txtPermissionStyle.text isEqualToString:@""]) {
        myPermissionStruct.Iztur = @"5031";
        txtPermissionStyle.text = @"Yıllık İzni";
    }
}
-(IBAction)permissionBegdaDate:(id)sender{
    permissionType = PERMISSION_BEGDA_DATE;
    [sender resignFirstResponder];
    [pickerView setHidden:YES];
    if ([txtBegdaDate.text isEqualToString:@""]) {
         [self datePickerSetValue:nil];
    }
}

-(IBAction)permissionEnddaDate:(id)sender{
    permissionType = PERMISSION_ENDDA_DATE;
    [sender resignFirstResponder];
    [pickerView setHidden:YES];
    
    if ([txtEnddaDate.text isEqualToString:@""]) {
        [self datePickerSetValue:nil];
    }
}

#pragma mark -datepicker delegate
-(IBAction)datePickerSetValue:(id)sender {
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"dd-MM-YYYY"];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    switch (permissionType) {
        case PERMISSION_BEGDA_DATE:
            strBegdaDate = [[datePickerView date] retain];
            txtBegdaDate.text = [dateformat stringFromDate:[datePickerView date]];
            
            //WebServise göndderileceğinden dolayı
            [dateformat setDateFormat:@"YYYY-MM-dd"];
            myPermissionStruct.Begda = [dateformat stringFromDate:[datePickerView date]];
            break;
        case PERMISSION_ENDDA_DATE:
            strEndDaDate = [[datePickerView date] retain];
            txtEnddaDate.text = [dateformat stringFromDate:[datePickerView date]];
            
            //WebServise göndderileceğinden dolayı
            [dateformat setDateFormat:@"YYYY-MM-dd"];
            myPermissionStruct.Endda = [dateformat stringFromDate:[datePickerView date]];
            break;
        default:
            break;
    }
}

-(IBAction)btnDateDistance:(id)sender {
    @try {
        if (txtBegdaDate.text.length == 0 || txtEnddaDate.text.length == 0 ) {
            return;
        }
        NSLog(@"*********************************");
        NSLog(@"strBegdaDate :\n %@\n",strBegdaDate);
        NSLog(@"strEndDaDate :\n %@\n",strEndDaDate);
        
        int result  = [self daysBetweenDate:strBegdaDate andDate:strEndDaDate];
        
        if (result < 0) {
            [[[UIAlertView alloc]initWithTitle:@"" message:@"Tarihleri kontrol edin.." delegate:nil cancelButtonTitle:@"tamam" otherButtonTitles:nil,nil]show];
            txtResultDate.text = @"0";
        }
        else if(result >= 0){
            result += 1;
            txtResultDate.text = [NSString stringWithFormat:@"%d",result];
        }
        
        [txtResultDate resignFirstResponder];
    }
    @catch (NSException *exception) {
        NSLog(@"Hata : %@",[exception description]);
    }
}

#pragma mark textField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self textFieldsSetBackgroundColor];
    
    if ([textField isEqual:txtPermissionType]) {
        textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        [pickerView setHidden:NO];
        [datePickerView setHidden:YES];
    }
    if ([textField isEqual:txtPermissionStyle]) {
        textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        [pickerView setHidden:NO];
        [datePickerView setHidden:YES];
    }
    if ([textField isEqual:txtBegdaDate]) {
        textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        [pickerView setHidden:YES];
        [datePickerView setHidden:NO];
    }
    if ([textField isEqual:txtEnddaDate]) {
        textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        [pickerView setHidden:YES];
        [datePickerView setHidden:NO];
    }
}

#pragma mark textView Delegate
- (void)textViewDidBeginEditing:(UITextField *)textField
{
    [self textFieldsSetBackgroundColor];
    datePickerView.hidden = YES;
    pickerView.hidden =YES;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.2];
    scrollView.frame = CGRectMake(0,-200,320,670);
    [scrollView scrollRectToVisible:textField.frame animated:YES];
    [UIView commitAnimations];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        scrollView.frame = CGRectMake(0,0,320,420);
    }
    return YES;
}

#pragma mark pickerView datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [txtselectionArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [txtselectionArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (permissionType) {
        case PERMISSION_TYPE:
            if (row) {
                lblBitisTarihi.hidden = YES;
                lblKulGunSayisi.hidden = YES;
                txtEnddaDate.hidden = YES;
                txtResultDate.hidden = YES;
                
                txtPermissionStyle.frame = CGRectMake(7, 137, 306, 31);
                textViewAciklama.frame = CGRectMake(0, 190, 320,216);
                lblIzinTuru.frame = CGRectMake(10, 115, 76, 21);
                lblAciklama.frame = CGRectMake(10, 167, 85, 21);
            }else{
                lblBitisTarihi.hidden = NO;
                lblKulGunSayisi.hidden = NO;
                txtEnddaDate.hidden = NO;
                txtResultDate.hidden = NO;
                
                txtPermissionStyle.frame = CGRectMake(7, 245, 306, 31);
                textViewAciklama.frame = CGRectMake(0, 295, 320,216);
                lblIzinTuru.frame = CGRectMake(10, 224, 76, 21);
                lblAciklama.frame = CGRectMake(10, 273, 85, 21);
            }
            
            NSLog(@"PERMISSION_TYPE_ID : %@",[txtselectionIDArray objectAtIndex:row]);
            txtPermissionType.text  = [txtselectionArray objectAtIndex:row];
            myPermissionStruct.Iztip = [txtselectionIDArray objectAtIndex:row];
            
            break;
        case PERMISSION_STYLE:
            NSLog(@"PERMISSION_STYLE_ID : %@",[txtselectionIDArray objectAtIndex:row]);
            txtPermissionStyle.text  = [txtselectionArray objectAtIndex:row];
            myPermissionStruct.Iztur = [txtselectionIDArray objectAtIndex:row];
            break;
        default:
            break;
    }
}

- (IBAction)backgroundTouch:(id)sender {
    [textViewAciklama resignFirstResponder];
    [txtResultDate resignFirstResponder];

    if (datePickerView.isHidden == NO) {
        [datePickerView setHidden:YES];
    }
    if (pickerView.isHidden == NO) {
        [pickerView setHidden:YES];
    }
    scrollView.frame = CGRectMake(0,0,320,420);
}

@end
