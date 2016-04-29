//
//  TimeLineDisplayLayout.h
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, DLContentType) {

    DLContentType_MutiImage = 0,
    DLContentType_Video = 1,
    DLContentType_Shared = 2,
};

@interface DLUser : NSObject

@property ( nonatomic, strong ) NSString * uid;
@property ( nonatomic, strong ) NSString * nickName;
@property ( nonatomic, strong ) NSURL * avatarURL;

@end

@interface DLImageModel : NSObject

@property ( nonatomic, strong ) NSURL * thumbURL;
@property ( nonatomic, strong ) NSURL * originURL;

@property ( nonatomic ) CGFloat width;
@property ( nonatomic ) CGFloat height;

@property ( nonatomic, strong ) NSString * desc;

@end

@interface DLVideoModel : NSObject

@property ( nonatomic, strong ) NSURL * videoURL;
@property ( nonatomic, strong ) NSString * desc;

@end

@interface DLSharedModel : NSObject

@property ( nonatomic, strong ) NSURL * URL;
@property ( nonatomic, strong ) NSURL * logoURL;
@property ( nonatomic, strong ) NSString * desc; // 2 lines.

@end

@interface DLLocationModel : NSObject

@property ( nonatomic, strong ) CLLocation * location;
@property ( nonatomic, strong ) NSString * locationName;

@end

@interface DLCommentModel : NSObject

@property ( nonatomic, strong ) DLUser * user;
@property ( nonatomic, strong ) DLUser * toUser;
@property ( nonatomic, strong ) NSString * content;
@property ( nonatomic, strong ) NSAttributedString * comment;

@end

@interface TimeLineDisplayLayout : NSObject

//------------------------------------------------------------------------------
// account

@property ( nonatomic, strong ) DLUser * user;

//------------------------------------------------------------------------------
// content

@property ( nonatomic, assign ) DLContentType contentType;

@property ( nonatomic, strong ) NSString * content; // text content
@property ( nonatomic, strong ) NSArray < DLImageModel * > * images; // muti image.
@property ( nonatomic, strong ) DLVideoModel * video;
@property ( nonatomic, strong ) DLSharedModel * share;

//------------------------------------------------------------------------------
// informations

@property ( nonatomic, strong ) DLLocationModel * location;
@property ( nonatomic, assign ) NSTimeInterval timestamp;
@property ( nonatomic, strong ) NSArray < NSString * > * referred;

//------------------------------------------------------------------------------
// favour and comments

@property ( nonatomic, strong ) NSArray < DLUser * > * favour;
@property ( nonatomic, strong ) NSArray < DLCommentModel * > * comments;

@end
