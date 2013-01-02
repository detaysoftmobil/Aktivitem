//
//  AktiviteOlusturViewController.m
//  Aktivitem
//
//  Created by Tahir on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AktiviteOlusturViewController.h"
#import "FavorilerViewController.h"
#import "UserControl.h"
#import "CheckConnection.h"


@interface AktiviteOlusturViewController (){
    
    int pickerChoice;
    int indexID;
    
    BOOL isUpdate;
    BOOL isDelete;
    
    NSString *seqno;
    
    int inMenu;
    
    UITouch *touched;
     CGPoint startPoint;
}

@end

@implementation AktiviteOlusturViewController
@synthesize scrollview,projeAdi_Textfield,projeYeri_Textfield,faturaSaati_Textfield,aktiviteSaati_Textfield,aciklama_TextView,favoriInfo,pickerView,activityInfo,newActivity,save_btn,delete_btn,news_btn,lokasyon_Textfield,datePicker,tarih_Textfield,indicator,successImage,topView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    scrollview.contentSize = CGSizeMake(0.0,650.0);
    
    self.title = @"Aktivite Girişi";
    
    
    pickerChoice = -1;
    indexID = -1;
    isUpdate = false;
    
    [projeAdi_Textfield setDelegate:self];
    [projeYeri_Textfield setDelegate:self];
    [faturaSaati_Textfield setDelegate:self];
    [aktiviteSaati_Textfield setDelegate:self];
    [aciklama_TextView setDelegate:self];
    [tarih_Textfield setDelegate:self];
    
    list = [[NSMutableArray alloc] init];
    listAktivity = [[NSMutableArray alloc] init];
    [list removeAllObjects];
    
    
    for (int i = 0; i <= 24; i++) {
        [listAktivity addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    listLokasyon = [[NSMutableArray alloc] initWithObjects:@"Müşteri",@"Detay",@"Ev", nil];
    activity = [[Activity alloc] init];
   
    
    if (!newActivity) {
        
        self.title = activityInfo.Begda;
        
        projeAdi_Textfield.text      = activityInfo.ProjectName;
        faturaSaati_Textfield.text   = activityInfo.Akhour;
        aktiviteSaati_Textfield.text = activityInfo.Wrhour;
        aciklama_TextView.text       = activityInfo.Txt01;
        tarih_Textfield.text         = activityInfo.Begda;
        seqno = activityInfo.Seqno;
        
        [tarih_Textfield setEnabled:false];
       
        if ([activityInfo.Place isEqualToString:@"D"]) {
            lokasyon_Textfield.text = @"Detay";
        }
        else if ([activityInfo.Place isEqualToString:@"M"]) {
            lokasyon_Textfield.text = @"Müşteri";
        }
        else if ([activityInfo.Place isEqualToString:@"E"]) {
            lokasyon_Textfield.text = @"Ev";
        }
        
        [news_btn setEnabled:NO];
        
        if (![activityInfo.Stat2 isEqualToString:@""] || ![activityInfo.Stat3 isEqualToString:@""] || ![activityInfo.Stat4 isEqualToString:@""] || ![activityInfo.Stat5 isEqualToString:@""]) {
           
            [projeAdi_Textfield setEnabled:false];
            [faturaSaati_Textfield setEnabled:false];
            [faturaSaati_Textfield setEnabled:false];
            [aktiviteSaati_Textfield setEnabled:false];
            [projeYeri_Textfield setEnabled:false];
            [lokasyon_Textfield setEnabled:false];
            [aciklama_TextView setEditable:false];
            
            [save_btn setEnabled:NO];
            [delete_btn setEnabled:NO];
        }
        isUpdate = TRUE;
        
        [self findLocationForExistActivity];
    }
    else {
        // Default values for new Actviyt
        
         aktiviteSaati_Textfield.text = @"8";
         faturaSaati_Textfield.text = @"0";
         lokasyon_Textfield.text = [listLokasyon objectAtIndex:1];
         [save_btn setEnabled:NO];
         [delete_btn setEnabled:NO];
        // set current date
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"YYYY-MM-dd"];
        [dateformat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        tarih_Textfield.text = [dateformat stringFromDate:[NSDate date]];
    }
    
   // Animation
    [self.view addSubview:topView];
    [topView setUserInteractionEnabled:YES];
    CGRect basketTopFrame1 = topView.frame;
    basketTopFrame1.origin.y = -44;
    topView.frame = basketTopFrame1;
    
    inMenu = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)topMenuEraseIn{
    
    CGRect basketTopFrame2 = topView.frame;
    basketTopFrame2.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    topView.frame = basketTopFrame2;
    [UIView commitAnimations];
    inMenu = 1;
}
-(void)topMenuEraseOut{
    
    CGRect basketTopFrame2 = topView.frame;
    basketTopFrame2.origin.y = -44;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    topView.frame = basketTopFrame2;
    [UIView commitAnimations];
    inMenu = 0;
}
-(IBAction)inMenu:(id)sender{
    
    if (inMenu == 0) {
        [self topMenuEraseIn];
    }
    else {
        [self topMenuEraseOut];
    }
}


#pragma mark -
#pragma mark UITextFieldDelegate Protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    [textField canBecomeFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField returnKeyType] == UIReturnKeyDefault) {
        [textField resignFirstResponder];
    }    
    
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(void)findLocationForExistActivity
{
    // Var olan aktivitelerin lokasyonunu bulma
    [list removeAllObjects];
    
    for (int i = 0; i < [[FavoriInfo locationArray] count]; i++) {
        rows = [[FavoriInfo locationArray] objectAtIndex:i];
        if (activityInfo.aid == rows.ID) {
            if ([activityInfo.Locno isEqualToString:rows.locno]) {
                projeYeri_Textfield.text = rows.adr01;
            }
             [list addObject:rows];
        }
    }
}

-(void)setTextt:(FavoriInfo *)_favori{
    projeAdi_Textfield.text = _favori.projectName;
    
    // create Activity
    favoriInfo = _favori;
    
    // set Save button Enable
     [save_btn setEnabled:YES];
    
    // hide top menu
    [self topMenuEraseOut];
}
-(void)setIndex:(int)_id{
    indexID = _id;
    
    if ([[FavoriInfo locationArray] count] != 0) {
        [list removeAllObjects];
        for (int i = 0; i < [[FavoriInfo locationArray] count]; i++) {
            rows = [[FavoriInfo locationArray] objectAtIndex:i];
            if ([rows.kunnr intValue] == indexID) {
                [list addObject:rows];
            }
        }
        if ([list count] != 0) {
            rows =  [list objectAtIndex:0];
            projeYeri_Textfield.text = rows.adr01;
        }
        else {
            projeYeri_Textfield.text = @"";
            rows = nil;
        }
        [self setProjectLocation:[listLokasyon objectAtIndex:0]];   
    }
}

-(void)setProjectPlace:(NSString *)_str
{
    projeYeri_Textfield.text = _str;
}
-(void)setProjectLocation:(NSString *)_str
{
    lokasyon_Textfield.text = _str;
}
-(void)setAktiviteSaati:(NSString*)_str
{
    aktiviteSaati_Textfield.text = _str;
}
-(void)setFaturaSaati:(NSString*)_str
{
    faturaSaati_Textfield.text = _str;
}

#pragma mark -
#pragma mark UITextViewDelegate Protocol

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [datePicker setHidden:YES];
    [pickerView setHidden:YES];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        [pickerView setHidden:YES];
        return NO;
    }
    
    NSUInteger lenght = [textView.text length] + [text length] - range.length;
    
    return (lenght > 300) ? NO : YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    return YES;
}
-(IBAction)isUpdateOrCreateActivity:(id)sender{
    
    if (isUpdate) {
        [self updateActivity:sender];
    }
    else {
        [self createActivity:sender];
    }
}

-(void)createActivity:(id)sender{
   
    // create Activity
    
    createActivity = [[ActivityInfo alloc] init];
    createActivity.Pernr = [UserControl getPernr];
    createActivity.Begda = tarih_Textfield.text;
    createActivity.Kunnr = favoriInfo.customer;
    createActivity.Locno = rows.locno;
    createActivity.Prjno = favoriInfo.project;
    createActivity.CustomerName = favoriInfo.customerName;
    createActivity.ProjectName = favoriInfo.projectName;
    createActivity.Wrhour = aktiviteSaati_Textfield.text;
    createActivity.Akhour = faturaSaati_Textfield.text;
    createActivity.Stat4 = @"I"; // send by mobile
    createActivity.Stat5 = @"";  //
    
    
    if (rows.locno == NULL)
        createActivity.Locno = @"";
    
    // initial values for TXT
    createActivity.Txt01 = @"";
    createActivity.Txt02 = @"";
    createActivity.Txt03 = @"";
    createActivity.Txt04 = @"";
    createActivity.Txt05 = @"";
    
    createActivity.Seqno = @"";
    
    
    if ([lokasyon_Textfield.text isEqualToString:@"Detay"]) {
        createActivity.Place = @"D";
    }
    else if ([lokasyon_Textfield.text isEqualToString:@"Müşteri"]) {
        createActivity.Place = @"M";
    }
    else if ([lokasyon_Textfield.text isEqualToString:@"Ev"]) {
        createActivity.Place = @"E";
    }
    
    for (int i = 1 ; i < [aciklama_TextView.text length]; i++) {
        
        if (i < 60) {
            createActivity.Txt01 = [aciklama_TextView.text substringWithRange:NSMakeRange(0, i+1)];
        }
        else if (i >= 60 && i <120) {
            createActivity.Txt02 = [aciklama_TextView.text substringWithRange:NSMakeRange(60, i-59)];
        }
        else if (i >= 120 && i <180) {
            createActivity.Txt03 = [aciklama_TextView.text substringWithRange:NSMakeRange(120, i-119)];
        }
        else if (i >= 180 && i <240) {
            createActivity.Txt04 = [aciklama_TextView.text substringWithRange:NSMakeRange(180, i-179)];
        }
        else if (i >= 240 && i <=300) {
            createActivity.Txt05 = [aciklama_TextView.text substringWithRange:NSMakeRange(240, i-239)];
        }
    }
    
    if (![CheckConnection internetConnection]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    [successImage setImage:[UIImage imageNamed:@"kayit.png"]];
    [self startLoadingView];
    
    NSString *result = [activity createActiviyt:createActivity];
    
    if ([result isEqualToString:@"O"]) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        [indicator setHidden:YES];
        [successImage setHidden:NO];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        //        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self stopLoadingView];
    [self.view setAlpha:1];
    
    // end of create Activity
}
-(void)updateActivity:(id)sender{
    updateActivity = [[ActivityInfo alloc] init];
    
    updateActivity.Pernr = [UserControl getPernr];

    updateActivity.Begda = activityInfo.Begda;
    updateActivity.Seqno = activityInfo.Seqno;
    updateActivity.Kunnr = activityInfo.Kunnr;
    updateActivity.Prjno = activityInfo.Prjno;
    updateActivity.Locno = rows.locno;
    updateActivity.Wrhour = aktiviteSaati_Textfield.text;
    updateActivity.Akhour = faturaSaati_Textfield.text;
    updateActivity.CustomerName = activityInfo.CustomerName;
    updateActivity.ProjectName = activityInfo.ProjectName;
    updateActivity.Stat4 = @"I";
    updateActivity.Stat5 = @"";
    updateActivity.Txt01 = @"";
    updateActivity.Txt02 = @"";
    updateActivity.Txt03 = @"";
    updateActivity.Txt04 = @"";
    updateActivity.Txt05 = @"";
    
    if (rows.locno == NULL)
        updateActivity.Locno = @"";

    if ([lokasyon_Textfield.text isEqualToString:@"Detay"]) {
        updateActivity.Place = @"D";
    }
    else if ([lokasyon_Textfield.text isEqualToString:@"Müşteri"]) {
        updateActivity.Place = @"M";
    }
    else if ([lokasyon_Textfield.text isEqualToString:@"Ev"]) {
        updateActivity.Place = @"E";
    }
    
    for (int i = 1 ; i < [aciklama_TextView.text length]; i++) {
        
        if (i < 60) {
            updateActivity.Txt01 = [aciklama_TextView.text substringWithRange:NSMakeRange(0, i+1)];
        }
        else if (i >= 60 && i <120) {
            updateActivity.Txt02 = [aciklama_TextView.text substringWithRange:NSMakeRange(60, i-59)];
        }
        else if (i >= 120 && i <180) {
            updateActivity.Txt03 = [aciklama_TextView.text substringWithRange:NSMakeRange(120, i-119)];
        }
        else if (i >= 180 && i <240) {
            updateActivity.Txt04 = [aciklama_TextView.text substringWithRange:NSMakeRange(180, i-179)];
        }
        else if (i >= 240 && i <=300) {
            updateActivity.Txt05 = [aciklama_TextView.text substringWithRange:NSMakeRange(240, i-239)];
        }
    }

    if (![CheckConnection internetConnection])
        return;
    
    [successImage setImage:[UIImage imageNamed:@"guncelleme.png"]];
    [self startLoadingView];
    
    NSString *result = [activity updateActiviyt:updateActivity];
    
    if ([result isEqualToString:@"O"]) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        [indicator setHidden:YES];
        [successImage setHidden:NO];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    [self stopLoadingView];
    [self.view setAlpha:1];
}

-(IBAction)deleteActivityClick:(id)sender{
    UIAlertView *infoMes = [[UIAlertView alloc]initWithTitle:@"Uyarı" message:@"Silmek istediğinizden emin misiniz ?" delegate:self cancelButtonTitle:@"Hayır" otherButtonTitles:@"Evet", nil];
    [infoMes show];
    [infoMes release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [NSThread detachNewThreadSelector:@selector(removeActivity) toTarget:self withObject:nil];
    }
}

-(void)removeActivity {
    deleteActivity = [[ActivityInfo alloc] init];
    
    deleteActivity.Pernr = [UserControl getPernr];
    deleteActivity.Begda = activityInfo.Begda;
    deleteActivity.Seqno = activityInfo.Seqno;
    deleteActivity.Kunnr = activityInfo.Kunnr;
    
    deleteActivity.Prjno =  @"";
    deleteActivity.Wrhour = @"";
    deleteActivity.Akhour = @"";
    deleteActivity.Place =  @"";
    deleteActivity.CustomerName = @"";
    deleteActivity.ProjectName = @"";
    deleteActivity.Stat4 = @"";
    deleteActivity.Stat5 = @"D";// Silme işlemi
    deleteActivity.Txt01 = @"";
    deleteActivity.Txt02 = @"";
    deleteActivity.Txt03 = @"";
    deleteActivity.Txt04 = @"";
    deleteActivity.Txt05 = @"";
    deleteActivity.Locno = @"";
    
    if (![CheckConnection internetConnection])
        return;
    
    [successImage setImage:[UIImage imageNamed:@"slme.png"]];
    [self startLoadingView];
    
    NSString *result = [activity deleteActiviyt:deleteActivity];
    
    if ([result isEqualToString:@"O"]) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        [indicator setHidden:YES];
        [successImage setHidden:NO];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    [self stopLoadingView];
    [self.view setAlpha:1];
}


-(void)startLoadingView{
    [self.view setAlpha:0.6];
    [indicator setHidden:NO];
    [indicator startAnimating];
    [indicator setColor:[UIColor blackColor]];
}
-(void)stopLoadingView{
    [indicator setHidden:YES];
    [successImage setHidden:YES];
    [indicator stopAnimating];
    [indicator setColor:[UIColor whiteColor]];
}

-(IBAction)favoriler:(id)sender{
    
    FavorilerViewController *favorilerViewController = [[FavorilerViewController alloc] init];
    [favorilerViewController setDelegate:self];
    [pickerView setHidden:YES];
    [favorilerViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self.navigationController presentModalViewController:favorilerViewController animated:YES];
    [favorilerViewController release];
    
}
-(IBAction)displayPickerView:(id)sender{
    // hide top menu
    [self topMenuEraseOut];
    [self.view endEditing:YES];

    if (pickerView.isHidden == NO) {
        [pickerView reloadAllComponents];
    }
    else{
        [pickerView setHidden:NO];
    }
    
    UITextField *field = (UITextField*)sender;
    
    if (field == projeYeri_Textfield || field == lokasyon_Textfield ) {
        pickerChoice = 0;
        
    }
    else if (field == faturaSaati_Textfield) {
        pickerChoice = 1;
    }
    else if (field == aktiviteSaati_Textfield) {
        pickerChoice = 2;
    }
    
    [pickerView reloadAllComponents];
}

-(IBAction)displayDatePicker:(id)sender{
    [sender resignFirstResponder];
    // hide top menu
    [self topMenuEraseOut];
    
    if (datePicker.isHidden == NO) {
        [datePicker setHidden:YES];
    }
    else {
        [datePicker setHidden:NO];
    }
}

-(IBAction)hideAllDate_Picker:(id)sender{
    if (datePicker.isHidden == NO) {
        [datePicker setHidden:YES];
    }
    if (pickerView.isHidden == NO) {
        [pickerView setHidden:YES];
    }
}
-(IBAction)setTextofDatePicker:(id)sender{
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"YYYY-MM-dd"];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    tarih_Textfield.text = [dateformat stringFromDate:[datePicker date]];
    
}
- (IBAction)backgroundTouch:(id)sender {
    [aciklama_TextView resignFirstResponder];
    [projeYeri_Textfield resignFirstResponder];
    [lokasyon_Textfield resignFirstResponder];
    [faturaSaati_Textfield resignFirstResponder];
    [aktiviteSaati_Textfield resignFirstResponder];
    
    if (datePicker.isHidden == NO) {
        [datePicker setHidden:YES];
    }
    if (pickerView.isHidden == NO) {
        [pickerView setHidden:YES];
    }
}
#pragma mark -
#pragma mark UI Touches data source
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    touched = [touches anyObject];
//    NSLog(@"%d",touched.view.tag);
//}
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    touched = [touches anyObject];
//	
//	startPoint = [touched locationInView:self.view];
//    touched.view.center = CGPointMake(startPoint.x, startPoint.y);
//}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//}

#pragma mark -
#pragma mark Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
     if(pickerChoice == 1 || pickerChoice == 2){
        return 2;    
     }
     else {
	    return 2;         
     }

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component 
{ 
    
    if (pickerChoice == 0) {
        switch (component) {
         case 0:
            return [list count];
           break;
         case 1:
           return [listLokasyon count];
           break;    
         default:
         break;
     } 
    }
    else if(pickerChoice == 1 || pickerChoice == 2){
        return [listAktivity count];
    }
    else {
        return 0;
    }    
  
    return 0;
   
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerChoice == 0) {
        
        switch (component) {
            case 0:
                rows = [list objectAtIndex:row];
                return rows.adr01;
                break;
            case 1:
                return [listLokasyon objectAtIndex:row];
                break;
                
            default:
                break;
        }
        return 0;
        
    }
    else if(pickerChoice == 1 || pickerChoice == 2){
        return [listAktivity objectAtIndex:row];
    }
    else {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)picker didSelectRow:(NSInteger)row inComponent: (NSInteger)component
{
        
    if(pickerChoice == 1 || pickerChoice == 2){
         
        switch (component) {
            case 0:
                 [self setFaturaSaati:[listAktivity objectAtIndex:row]];
                break;
            case 1:
                [self setAktiviteSaati:[listAktivity objectAtIndex:row]];
                break;    
            default:
                break;
        }
        
    }
    else if (pickerChoice == 0){
        
        switch (component) {
            case 0:
                if ([list count]!=0) {
                  rows = [list objectAtIndex:row];
                 [self setProjectPlace:rows.adr01];
                }
                break;
            case 1:
                if (row == 1 || row == 2) {
                    projeYeri_Textfield.text = @"";
                    [list removeAllObjects];
                }
                else {
                    if (!newActivity){
                       [self findLocationForExistActivity]; 
                    }
                    else {
                     
                        [self setIndex:indexID];
                    }
                   projeYeri_Textfield.text = rows.adr01;
                 
                }
                [pickerView reloadAllComponents];
                [self setProjectLocation:[listLokasyon objectAtIndex:row]];
                break;
                
            default:
                break;
        }   
    }
}



@end
