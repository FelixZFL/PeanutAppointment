//
//  AlivcLiveError.h
//  AlivcInteractiveLiveRoomSDK
//
//  Created by OjisanC on 2018/6/11.
//

#import <Foundation/Foundation.h>

@interface AlivcLiveError : NSObject

/**
 error description
 */
@property (nonatomic, strong) NSString* errorDescription;


/**
 error code
 */
@property (nonatomic, assign) NSInteger errorCode;

@end
