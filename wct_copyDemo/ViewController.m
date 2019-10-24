//
//  ViewController.m
//  wct_copyDemo
//
//  Created by Wcting on 2019/10/23.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong)NSString *strCoptTest;/**<wct20191023 一个用strong修饰的NSString对象*/
//@property (nonatomic, copy)NSString *strCoptTest;/**<wct20191023 一个用copy修饰的NSString对象*/
@property (nonatomic, strong)Person *myPerson;/**<wct20191024 person*/
@property (nonatomic, copy)NSArray *arrList;/**<wct20191024 arrList*/
@property (nonatomic, copy)NSDictionary *dic;/**<wct20191024 dic*/


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self copyStringTest];
//    [self strongStringTest];
//    [self analyzeString];
    
//    [self arrCopyTest];
//    [self arrCopyTestString];
//    [self copyRetainCountTest];
    [self copyNSDictionaryTest];
    
}

//字符串对象测试拷贝类型代码
- (void)copyStringTest
{
    NSString *strTest = @"test string";
    NSLog(@"strTest:%@ address:%p",strTest,strTest);
    //浅拷贝，也叫指针拷贝。strCopy是strTest的浅拷贝对象，他两都指向同一块内存地址，如下打印地址。
    NSString *strCopy = [strTest copy];
    NSLog(@"strCopy:%@ address:%p",strCopy,strCopy);
    
    NSLog(@"------------------------------------------------");
    
    strTest = @"string copy";//重新赋值，等于原对象指向了一块新的内存地址，这种情况拷贝对象不受影响
    NSLog(@"strTest:%@ address:%p",strTest,strTest);
    NSLog(@"strCopy:%@ address:%p",strCopy,strCopy);
    NSLog(@"------------------------------------------------");
    
    //深拷贝，也叫内容拷贝，开辟一块新的内存地址，等于新创建了一个对象
    NSString *strMutableCopy = [strTest mutableCopy];
    strMutableCopy = @"string mutableCopy";
    
    NSLog(@"strTest:%@ address:%p",strTest,strTest);
    NSLog(@"strCopy:%@ address:%p",strCopy,strCopy);
    NSLog(@"strMutableCopy:%@ address:%p",strMutableCopy,strMutableCopy);
}

//NSString对象copy关键字测试
- (void)strongStringTest
{
    NSMutableString *strOriginal = [NSMutableString stringWithFormat:@"test string"];
    NSLog(@"strTest:%@ address:%p",strOriginal,strOriginal);
    /*
     *模拟浅拷贝操作，都指向一个地址
     *为什么不用[strOriginal copy]?因为strOriginal是NSMutableString类型，它的copy操作是深拷贝
     *而此处我们需要验证浅拷贝
     */
    self.strCoptTest = strOriginal;//如果self.strCoptTest用copy修饰，这句话等价于self.strCoptTest = [strOriginal copy];
    NSLog(@"strCopy:%@ address:%p",self.strCoptTest,self.strCoptTest);
    NSLog(@"---------------------修改原对象---------------------------");

    [strOriginal appendString:@"haha被修改了😆"];
    
    NSLog(@"原对象:%@ address:%p",strOriginal,strOriginal);
    NSLog(@"拷贝对象:%@ address:%p",self.strCoptTest,self.strCoptTest);
}

//集合类型数组自定义对象效果代码
- (void)arrCopyTest
{
    //新建三个Person对象
    Person *person1 = [[Person alloc] init];
    person1.name = @"p1";
    person1.age = @"18";
    person1.gender = @"M";
    
    Person *person2 = [[Person alloc] init];
    person2.name = @"p2";
    person2.age = @"19";
    person2.gender = @"M";
    
    Person *person3 = [[Person alloc] init];
    person3.name = @"p3";
    person3.age = @"17";
    person3.gender = @"W";
    
    NSMutableArray *arrMut = [NSMutableArray arrayWithObjects:person1,person2,person3, nil];

//    self.arrList = arrMut;//赋值，此时self.arrList等于arrMut
    self.arrList = [[NSArray alloc] initWithArray:arrMut copyItems:YES];//赋值，且深拷贝成员对象
    NSLog(@"============================修改arrMut值前============================");
    NSLog(@"修改arrMut值前:arrMut:%@ arrMutP:%p arrMut[0]P:%p",arrMut,arrMut,arrMut[0]);
    NSLog(@"修改arrMut值前:self.arrList:%@ self.arrListP:%p self.arrList[0]P:%p",self.arrList,self.arrList,self.arrList[0]);
    //修改arrMut内的值
    Person *personN = arrMut[0];
    personN.name = @"haha";
    
    NSLog(@"============================修改arrMut值后============================");
    NSLog(@"修改arrMut值后:arrMut:%@ arrMutP:%p arrMut[0]P:%p",arrMut,arrMut,arrMut[0]);
    NSLog(@"修改arrMut值后:self.arrList:%@ self.arrListP:%pself.arrList[0]P:%p",self.arrList,self.arrList,self.arrList[0]);
}

//集合类型数组非自定义对象效果代码
- (void)arrCopyTestString
{
    
    NSMutableArray *arrMut = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSLog(@"arrMut:%@ %p",arrMut,arrMut);
    self.arrList = arrMut;//赋值，此时self.arrList等于arrMut
    //修改arrMut内的值
    [arrMut insertObject:@"0" atIndex:0];
    NSLog(@"新增值后arrMut:%@ %p",arrMut,arrMut);

    
    NSLog(@"用copy修饰的情况 self.arrList:%@ %p",self.arrList,self.arrList);
}

//集合类型字典效果代码
- (void)copyNSDictionaryTest
{
    NSMutableDictionary *dicT = [NSMutableDictionary dictionaryWithDictionary:@{@"key":@"haha"}];
    
    self.dic = dicT;
    NSLog(@"dicT:%@ %p",dicT,dicT);

    [dicT setValue:@"heihei" forKey:@"key"];
    
    NSLog(@"dic:%@ %p",self.dic,self.dic);
    
}

//ARC下测试retainCount代码
- (void)copyRetainCountTest
{
    NSDictionary *dicT = @{@"key":@"haha"};
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTreeRef)dicT));
    
    NSDictionary *dicCopy = [dicT copy];
    
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTreeRef)dicT));

    NSDictionary *dicMutableCopy = [dicT mutableCopy];
    
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTreeRef)dicT));

}

@end
