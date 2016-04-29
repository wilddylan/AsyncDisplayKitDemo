//
//  DLFavourAndComment.m
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import "DLFavourAndComment.h"
#import "DLFCellNode.h"
#import "TimeLineDisplayLayout.h"

@interface DLFavourAndComment () <ASTableViewDelegate, ASTableViewDataSource> {
    
    CGFloat textHeight;
    CGFloat commentHeight;
}

@property ( nonatomic, strong ) ASImageNode * imageNode;
@property ( nonatomic, strong ) ASTableNode * tableNode;
@property ( nonatomic, strong ) ASTextNode * favourNode;

@end

@implementation DLFavourAndComment

- (instancetype) initWithFavour: (NSArray < DLUser * > *)favours andComment: (NSArray < DLCommentModel * > *) comments {
    
    self = [super init];
    if ( self ) {
     
        _favours = favours;
        _comments = comments;
        
        _imageNode = [[ASImageNode alloc] init];
        _imageNode.image = [[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:30 topCapHeight:10];
        [self addSubnode:_imageNode];
        
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.view.asyncDelegate = self;
        _tableNode.view.asyncDataSource = self;
        _tableNode.view.backgroundColor = [UIColor clearColor];
        _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_imageNode addSubnode:_tableNode];
        
        // Header View
        _favourNode = [[ASTextNode alloc] init];
        
        NSTextAttachment * textAttach = [[NSTextAttachment alloc] init];
        textAttach.image = [UIImage imageNamed:@"Like"];
        textAttach.bounds = CGRectMake(0, -4, 15, 15);
        NSAttributedString * attribute = [NSAttributedString attributedStringWithAttachment:textAttach];
        
        NSMutableArray * array = [NSMutableArray array];
        [_favours enumerateObjectsUsingBlock:^(DLUser * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [array addObject:obj.nickName];
        }];
        
        UIFont * font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.];
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc]
                                           initWithString:[NSString stringWithFormat:@"[] %@", [array componentsJoinedByString:@", "]]
                                           attributes:@{
                                                        
                                                        NSFontAttributeName : font,
                                                        NSForegroundColorAttributeName : ASDisplayNodeDefaultTintColor()
                                                        
                                                        }];
        
        [str replaceCharactersInRange:NSMakeRange(0, 2) withAttributedString:attribute];
        
        _favourNode.attributedString = str;
        
        textHeight = [_favourNode.attributedString.string heightForWidth:SCREEN_WIDTH - 80
                                                                 andFont:font];
        commentHeight = 0;
        
        [_comments enumerateObjectsUsingBlock:^(DLCommentModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            commentHeight += [obj.comment.string heightForWidth:SCREEN_WIDTH - 80 andFont:font];
        }];
    }
    
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

- (ASLayoutSpec *) layoutSpecThatFits: (ASSizeRange) constrainedSize {
    
    _imageNode.preferredFrameSize = CGSizeMake(self.calculatedSize.width, commentHeight + textHeight + 15);
    _imageNode.flexShrink = YES;
    
    ASStackLayoutSpec * layout = [ASStackLayoutSpec horizontalStackLayoutSpec];
    [layout setChildren:@[_imageNode]];
    
    ASInsetLayoutSpec * inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 2) child:layout];
    
    return inset;
}

- (void) layout {
    
    [super layout];
    
    _favourNode.frame = CGRectMake(0,
                                   0,
                                   self.calculatedSize.width,
                                   textHeight + 3
                                   );
    
    _tableNode.view.tableHeaderView = _favourNode.view;
    
    ASDisplayNode * line = [[ASDisplayNode alloc] init];
    line.backgroundColor = RGB(221, 221, 221);
    line.frame = CGRectMake(0, CGRectGetMaxY(_favourNode.frame) - 1, self.calculatedSize.width, .6);
    [_tableNode.view.tableHeaderView addSubnode:line];
    
    _tableNode.view.frame = CGRectMake(5, 10, self.calculatedSize.width - 10, commentHeight + textHeight);
}

//------------------------------------------------------------------------------
#pragma mark - Delegate
//------------------------------------------------------------------------------

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    
    return 1;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    
    return _comments.count;
}

- (ASCellNode *) tableView: (ASTableView *) tableView nodeForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    DLFCellNode * textNode = [[DLFCellNode alloc] initWithComment:_comments[indexPath.row]];
    return textNode;
}

@end
