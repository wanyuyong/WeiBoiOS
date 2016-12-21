//
//  TimeLineViewController.m
//  WeiBo
//
//  Created by Luobu on 25/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "TimeLineViewController.h"
#import "WBHttpRequest+TimeLine.h"
#import "TwitterSet.h"
#import "TwitterCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Masonry.h"
#import "JSONUtility.h"
#import "YALSunnyRefreshControl.h"
#import "MusicPlayViewController.h"

@interface TimeLineViewController () 

@property(strong, nonatomic) NSMutableArray *twitters;
@property(nonatomic) NSInteger page;
@property(nonatomic) NSInteger maxId;
@property(nonatomic) BOOL isRequest;
@property(strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong) YALSunnyRefreshControl *sunnyRefreshControl;
@property (nonatomic,strong) UILabel *loadMoreText;
@property(strong, nonatomic) UIActivityIndicatorView *tableFooterActivityIndicator;


@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _twitters = [NSMutableArray arrayWithCapacity:COUNT];
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.separatorColor = COLOR_LIGHT_BG;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TwitterCell class] forCellReuseIdentifier:@"identifer"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.equalTo(self.view);
    }];
    
    [self setFootView];
    
    [self setupRefreshControl];
    
    [self refresh];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
    [self navigationItem].rightBarButtonItem = btn;
}

- (void)test:(id)sender
{
    
//    _tableView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
//    [_tableView setContentOffset:CGPointMake(0, -100)];
    
    MusicPlayViewController *vc = [[MusicPlayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Other
- (void)refresh {
    if (!_isRequest) {
        _maxId = 0;
        [self requestTimeLine:_maxId page:PAGE_START count:COUNT];
    }
}

- (void)loadMore {
    if (!_isRequest) {
        [_tableFooterActivityIndicator startAnimating];
        _loadMoreText.hidden = NO;
        [self requestTimeLine:_maxId page:_page + 1 count:COUNT];
    }
}

- (void)setFootView {
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 40.0f)];
    tableFooterView.backgroundColor = [UIColor whiteColor];
    _loadMoreText = [[UILabel alloc] init];
    _loadMoreText.textAlignment = NSTextAlignmentCenter;
    _loadMoreText.font = MEDIUM_FONT_THIN;
    _loadMoreText.textColor = COLOR_NORMAL_TEXT;
    _loadMoreText.text = @"Loading...";
    [tableFooterView addSubview:_loadMoreText];
    [_loadMoreText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(tableFooterView);
    }];
    
    _tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] init];
    [_tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [tableFooterView addSubview:_tableFooterActivityIndicator];
    
    [_tableFooterActivityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(_loadMoreText.mas_right).offset(PADDING);
        make.centerY.mas_equalTo(_loadMoreText.mas_centerY);
    }];
    
    _tableView.tableFooterView = tableFooterView;
}


#pragma mark - NetWork request
-(void)requestTimeLine:(NSInteger)maxId page:(NSInteger)page count:(NSInteger)count {
   
    _isRequest = YES;
    
    [WBHttpRequest requestForFriendTimeLine:kAccessToken sinceId:0 maxId:maxId count:COUNT page:page baseApp:0 feature:0 trim_user:0 withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        NSLog(@"magic --当前线程 ---------------------------------  %@",[NSThread currentThread]);
        
        if(!error){
            TwitterSet *set = [TwitterSet objFormDictionary:result];
            
            [self runOnMainThread:^{
                
                NSLog(@"magic ～～当前线程 ---------------------------------  %@",[NSThread currentThread]);
                
                if (page == PAGE_START) {
                    [_twitters removeAllObjects];
                }
                
                if (set && set.twitters.count != 0) {
                    [_twitters addObjectsFromArray:set.twitters];
                    [_tableView reloadData];
                }
                
                if (page == PAGE_START && _twitters.count != 0) {
                    Twitter *firstObject = (Twitter *)[_twitters firstObject];
                    _maxId = firstObject.id;
                }
                _page = page;
                
            }];
        }
        
        [self runOnMainThread:^{
            [self.sunnyRefreshControl endRefreshing];
            [_tableFooterActivityIndicator stopAnimating];
            _loadMoreText.hidden = YES;
        }];
       
        _isRequest = NO;
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _twitters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TwitterCell *twitterCell = [tableView dequeueReusableCellWithIdentifier:@"identifer" forIndexPath:indexPath];
    [twitterCell setTwitter:_twitters[indexPath.row]];
    return twitterCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGFloat h = [tableView fd_heightForCellWithIdentifier:@"identifer" cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
        TwitterCell *twitterCell = (TwitterCell *)cell;
        [twitterCell setTwitter:_twitters[indexPath.row]];
    }];
    
    return h;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y + scrollView.frame.size.height  >= scrollView.contentSize.height){
        [self loadMore];
    }
}

#pragma mark - Pull-to-Refresh

- (void)setupRefreshControl{
    self.sunnyRefreshControl = [YALSunnyRefreshControl new];
    [self.sunnyRefreshControl addTarget:self
                                 action:@selector(sunnyControlDidStartAnimation)
                       forControlEvents:UIControlEventValueChanged];
    [self.sunnyRefreshControl attachToScrollView:self.tableView];
}

- (void)sunnyControlDidStartAnimation{
    // start loading something
    [self refresh];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
