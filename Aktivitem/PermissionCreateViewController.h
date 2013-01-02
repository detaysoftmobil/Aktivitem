//
//  PermissionCreateViewController.h
//  Aktivitem
//
//  Created by Detay on 11/28/12.
//
//

#import <UIKit/UIKit.h>

@interface PermissionCreateViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UILabel *lblBitisTarihi;
    IBOutlet UILabel *lblKulGunSayisi;
    IBOutlet UILabel *lblIzinTuru;
    IBOutlet UILabel *lblAciklama;
    
    IBOutlet UITextField *txtPermissionType;
    IBOutlet UITextField *txtPermissionStyle;
    IBOutlet UITextField *txtBegdaDate;
    IBOutlet UITextField *txtEnddaDate;
    IBOutlet UITextField *txtResultDate;

    IBOutlet UITextView *textViewAciklama;
    
    IBOutlet UIPickerView *pickerView;
    IBOutlet UIDatePicker *datePickerView;
    
    NSMutableArray *txtselectionArray;
    NSMutableArray *txtselectionIDArray;
}

@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@end
