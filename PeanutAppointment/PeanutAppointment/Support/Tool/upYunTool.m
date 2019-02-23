//
//  upYunTool.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "upYunTool.h"
#import "UpYunBlockUpLoader.h"

#define UserPathName @"user"

@implementation upYunTool

+ (void)upImage:(UIImage *)image successHandle:(void (^) (NSString *url) )success failureHandle:( void (^) (NSError *error) )failure{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *fileData = [PATool compressOriginalImage:image toMaxDataSizeKBytes:1024];
        NSLog(@"fileData---length ---%ld",fileData.length);
        UIImage *smallImage = [UIImage imageWithData:fileData];
        
        NSString *fileName = [self getDateString];
        NSString *filePath = [self saveImage:smallImage withFileName:fileName];
        
        UpYunBlockUpLoader *up = [[UpYunBlockUpLoader alloc] init];
        NSString *savePath = [NSString stringWithFormat:@"%@%@.png",UpYunUserPic,fileName];
        NSLog(@"savePath -- %@%@",UpYunURL,savePath);
        
        [up uploadWithBucketName:UpYunSpaceName operator:UpYunOprater password:UpYunPassword filePath:filePath savePath:savePath success:^(NSHTTPURLResponse *response, NSDictionary *responseBody) {
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) success([NSString stringWithFormat:@"%@%@",UpYunURL,savePath]);
            });
        } failure:^(NSError *error, NSHTTPURLResponse *response, NSDictionary *responseBody) {
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) failure(error);
            });
        } progress:nil];
        
    });
    
}



+(NSString *)saveImage:(UIImage *)image withFileName:(NSString *)fileName {
    //缓存目录
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    //拼接文件夹目录
    NSString *path = [paths[0]stringByAppendingPathComponent:UserPathName];
    
    //判断createPath路径文件夹是否已存在，此处createPath为需要新建的文件夹的绝对路径
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        //创建文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //拼接目标文件目录
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",fileName]];
    //保存图片
    [UIImagePNGRepresentation([image fixOrientation]) writeToFile: filePath    atomically:YES];
    
    return filePath;
}


+ (NSString *)getDateString {
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"timeString === %@",timeString);
    //防止时间一样 加随机数
    int x = arc4random() % 100;
    [timeString stringByAppendingString:[NSString stringWithFormat:@"%d",x]];
    NSLog(@"timeString ==随机= %@",timeString);
    return timeString;
}



@end
