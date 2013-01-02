//
//  AktiviteOlusturViewController.h
//  Aktivitem
//
//  Created by Tahir on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriInfo.h"
#import "FavorilerViewController.h"
#import "Activity.h"

@interface AktiviteOlusturViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,setProjectNameDelegate>{
    
    NSMutableArray *list;
    NSMutableArray *listLokasyon;
    NSMutableArray *listAktivity;
    
    LocationInfo *rows;
    FavoriInfo *favoriInfo;
    Activity *activity;
    
    ActivityInfo *activityInfo;
    ActivityInfo *createActivity;
    ActivityInfo *updateActivity;
    ActivityInfo *deleteActivity;
}

@property(nonatomic,retain)IBOutlet UIScrollView *scrollview;
@property(nonatomic,retain)IBOutlet UITextField *projeAdi_Textfield;
@property(nonatomic,retain)IBOutlet UITextField *projeYeri_Textfield;
@property(nonatomic,retain)IBOutlet UITextField *lokasyon_Textfield;
@property(nonatomic,retain)IBOutlet UITextField *faturaSaati_Textfield;
@property(nonatomic,retain)IBOutlet UITextField *aktiviteSaati_Textfield;
@property(nonatomic,retain)IBOutlet UITextField *tarih_Textfield;
@property(nonatomic,retain)IBOutlet UITextView *aciklama_TextView;

@property(nonatomic,assign)BOOL newActivity;

@property(nonatomic,retain)IBOutlet UIPickerView *pickerView;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain)IBOutlet UIImageView *successImage;


@property(nonatomic,retain)IBOutlet FavoriInfo *favoriInfo;
@property(nonatomic,retain)ActivityInfo *activityInfo;

@property(nonatomic,retain)IBOutlet UIButton *news_btn;
@property(nonatomic,retain)IBOutlet UIButton *save_btn;
@property(nonatomic,retain)IBOutlet UIButton *delete_btn;

@property(nonatomic,retain)IBOutlet UIView *topView;

-(IBAction)favoriler:(id)sender;
-(IBAction)displayPickerView:(id)sender;
-(IBAction)displayDatePicker:(id)sender;
-(IBAction)setTextofDatePicker:(id)sender;

-(IBAction)isUpdateOrCreateActivity:(id)sender;
-(void)createActivity:(id)sender;
-(void)updateActivity:(id)sender;
-(IBAction)deleteActivityClick:(id)sender;

-(IBAction)inMenu:(id)sender;

@end
