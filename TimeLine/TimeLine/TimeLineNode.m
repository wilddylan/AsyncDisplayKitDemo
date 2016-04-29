//
//  TimeLineNode.m
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import "TimeLineNode.h"
#import "TimeLineDisplayLayout.h"
#import "DLMutiImageNode.h"
#import "DLSharedNode.h"
#import "DLFavourAndComment.h"

@interface TimeLineNode ()

//------------------------------------------------------------------------------
// head content

@property ( nonatomic, strong ) ASNetworkImageNode * avatarNode;
@property ( nonatomic, strong ) ASTextNode         * nickNameNode;
@property ( nonatomic, strong ) ASTextNode         * contentNode;

//------------------------------------------------------------------------------
// middle content

@property ( nonatomic, strong ) DLMutiImageNode * mutiImageNode; // max count: 9
@property ( nonatomic, strong ) ASVideoNode     * videoNode; // Video
@property ( nonatomic, strong ) DLSharedNode    * sharedNode; // URL

//------------------------------------------------------------------------------
// location, referred, time, show delete button if is my post, option button<favor, comment>

@property ( nonatomic, strong ) ASTextNode  * locationNode;
@property ( nonatomic, strong ) ASTextNode  * referredNode;
@property ( nonatomic, strong ) ASTextNode  * timeNode;
@property ( nonatomic, strong ) ASTextNode  * deleteNode;
@property ( nonatomic, strong ) ASImageNode * optionNode;

//------------------------------------------------------------------------------
// favor and comment

@property ( nonatomic, strong ) DLFavourAndComment * fcNode;

@property ( nonatomic, strong ) ASDisplayNode * sepLine;

@end

@implementation TimeLineNode

- (instancetype) initWithDisplayLayout: (TimeLineDisplayLayout *) displayLayout {
    
    self = [super init];
    if ( self ) {
    
        _displayLayout = displayLayout;
        [self initializeComponentWithLayout:_displayLayout];
    }
    
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

- (ASLayoutSpec *) layoutSpecThatFits: (ASSizeRange) constrainedSize {
    
    _avatarNode.preferredFrameSize = CGSizeMake(40, 40);
    
    // Right side
    ASStackLayoutSpec * content = [ASStackLayoutSpec verticalStackLayoutSpec];
    content.spacing = 1; // vertical spacing
    
    NSMutableArray * layoutableNode = [NSMutableArray arrayWithObjects:_nickNameNode, nil];
    
    if ( _displayLayout.content ) {
        
        [layoutableNode addObject:_contentNode];
    }
    
    switch (_displayLayout.contentType) {
            
        case DLContentType_MutiImage: {
            
            [layoutableNode addObject:_mutiImageNode];
            break;
        }
        case DLContentType_Video: {
            
            _videoNode.preferredFrameSize = CGSizeMake(SCREEN_WIDTH, 175);
            [layoutableNode addObject:_videoNode];
            break;
        }
        case DLContentType_Shared: {
            
            [layoutableNode addObject:_sharedNode];
            break;
        }
        default:
            
            break;
    }
    
    if ( _displayLayout.location ) {
        
        [layoutableNode addObject:_locationNode];
    }
    
    if ( _displayLayout.referred ) {
        
        [layoutableNode addObject:_referredNode];
    }
    
    // time and option image node
    ASLayoutSpec *spacer = [[ASLayoutSpec alloc] init];
    spacer.flexGrow = YES;
    
    ASStackLayoutSpec * timeAndOption = [ASStackLayoutSpec horizontalStackLayoutSpec];
    timeAndOption.spacing = 5;
    timeAndOption.alignItems = ASStackLayoutAlignItemsCenter;
    timeAndOption.justifyContent = ASStackLayoutJustifyContentStart;
    
    if ( [_displayLayout.user.uid isEqualToString:@"13088488288"] ) {
        
        [timeAndOption setChildren:@[_timeNode, _deleteNode, spacer, _optionNode]];
    } else {
        [timeAndOption setChildren:@[_timeNode, spacer, _optionNode]];
    }
    [layoutableNode addObject:timeAndOption];
    
    // comment and favour
    if ( _displayLayout.favour || _displayLayout.comments ) {
        
        [layoutableNode addObject:_fcNode];
    }
    
    content.alignItems = ASStackLayoutAlignItemsStretch;
    content.flexShrink = YES;
    [content setChildren:layoutableNode];
    
    // Layout avatar and right side
    ASStackLayoutSpec * avatarAndContent = [ASStackLayoutSpec horizontalStackLayoutSpec];
    avatarAndContent.spacing = 5;
    
    [avatarAndContent setChildren:@[_avatarNode, content]];
    
    // Padding 10 to CellNode
    ASInsetLayoutSpec * insetLayout = [ASInsetLayoutSpec
                                       insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                       child:avatarAndContent];
    
    return insetLayout;
}

- (void)layout {
    
    [super layout];
    
    _avatarNode.layer.cornerRadius = 1;
    _avatarNode.layer.masksToBounds = YES;
    _avatarNode.layer.borderWidth = .7;
    _avatarNode.layer.borderColor = RGB(201, 201, 201).CGColor;
    
    CGFloat pixelHeight = 1.0f / [[UIScreen mainScreen] scale];
    _sepLine.frame = CGRectMake(0.0f, self.calculatedSize.height - pixelHeight, self.calculatedSize.width, pixelHeight);
}

//------------------------------------------------------------------------------
#pragma mark - Common load
//------------------------------------------------------------------------------

- (void) initializeComponentWithLayout: (TimeLineDisplayLayout *) layout {
    
    // Load avatarNode
    _avatarNode = [[ASNetworkImageNode alloc] init];
    _avatarNode.placeholderColor = ASDisplayNodeDefaultPlaceholderColor();
    _avatarNode.URL = layout.user.avatarURL;
    [self addSubnode:_avatarNode];
    
    // Load nickNameNode
    _nickNameNode = [[ASTextNode alloc] init];
    _nickNameNode.attributedString = [[NSAttributedString alloc] initWithString:layout.user.nickName
                                                                     attributes:@{
                                                                                  
                                                                                  NSFontAttributeName : [UIFont fontForFontName:FontNameSTHeitiSCMedium size:16.],
                                                                                  NSForegroundColorAttributeName : ASDisplayNodeDefaultTintColor()
                                                                                  
                                                                                  }];
    [self addSubnode:_nickNameNode];
    
    // Load contentTextNode
    if ( layout.content ) {
        
        _contentNode = [[ASTextNode alloc] init];
        _contentNode.attributedString = [[NSAttributedString alloc] initWithString:layout.content
                                                                        attributes:@{
                                                                                     
                                                                                     NSFontAttributeName : [UIFont fontForFontName:FontNameSTHeitiSCLight size:14.],
                                                                                     NSForegroundColorAttributeName : RGB(101, 101, 101)
                                                                                     
                                                                                     }];
        [self addSubnode:_contentNode];
    }
    
    // Load content and load all
    switch (layout.contentType) {
            
        case DLContentType_MutiImage: {
         
            _mutiImageNode = [[DLMutiImageNode alloc] initWithMutiImage:layout.images];
            [self addSubnode:_mutiImageNode];
            break;
        }
        case DLContentType_Video: {
            
            _videoNode = [[ASVideoNode alloc] init];
            _videoNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
            _videoNode.asset = [AVAsset assetWithURL:layout.video.videoURL];
            [self addSubnode:_videoNode];
            break;
        }
        case DLContentType_Shared: {
            
            _sharedNode = [[DLSharedNode alloc] initWithShared:layout.share];
            [self addSubnode:_sharedNode];
            break;
        }
        default:
            
            break;
    }
    
    // Load commons
    if ( layout.location ) {
        
        _locationNode = [[ASTextNode alloc] init];
        _locationNode.attributedString = [[NSAttributedString alloc] initWithString:layout.location.locationName
                                                                         attributes:@{
                                                                                      
                                                                                      NSFontAttributeName : [UIFont fontForFontName:FontNameSTHeitiSCLight size:11.],
                                                                                      NSForegroundColorAttributeName : ASDisplayNodeDefaultTintColor()
                                                                                      
                                                                                      }];
        [self addSubnode:_locationNode];
    }
    
    if ( layout.referred ) {
        
        _referredNode = [[ASTextNode alloc] init];
        
        NSString * referredString = [NSString stringWithFormat:@"提到了: %@", [layout.referred componentsJoinedByString:@", "]];
        _referredNode.attributedString = [[NSAttributedString alloc] initWithString:referredString
                                                                         attributes:@{
                                                                                      
                                                                                      NSFontAttributeName : [UIFont fontForFontName:FontNameSTHeitiSCLight size:11.],
                                                                                      NSForegroundColorAttributeName : RGB(181, 181, 181)
                                                                                      
                                                                                      }];
        
        [self addSubnode:_referredNode];
    }
    
    _timeNode = [[ASTextNode alloc] init];
    
    NSString * timeStr =  [NSDate dateInformationDescriptionWithInformation:[NSDate dateWithTimeIntervalSince1970:layout.timestamp].dateInformation];
    _timeNode.attributedString = [[NSAttributedString alloc] initWithString:timeStr
                                                                     attributes:@{
                                                                                  
                                                                                  NSFontAttributeName : [UIFont fontForFontName:FontNameSTHeitiSCLight size:11.],
                                                                                  NSForegroundColorAttributeName : RGB(181, 181, 181)
                                                                                  
                                                                                  }];
    [self addSubnode:_timeNode];
    
    if ( [layout.user.uid isEqualToString:@"13088488288"] ) {
        
        _deleteNode = [[ASTextNode alloc] init];
        _deleteNode.attributedString = [[NSAttributedString alloc] initWithString:@"删除"
                                                                     attributes:@{
                                                                                  
                                                                                  NSFontAttributeName : [UIFont fontForFontName:FontNameSTHeitiSCLight size:11.],
                                                                                  NSForegroundColorAttributeName : ASDisplayNodeDefaultTintColor()
                                                                                  
                                                                                  }];
        [self addSubnode:_deleteNode];
    }
    
    _optionNode = [[ASImageNode alloc] init];
    _optionNode.image = [UIImage imageNamed:@"AlbumOperateMore"];
    [self addSubnode:_optionNode];
    
    // Favour and comments
    if ( layout.favour || layout.comments ) {
        
        _fcNode = [[DLFavourAndComment alloc] initWithFavour:layout.favour andComment:layout.comments];
        [self addSubnode:_fcNode];
    }
    
    _sepLine = [[ASDisplayNode alloc] init];
    _sepLine.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
    [self addSubnode:_sepLine];
}

@end
