//
//  TimeLineDisplayLayout.m
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import "TimeLineDisplayLayout.h"

//------------------------------------------------------------------------------

@implementation DLUser

@end

@implementation DLImageModel

@end

@implementation DLVideoModel

@end

@implementation DLSharedModel

@end

@implementation DLLocationModel

@end

@implementation DLCommentModel

- (void) setContent: (NSString *) content {
    
    _content = content;
    
    UIFont * font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.];
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]
                                                   initWithString:_user.nickName
                                                   attributes:@{
                                                                NSFontAttributeName : font,
                                                                NSForegroundColorAttributeName : ASDisplayNodeDefaultTintColor()
                                                                }];
    // 是否是回复
    if ( _toUser ) {
        
        [attributeString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:@"回复"
                                                 attributes:@{
                                                              
                                                              NSFontAttributeName : font,
                                                              NSForegroundColorAttributeName : RGB(81, 81, 81)
                                                              
                                                              }]];
        [attributeString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:_toUser.nickName
                                                 attributes:@{
                                                              
                                                              NSFontAttributeName : font,
                                                              NSForegroundColorAttributeName : ASDisplayNodeDefaultTintColor()
                                                              
                                                              }]];
    }
    
    [attributeString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:[NSString stringWithFormat:@": %@", _content]
                                             attributes:@{
                                                          
                                                          NSFontAttributeName : font,
                                                          NSForegroundColorAttributeName : RGB(81, 81, 81)
                                                          
                                                          }]];
    _comment = attributeString;
}

@end

//------------------------------------------------------------------------------

@implementation TimeLineDisplayLayout

@end
