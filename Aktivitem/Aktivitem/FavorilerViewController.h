//
//  FavorilerViewController.h
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriInfo.h"


@protocol setProjectNameDelegate <NSObject>

-(void)setTextt:(FavoriInfo*)_favori;
-(void)setIndex:(int)_id;

@end

@interface FavorilerViewController : UIViewController<UITableViewDelegate,UISearchBarDelegate>{
    
    FavoriInfo *row;
    NSMutableArray *searchedData;
    NSMutableArray *templist;
    
    id<setProjectNameDelegate> delegate;
    
} 
@property(nonatomic,retain)IBOutlet UIBarButtonItem *barBtn;
@property(nonatomic,retain)IBOutlet UITableView *table;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *activiytView;
@property(nonatomic,retain)IBOutlet UISearchBar *searchbar;

@property(nonatomic,assign)id<setProjectNameDelegate> delegate;

-(IBAction)backtoAktivitem:(id)sender;


@end
