//
//  PermissionAllListViewController.m
//  Aktivitem
//
//  Created by Detay on 11/28/12.

#import "PermissionAllListViewController.h"
#import "PermissionAllListDetailViewController.h"
#import "PermissionAllListCallXML.h"
#import "PermissionAllListXMLParser.h"
#import "PermissionStruct.h"
#import "PermissionCreateViewController.h"
#import "CheckConnection.h"
#import "UserControl.h"

#import "OnayRedPermissionCallXML.h"
#import "CreatePermissionXMLParser.h"


static PermissionAllListViewController *myPermissionAllListViewController;

@interface PermissionAllListViewController ()
{
    int tabBarItemSelectedIndex;
    
    NSMutableArray *array;
    PermissionAllListCallXML *myCreatePermissionCall;
    BOOL detailPermissionStatus,ustBirimKontrol,onayBtnStatus,modulOpen;;
    
    NSMutableArray *permissionArr;
    
    
    UITabBarItem *tempTabbarItem;
}
@end

@implementation PermissionAllListViewController

@synthesize permissionCreateStatus,myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        array = [[NSMutableArray alloc]init];
        permissionArr = [[NSMutableArray alloc]init];
        [myTableView setDelegate:self];
        [myTableView setDataSource:self];
        tempTabbarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    ((UITabBarItem*)[self.tabBarController.view viewWithTag:4]).enabled = NO;

    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Yeni" style:UIBarButtonItemStylePlain target:self action:@selector(createPermission:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated {

    self.title = @"İzin";
    
    if (!modulOpen) {
        modulOpen = YES;
        [self tableDefaultSetData];   
    }
    
    [self setTabbarItemBadgeNumber];
    [self tabBar:nil didSelectItem:tempTabbarItem];
            
    if (detailPermissionStatus & ustBirimKontrol) {
        [self onayTableReload];
        detailPermissionStatus = NO;
        return;
    }
    
    if ([permissionCreateStatus isEqualToString:@"S"]) {
        NSLog(@"selam");
        permissionCreateStatus=@"";
        [self tableDefaultSetData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    myPermissionAllListViewController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)createPermission:(id)sender {
    self.title = @"Geri";
    PermissionCreateViewController *permissionCreateViewController = [[PermissionCreateViewController alloc]init];
    [self.navigationController pushViewController:permissionCreateViewController animated:YES];
    [permissionCreateViewController release];
}

-(IBAction)onayRedPermission:(id)sender {
    
}


-(void)onayTableReload{
    myCreatePermissionCall = [[PermissionAllListCallXML alloc]init];
    PermissionStruct *myPermissionStruct = [[PermissionStruct alloc]init];
    NSString *resultXML = [myCreatePermissionCall callXML:myPermissionStruct];
    
    [[PermissionAllListXMLParser getPermissionAllListXMLParser]parseXML:resultXML];
    [array setArray:[[PermissionAllListXMLParser getPermissionAllListXMLParser] PermissionStructArray]];
    [self sortingAllArray:@"01"];
    
    if (tabBarItemSelectedIndex == 3) {
        [self onayButtonVisible];
    }
}

-(void)tableDefaultSetData{
    tabBarItemSelectedIndex = 0;
    
    if (![CheckConnection internetConnection])
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else
    {
        myTableView.hidden = YES;
        activtyLoading.hidden = NO;
        [activtyLoading setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [activtyLoading startAnimating];
        [myTabbar setSelectedItem:[myTabbar.items objectAtIndex:0]];
        PermissionStruct *myPermissionStruct = [[PermissionStruct alloc]init];
        
        myCreatePermissionCall = [[PermissionAllListCallXML alloc]init];
        NSString *resultXML = [myCreatePermissionCall callXML:myPermissionStruct];
        
        if ([resultXML length]>0) {
            [[PermissionAllListXMLParser getPermissionAllListXMLParser]parseXML:resultXML];
            
            [array setArray:[[PermissionAllListXMLParser getPermissionAllListXMLParser] PermissionStructArray]];
            [self sortingArray:@"01"];
            [activtyLoading stopAnimating];
            activtyLoading.hidden = YES;
            myTableView.hidden = NO;
        }else{
            [[[UIAlertView alloc]initWithTitle:@"" message:@"Bağlantı Hatası" delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles:nil,nil] show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - tableview datasource
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
    
    if (onayBtnStatus==NO) {
        cell = nil;
    }
    
    if(cell == nil)
    {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

        
        UILabel *lbl_id = [[UILabel alloc]initWithFrame:CGRectMake(5, 12, 40, 20)];
        lbl_id.tag = 100;
        [lbl_id setTextAlignment:UITextAlignmentCenter];
        [lbl_id setFont:[UIFont fontWithName:@"Arial" size:17]];
        [lbl_id setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl_id];
        [lbl_id release];
        
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 12, 250, 20)];
        lbl.tag = 101;
        [lbl setFont:[UIFont fontWithName:@"Arial" size:14]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
        [lbl release];
        
        UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 250, 20)];
        lbl2.tag = 102;
        lbl2.hidden = YES;
        [lbl2 setFont:[UIFont fontWithName:@"Arial" size:14]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl2];
        [lbl2 release];
        
        
        UIImage *redButtonImage = [UIImage imageNamed:@"checkbox_empty.png"];
        
        UIButton *redButton = [UIButton buttonWithType:UIButtonTypeCustom];
        redButton.frame = CGRectMake(5, 5.0, 32.0, 32.0);
        [redButton addTarget:self action:@selector(btnCheck:) forControlEvents:UIControlEventTouchUpInside];
        [redButton setBackgroundImage:redButtonImage forState:UIControlStateNormal];
        [redButton setTag:indexPath.row+10];
        [redButton setHidden:YES];
        [cell addSubview:redButton];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    PermissionStruct *temp = [array objectAtIndex:indexPath.row];

    ((UILabel*)[cell viewWithTag:100]).text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    ((UILabel*)[cell viewWithTag:101]).frame = CGRectMake(50,12, 250, 20);
    ((UILabel*)[cell viewWithTag:101]).text = [NSString stringWithFormat:@"   %@      -     %@",
                                               [self getStringToDateFormatter:temp.Begda],
                                               [self getStringToDateFormatter:temp.Endda]];
    ((UILabel*)[cell viewWithTag:102]).hidden = YES;
   
    if (tabBarItemSelectedIndex == 0) {
        cell.imageView.image = [UIImage imageNamed:@"sari.png"];
    }
    if (tabBarItemSelectedIndex == 1) {
        cell.imageView.image = [UIImage imageNamed:@"yesil.png"];
    }
    if (tabBarItemSelectedIndex == 2) {
        cell.imageView.image = [UIImage imageNamed:@"kırmızı.png"];
    }
    if (tabBarItemSelectedIndex == 3) {
        cell.imageView.image = [UIImage imageNamed:@"sari.png"];
        ((UILabel*)[cell viewWithTag:101]).frame = CGRectMake(50, 0, 250, 20);
        ((UILabel*)[cell viewWithTag:101]).text = [NSString stringWithFormat:@"   %@",temp.Ename];

        ((UILabel*)[cell viewWithTag:102]).hidden = NO;
        ((UILabel*)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"   %@      -     %@",[self getStringToDateFormatter:temp.Begda],[self getStringToDateFormatter:temp.Endda]];
        
        if (onayBtnStatus) {
            cell.imageView.hidden = YES;
            ((UIButton*)[cell viewWithTag:indexPath.row+10]).hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.imageView.hidden = NO;
            ((UIButton*)[cell viewWithTag:indexPath.row+10]).hidden = YES;
        }
    }
    return cell;
}

-(NSString*)getStringToDateFormatter:(NSString*)_obj{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *strBegdaDate = [df dateFromString:_obj];
    
    [df setDateFormat:@"dd-MM-YYYY"];
    
    return [df stringFromDate:strBegdaDate];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (onayBtnStatus) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    self.title = @"Geri";
    PermissionAllListDetailViewController *detail = [[[PermissionAllListDetailViewController alloc]initWithNibName:@"PermissionAllListDetailViewController" bundle:nil] autorelease];
    detail.selectedPermission = [array objectAtIndex:indexPath.row];
    detail.ustBirimKontrol = ustBirimKontrol;
    [self.navigationController pushViewController:detail animated:YES];
    detailPermissionStatus = YES;
}

#pragma mark -tabbar delegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    tempTabbarItem = item;
    
    self.navigationItem.rightBarButtonItem  = nil;
    self.navigationItem.rightBarButtonItems = nil;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Yeni" style:UIBarButtonItemStylePlain target:self action:@selector(createPermission:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    ustBirimKontrol = NO;
    
    int tempTabIndex = tabBarItemSelectedIndex;
    
    if(item.tag == 1)
    {
        onayBtnStatus = NO;
        [self sortingArray:@"01"];
        tabBarItemSelectedIndex = 0;
    }
    else if(item.tag == 2)
    {
        onayBtnStatus = NO;
        [self sortingArray:@"02"];
        tabBarItemSelectedIndex = 1;
    }
    else if(item.tag == 3)
    {
        onayBtnStatus = NO;
        [self sortingArray:@"03"];
        tabBarItemSelectedIndex = 2;
    }else if(item.tag == 4)
    {
        [self sortingAllArray:@"01"];
        tabBarItemSelectedIndex = 3;
        ustBirimKontrol = YES;
        if (!onayBtnStatus) {
            [self onayButtonVisible];
        }
    } if (onayBtnStatus) {
        if (tempTabIndex != tabBarItemSelectedIndex) {
            onayBtnStatus = NO;
            if (tabBarItemSelectedIndex != 4) {
                UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Yeni" style:UIBarButtonItemStylePlain target:self action:@selector(createPermission:)];
                self.navigationItem.rightBarButtonItem = rightBarButtonItem;
            }else
                [self onayButtonVisible];
        }
        [myTableView reloadData];
    }
}

#pragma mark -private method
-(int)sortingArray:(NSString*)_Odurm{
    [array removeAllObjects];
    for (PermissionStruct *st in [[PermissionAllListXMLParser getPermissionAllListXMLParser] PermissionStructArray]) {
        
        if ([st.Odurm isEqualToString:_Odurm] & ![st.Opernr isEqualToString:[UserControl getPernr]]) {
            [array addObject:st];
        }
    }
    [myTableView reloadData];
    return [array count];
}

-(int)sortingAllArray:(NSString*)_Odurm{
    [array removeAllObjects];
    for (PermissionStruct *st in [[PermissionAllListXMLParser getPermissionAllListXMLParser] PermissionStructArray]) {
        
        if ([st.Odurm isEqualToString:_Odurm] & [st.Opernr isEqualToString:[UserControl getPernr]]) {
            [array addObject:st];
        }
    }
    [myTableView reloadData];
    return [array count];
}

#pragma mark private methods
-(void)onayButtonVisible {
    self.navigationItem.rightBarButtonItems = nil;
    if ([array count]>0) {
        onayBtnStatus = NO;
        [myTableView reloadData];
        UIBarButtonItem *onayBtn = [self getBarButtonItem:@"Çoklu Seçim":0];
        self.navigationItem.rightBarButtonItem = onayBtn;
    }
}

-(void)setNavigationButtonsAdd {
    UIBarButtonItem *iptalBtn = [self getBarButtonItem:@"İptal":1];
    UIBarButtonItem *onayBtn  = [self getBarButtonItem:@"Onay" :2];
    UIBarButtonItem *redBtn   = [self getBarButtonItem:@"Red"  :3];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:redBtn,onayBtn,iptalBtn,nil];
}

-(UIBarButtonItem*)getBarButtonItem:(NSString*)title:(int)tag
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:title
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(permissionOnayRed:)];
    barBtn.tintColor = [UIColor colorWithRed:0/255.f green:40/255.f blue:66/255.f alpha:1.0];
    barBtn.tag = tag;
    return barBtn;
}

-(IBAction)permissionOnayRed:(id)sender{
    UIButton *selectedBtn =(UIButton*) sender;
    switch (selectedBtn.tag) {
        case 0:
            onayBtnStatus = YES;
            [myTableView reloadData];
            [self setNavigationButtonsAdd];
            break;
        case 1:
            [self onayButtonVisible];
            break;
        case 2:
            for (PermissionStruct *temp in array) {
                if ([temp.OnayDurum isEqualToString:@"1"]) {
                    temp.Odurm = @"02";
                    for (PermissionStruct *temp in array) {
                        if ([temp.OnayDurum isEqualToString:@"1"]) {
                            temp.Odurm = @"03";
                            [self permissionOnayRedQueue:temp];
                        }
                    }
                    [self messageBox:@"Talepler Onaylandı !"];
                }
            }
            break;
        case 3:
            for (PermissionStruct *temp in array) {
                if ([temp.OnayDurum isEqualToString:@"1"]) {
                    temp.Odurm = @"03";
                    [self permissionOnayRedQueue:temp];
                }
            }
            [self messageBox:@"Talepler Reddedildi !"];
            break;
    }
}

-(void)permissionOnayRedQueue:(PermissionStruct*)temp{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(OnayRedPermission:)                         object:temp];
    
    [queue addOperation:operation];
    [operation release];
}

-(void)messageBox:(NSString*)message{
    [[[UIAlertView alloc]initWithTitle:@"" message:message
                              delegate:nil
                     cancelButtonTitle:@"Tamam"
                     otherButtonTitles:nil,nil]show];
}

-(void)OnayRedPermission:(PermissionStruct*)_permistructor{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.2];
    view.tag = 923;
    [self.view addSubview:view];
    activtyLoading.hidden = NO;
    [activtyLoading startAnimating];
    OnayRedPermissionCallXML *xmlCall = [[OnayRedPermissionCallXML alloc]init];
    NSString *resultXML = [xmlCall callXML:_permistructor];
    resultXML = [[CreatePermissionXMLParser getCreatePermissionXMLParser]parseXML:resultXML];
    [self onayTableReload];
    activtyLoading.hidden = YES;
    [activtyLoading stopAnimating];
    
    for (UIView *t in self.view.subviews) {
        if (t.tag == 923) {
            [t removeFromSuperview];
        }
    }
}


-(IBAction)btnCheck:(id)sender{
    UIButton *selectedBtn =(UIButton*) sender;
    NSLog(@"TAG : %d",[selectedBtn tag]);
    
    PermissionStruct *temp = [array objectAtIndex:([selectedBtn tag] - 10)];
    
    if ([temp.OnayDurum isEqualToString:@"0"]) {
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_full.png"] forState:UIControlStateNormal];
        temp.OnayDurum = @"1";
    }else{
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_empty.png"] forState:UIControlStateNormal];
        temp.OnayDurum = @"0";
    }
    
    [array removeObjectAtIndex:([selectedBtn tag] - 10)];
    [array insertObject:temp atIndex:([selectedBtn tag] - 10)];
}

-(void)setTabbarItemBadgeNumber{
    int resultCount = 0;
    resultCount = [self sortingArray:@"01"];
    tb1.badgeValue = resultCount!=0?[NSString stringWithFormat:@"%d",resultCount]:nil;
    
    resultCount = [self sortingArray:@"02"];
    tb2.badgeValue = resultCount!=0?[NSString stringWithFormat:@"%d",resultCount]:nil;
    
    resultCount = [self sortingArray:@"03"];
    tb3.badgeValue = resultCount!=0?[NSString stringWithFormat:@"%d",resultCount]:nil;
    
    resultCount = [self sortingAllArray:@"01"];
    tb4.badgeValue = resultCount!=0?[NSString stringWithFormat:@"%d",resultCount]:nil;
}

+(PermissionAllListViewController*)getPermissionAllListViewController {
    if (!myPermissionAllListViewController) {
        myPermissionAllListViewController = [[super allocWithZone:NULL]init];
    }
    return myPermissionAllListViewController;
}

+(id)allocWithZone:(NSZone *)zone{
    return [self getPermissionAllListViewController];
}



@end
