//
//  ViewController.m
//  TimeLine
//
//  Created by Dylan on 16/4/28.
//  Copyright © 2016年 Dylan. All rights reserved.
//

#import "ViewController.h"
#import "TimeLineNode.h"
#import "TimeLineDisplayLayout.h"

@interface ViewController () <ASTableViewDelegate, ASTableViewDataSource, TimeLineNodeDelegate>

@property ( nonatomic, strong ) ASTableView * tableView;
@property ( nonatomic, strong ) NSMutableArray * displayLayouts;

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Initialize tableView.
    [self.view addSubview:self.tableView];
    
    // Initialize layouts for display.
    self.displayLayouts = [NSMutableArray array];
    
    [self buildDemoData: 0];
    [self buildDemoData: 1];
    [self buildDemoData: 2];
    [self buildDemoData: 3];
    [self buildDemoData: 4];
    [self buildDemoData: 5];
    
    [self.tableView reloadData];
}

//------------------------------------------------------------------------------
#pragma mark - Delegate methods
//------------------------------------------------------------------------------

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    
    return 1;
}

- (NSInteger) tableView: (UITableView *) tableView
  numberOfRowsInSection: (NSInteger) section {
    
    return self.displayLayouts.count;
}

- (ASCellNode *) tableView: (ASTableView *) tableView
     nodeForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    TimeLineNode * timeLineNode = [[TimeLineNode alloc]
                                   initWithDisplayLayout:_displayLayouts[indexPath.row]];
    timeLineNode.delegate = self;
    timeLineNode.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return timeLineNode;
}

- (void) tableView: (ASTableView *) tableView
willBeginBatchFetchWithContext: (ASBatchContext *) context {
    
    
}

//------------------------------------------------------------------------------
#pragma mark - Load table view
//------------------------------------------------------------------------------

- (ASTableView *) tableView {
    
    if ( !_tableView ) {
        
        _tableView = [[ASTableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain
                                      asyncDataFetching:YES];
        
        _tableView.asyncDelegate = self;
        _tableView.asyncDataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

//------------------------------------------------------------------------------
#pragma mark - Demo data
//------------------------------------------------------------------------------

- (void) buildDemoData: (NSInteger) index {
    
    TimeLineDisplayLayout * layout = [[TimeLineDisplayLayout alloc] init];
    
    DLUser * user = [[DLUser alloc] init];
    user.uid = index == 0 ? @"13088488288" : @"958226951";
    user.nickName = index == 0 ? @"微信" : index == 1 ? @"支付宝" : @"阿里巴巴";
    user.avatarURL = [NSURL URLWithString:@"http://d05.res.meilishuo.net/pic/l/f0/da/60f12fb56faf727c9530984b6853_500_331.jpg"];
    
    layout.user = user;
    layout.content = index % 2 == 0 ? @"百度百科旨在创造一个涵盖各领域知识的中文信息收集平台。百度百科强调用户的参与和奉献精神，充分调动互联网用户的力量，汇聚上亿用户的头脑智慧，积极进行交流和分享" : @"微信胸? 你好啊, 最近怎么样啊, 我是支付宝胸, 最近好想你, 好想你。";
    
    switch (index) {
        case 0:
            
            layout.contentType = DLContentType_MutiImage; // DLContentType_Shared; // DLContentType_Video;
            break;
        case 1:
            layout.contentType = DLContentType_Shared; // DLContentType_Video;
            break;
        case 2:
            layout.contentType = DLContentType_Video; // DLContentType_Video;
            break;
        default:
            index == 3 ? (layout.contentType = -1) : (layout.contentType = DLContentType_MutiImage);
            break;
    }
    
    DLVideoModel * video = [[DLVideoModel alloc] init];
    video.videoURL = [NSURL URLWithString:@"https://files.parsetfss.com/8a8a3b0c-619e-4e4d-b1d5-1b5ba9bf2b42/tfss-753fe655-86bb-46da-89b7-aa59c60e49c0-niccage.mp4"];
    layout.video = video;
    
    DLSharedModel * shared = [[DLSharedModel alloc] init];
    shared.desc = @"百度百科旨在创造一个涵盖各领域知识的中文信息收集平台。";
    shared.logoURL = [NSURL URLWithString:@"https://ww2.sinaimg.cn/crop.0.0.1080.1080.1024/005DYYVEjw8ev3mgwljsij30u00u0t9r.jpg"];
    layout.share = shared;
    
    DLImageModel * image = [[DLImageModel alloc] init];
    image.thumbURL = [NSURL URLWithString:@"http://www.33lc.com/article/UploadPic/2012-8/201282413335761587.jpg"];
    image.width = 681;
    image.height = 567;
    
    DLImageModel * image_1 = [[DLImageModel alloc] init];
    image_1.thumbURL = [NSURL URLWithString:@"http://d05.res.meilishuo.net/pic/l/f0/da/60f12fb56faf727c9530984b6853_500_331.jpg"];
    
    DLImageModel * image_2 = [[DLImageModel alloc] init];
    image_2.thumbURL = [NSURL URLWithString:@"http://img5.xiawu.com/xiawu-img/58/ZlYbEbzoEN_1338822517_210.jpg"];
    image_2.width = image_2.height = 470;
    
    index == 0 ? (layout.images = [NSArray arrayWithObjects:image, image_1, image_2, image_1, image_2, image_1, image_2, image_2, nil])
    : ( index == 4 ? (layout.images = [NSArray arrayWithObjects:image, nil]) : (layout.images = [NSArray arrayWithObjects:image_2, nil]) ) ;
    
    DLLocationModel * location = [[DLLocationModel alloc] init];
    location.locationName = @"浙江杭州三墩桔子里";
    
    if ( index % 2 == 0 ) {
      
        layout.location = location;
    }
    
    if ( index % 3 != 0 ) {
        
        layout.referred = @[@"Dylan", @"Alice", @"Bob", @"Sherry"];
    }
    layout.timestamp = [NSDate timeIntervalSinceReferenceDate];
    
    index % 2 == 0 ? (layout.favour = [NSArray arrayWithObjects:user, user, user, user, user, user, nil]) : (layout.favour = nil);
    
    DLCommentModel * comment = [[DLCommentModel alloc] init];
    comment.user = user;
    comment.toUser = user;
    comment.content = @"买了个二手QQ ? ";
    
    DLCommentModel * comment_1 = [[DLCommentModel alloc] init];
    comment_1.user = user;
    comment_1.content = @"小家伙, 站住别跑, 在跑爷打你了啊, 还跑？ 还跑？还跑？在跑爷打你了啊, 还跑？ 还跑？还跑? ";
    
    
    index % 2 == 0 ? (layout.comments = [NSArray arrayWithObjects:comment, comment_1, comment_1, comment, comment, nil]) : (layout.comments = nil);
    
    [self.displayLayouts addObject:layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
