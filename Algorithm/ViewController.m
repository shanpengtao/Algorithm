//
//  ViewController.m
//  Algorithm
//  力扣算法按顺序完成
//
//  Created by 单鹏涛 on 2022/4/20.
//

#import "ViewController.h"
#import "OCAlgorithm.h"
#import "Algorithm-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    OCAlgorithm *ocAlgorithm = [OCAlgorithm new];
    [ocAlgorithm startAlgorithmRoad];
    
    SwiftAlgorithm *swiftAlgorithm = [SwiftAlgorithm new];
    [swiftAlgorithm startAlgorithmRoad];
    
}


@end
