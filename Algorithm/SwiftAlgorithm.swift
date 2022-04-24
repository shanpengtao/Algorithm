//
//  SwiftAlgorithm.swift
//  Algorithm
//
//  Created by 单鹏涛 on 2022/4/22.
//

import Foundation

public class  SwiftAlgorithm : NSObject
{
    @objc func startAlgorithmRoad () {
        print("==============Swift - Algorithm==============")
        
        // 第一题
        let r1 = self.r1(nums: [2,5,5,11], target: 10)
        print("r1:\(r1)")
    }
    
    func r1(nums : Array<Int>, target : Int) -> Array<Int> {
        
        var result = [Int](repeating: 0, count: 2)
        
        var map = [Int: Int]()
        for i in 0 ..< nums.count {
            map[nums[i]] = i
        }
        for i in 0 ..< nums.count {
            let a = target - nums[i]
            if map.keys.contains(a) && map[a] != i {
                result[0] = i
                result[1] = map[a] ?? 0
            }
        }
        
        return result
    }
    
}
