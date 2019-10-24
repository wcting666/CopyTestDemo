//
//  Person.h
//  wct_copyDemo
//
//  Created by Wcting on 2019/10/24.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCopying>

@property (nonatomic, strong)NSString *name;/**<wct20191024 name*/
@property (nonatomic, strong)NSString *age;/**<wct20191024 age*/
@property (nonatomic, strong)NSString *gender;/**<wct20191024 gender*/


@end

NS_ASSUME_NONNULL_END
