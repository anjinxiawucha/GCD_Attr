//
//  ViewController.m
//  GCD_Attr
//
//  Created by WXA on 2018/8/22.
//  Copyright © 2018年 WXA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    [self relative_priorityAllArePositiveNumber];
    //
    //    [self relative_priorityAllAreNotPositiveNumbe];
    //    [self relative_priorityPositiveNumbeWithNotPositiveNumbe];
}


- (void)relative_priorityAllArePositiveNumber{
    
    dispatch_queue_attr_t attr1 = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE,1);
    dispatch_queue_t queueHeight    = dispatch_queue_create("com.dssd.gcd", attr1);
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, 2);
    dispatch_queue_t  queue = dispatch_queue_create("com.wxa.gcd", attr);
    
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"text2");
    });
    dispatch_async(queueHeight, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"text1");
    });
    /*说明CPU调度不受影响
     2018-08-18 14:34:26.930374+0800 GCD进阶[34730:1121267] text2
     2018-08-18 14:34:26.930393+0800 GCD进阶[34730:1121266] text1
     */
    
}

- (void)relative_priorityAllAreNotPositiveNumbe{
    
    
    dispatch_queue_attr_t attr1 = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE,-1);
    dispatch_queue_t queueHeight    = dispatch_queue_create("com.dssd.gcd", attr1);
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, 0);
    dispatch_queue_t  queue = dispatch_queue_create("com.wxa.gcd", attr);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"text2");
    });
    dispatch_async(queueHeight, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"text1");
    });
    /*说明CPU调度不受影响
     2018-08-18 14:36:40.913736+0800 GCD进阶[34819:1123952] text2
     2018-08-18 14:36:40.913819+0800 GCD进阶[34819:1123950] text1
     */
    
}

- (void)relative_priorityPositiveNumbeWithNotPositiveNumbe{
    
    dispatch_queue_attr_t attr1 = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE,-1);
    dispatch_queue_t queueHeight    = dispatch_queue_create("com.dssd.gcd", attr1);
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, 1);
    dispatch_queue_t  queue = dispatch_queue_create("com.wxa.gcd", attr);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"text2");
    });
    dispatch_async(queueHeight, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"text1");
    });
    /*说明CPU是先调度相对优先级是非正数然后才会调度正数的
     2018-08-18 14:38:41.283069+0800 GCD进阶[34899:1126406] text1
     2018-08-18 14:38:49.387927+0800 GCD进阶[34899:1126405] text2
     */
    
    
}




@end
