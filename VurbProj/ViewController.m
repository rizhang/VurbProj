//
//  ViewController.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "Constants.h"
#import "CardTableViewCell.h"
#import "CardModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define TV_ROW_HEIGHT 150.0f;

NSInteger TIME_OUT = 3;

@interface ViewController ()
{
    BOOL cardsLoaded;
    BOOL locationLoaded;
    BOOL loading;
    NSTimer* loadTimeOut;
}

@property(nonatomic, strong) UILabel* locationLabel;
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSMutableArray* cards;
@property(nonatomic, strong) UILabel* loadingLabel;
@property(nonatomic, strong) DataManager* dm;
@property(nonatomic, strong) UIRefreshControl* refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNSNotifications];
    _dm = [DataManager sharedInstance];
    //[_dm refreshCardsAndGetLocation];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    _locationLabel.text = [_dm locationString];
    _locationLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_locationLabel];
    
    CGRect tvFrame = _tableView.frame;
    tvFrame.origin.y = CGRectGetMaxY(_locationLabel.frame);
    tvFrame.size.width = screenWidth;
    tvFrame.size.height = screenHeight - CGRectGetHeight(_locationLabel.frame);
    
    _tableView = [[UITableView alloc] initWithFrame:tvFrame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = TV_ROW_HEIGHT;
    [self.view addSubview:_tableView];
    
    _loadingLabel = [[UILabel alloc] initWithFrame:self.view.frame];
    _loadingLabel.text = @"LOADING...";
    _loadingLabel.backgroundColor = [UIColor whiteColor];
    _loadingLabel.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:_loadingLabel];
    
    cardsLoaded = NO;
    locationLoaded = NO;
    loading = YES;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(pullDownRefresh)
                  forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    
}

-(void) initNSNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationFound) name:NSNotifLocationFound object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cardsFetched) name:NSNotifCardsFetched object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationEnabled) name:NSNotifLocationEnabled object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pullDownRefresh
{
    [_dm refreshCards];
}

-(void) removeLoadingScreen
{
    [UIView animateWithDuration:.2 animations:^{
        _loadingLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_loadingLabel removeFromSuperview];
        
    }];
    loading = NO;

}

-(void) countFinishLoading
{

    if(locationLoaded && cardsLoaded) {
        [self removeLoadingScreen];
        [loadTimeOut invalidate];
    }
}

#pragma mark - Timer Action

-(void) timerFired
{
    [self removeLoadingScreen];
}

#pragma mark - NSNotifications Actions
-(void) locationEnabled
{
    loadTimeOut = [NSTimer scheduledTimerWithTimeInterval:TIME_OUT target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}

-(void) locationFound
{
    _locationLabel.text = [_dm locationString];
    locationLoaded = YES;
    if(loading)
        [self countFinishLoading];
}

-(void) cardsFetched
{
    _cards = [_dm getArrayOfCards];
    [_tableView reloadData];
    cardsLoaded = YES;
    [self countFinishLoading];
    [self.refreshControl endRefreshing];
}

#pragma mark - tableView

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cards.count;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CardTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        CGFloat rowHeight = TV_ROW_HEIGHT;
        cell = [[CardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier Height:rowHeight];
        
    }
    NSInteger row = indexPath.row;
    
    CardModel* cModel = _cards[row];
    
    cell.titleLabel.text = cModel.title;
    cell.thumbNail.backgroundColor = [UIColor grayColor];
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:cModel.thumbNailUrl] options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [cell.thumbNail setImage:image];
    }];
    
    NSArray *viewsToRemove = [cell.customView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    [cModel getCustomUIViewWithView:cell.customView];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CardModel* card = _cards[row];
        [_dm deleteCard:card];
        [_cards removeObjectAtIndex:row];
        [tableView reloadData];
    }
}

@end
