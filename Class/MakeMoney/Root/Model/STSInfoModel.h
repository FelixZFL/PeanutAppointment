//
//  STSInfoModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/10.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STSInfoModel : NSObject

///
@property (nonatomic, copy) NSString *accessKeyId;
///
@property (nonatomic, copy) NSString *securityToken;
///
@property (nonatomic, copy) NSString *accessKeySecret;
///
@property (nonatomic, copy) NSString *requestId;
///
@property (nonatomic, copy) NSString *expiration;


/*
 "accessKeyId": "STS.NJVY4JvCepuH8ZXsF15XpA1T1",
 
 "securityToken": "CAISgAJ1q6Ft5B2yfSjIr4njEo7+m5xEx7ejOnzpl0ZkOddcrvT/0zz2IHlOfXJoAOsbv/w3nmpW5/walqVoRoReREvCKM1565kPevBpzwaF6aKP9rUhpMCPKwr6UmzGvqL7Z+H+U6mqGJOEYEzFkSle2KbzcS7YMXWuLZyOj+wIDLkQRRLqL0AFZrFsKxBltdUROFbIKP+pKWSKuGfLC1dysQcO7gEa4K+kkMqH8Uic3h+oiM1t/tigfsP8PpIxYMchAo/lhtYbLPSRjHRijDFR77pzgaB+/jPKg8qQGVE54W/darCNqYU2d1IoPvBgQfAV9qDm+ON5tvPUhzY9A+y1t1o/GoABrAs8zk3YvDXbMFXkNNerafr4Cm3qMvENyPiCMD0BjzSFPFdUrDv2ZYQ9lS3dnzV8/Kf712FY3ltLxcl+Zt0pyw4ZEp+nObaUH8VM0ljOC3wBHndDh4rVF+oB+bfB+bgdqZBal/GoBwympRDWPOzX2dmqvgSyruIfguH4OwZL+28=",
 
 "accessKeySecret": "6cStjHfR2V67fJFRJFiQkdhDSEnRWk6SxkpPVuSmLXk3",
 
 "requestId": "B1ACE34E-3F4A-4AD6-9F8A-FB5E1566EC82",
 
 "expiration": "2018-10-06T08:39:27Z"
 */


@end

NS_ASSUME_NONNULL_END
