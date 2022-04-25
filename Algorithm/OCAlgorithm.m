//
//  OCAlgorithm.m
//  Algorithm
//
//  Created by 单鹏涛 on 2022/4/22.
//

#import "OCAlgorithm.h"

@implementation OCAlgorithm

- (void)startAlgorithmRoad
{
    printf("==============ObjectC - Algorithm==============\n");

    // 第一题
    NSArray *r1 = [self r1:@[@2,@5,@5,@11] :10];
    NSLog(@"r1：%@", r1);
    
    // 第二题
    NSArray *r2 = [self r2:@[@2,@4,@9] :@[@5,@6,@4,@9]];
    NSLog(@"r2：%@", r2);
    
    // 第三题
    long r3 = [self r3:@"abcabcbb"];
    NSLog(@"r3：%ld", r3);
    
    // 第四题
    double r4 = [self r4:@[@1,@2] :@[@1]];
    NSLog(@"r4：%f", r4);

    // 第五题
    NSString *r5 = [self r5:@"fadbawea"];
    NSLog(@"r5：%@", r5);
    
    // 第五题
    NSString *r6 = [self r6:@"PAYPALISHIRING" :3];
    NSLog(@"r6：%@", r6);
}

/*
 ** 1. 两数之和 **
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。
 你可以按任意顺序返回答案。
 示例 1：
 输入：nums = [2,7,11,15], target = 9
 输出：[0,1]
 解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
 */
- (NSArray *)r1:(NSArray *)nums :(long)target
{
    if (nums.count < 2) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < nums.count; i++) {
        [dic setValue:@(i) forKey:nums[i]];
    }
    
    for (NSInteger i = 0; i < nums.count; i++) {
        long a = target - [nums[i] longValue];
        NSNumber *j = [dic objectForKey:@(a)];
        if (i != [j longValue] && j) {
            [result addObject:@(i)];
            [result addObject:[dic objectForKey:@(a)]];
            return result;
        }
    }
    
    return result;
}

/*
 ** 2. 两数相加 **
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
 请你将两个数相加，并以相同形式返回一个表示和的链表。
 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 示例 1：
 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 */
- (NSArray *)r2:(NSArray *)l1 :(NSArray *)l2
{
    NSMutableArray *result = [NSMutableArray array];
    NSMutableString *s1 = [NSMutableString string];
    for (long i = l1.count - 1; i >= 0; i--) {
        [s1 appendFormat:@"%@", l1[i]];
    }
    NSMutableString *s2 = [NSMutableString string];
    for (long i = l2.count - 1; i >= 0; i--) {
        [s2 appendFormat:@"%@", l2[i]];
    }
    NSLog(@"s1=%@",s1);
    NSLog(@"s2=%@",s2);
    NSString *str = [NSString stringWithFormat:@"%@", @([s1 longLongValue] + [s2 longLongValue])];
    for (long i = str.length - 1; i >= 0; i--) {
        [result addObject:[str substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return result;
}

/*
 ** 3. 无重复字符的最长子串 **
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。

 示例 1:
 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 */
- (long)r3:(NSString *)str
{
    if (str.length < 2) {
        return str.length;
    }
    long result = 0;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    long tmp = 0;
    for (long i = 0; i < str.length; i++) {
        NSString *cStr = [str substringWithRange:NSMakeRange(i, 1)];
        if ([dic valueForKey:cStr] != nil && [[dic valueForKey:cStr] longValue] > tmp) {
            tmp = [[dic valueForKey:cStr] longValue];
            [dic setValue:[NSNumber numberWithLong:i] forKey:cStr];
        }
        else {
            [dic setValue:[NSNumber numberWithLong:i] forKey:cStr];
            result = MAX(result, i - tmp);
        }
    }
    
    return result;
}


/*
 ** 4. 寻找两个正序数组的中位数 **
 给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。
 算法的时间复杂度应该为 O(log (m+n)) 。--> 目前实现了O(m+n)
 示例 1：
 输入：nums1 = [1,3], nums2 = [2]
 输出：2.00000
 解释：合并数组 = [1,2,3] ，中位数 2
 示例2
 输入：nums1 = [1,2], nums2 = [3,4]
 输出：2.50000
 解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5
 */
- (double)r4:(NSArray *)a1 :(NSArray *)a2
{
    // 双指针 分别记录2个数组的中位数的index
    NSInteger p1 = 0;
    NSInteger p2 = 0;
    // 数组长度
    NSInteger l1 = a1.count;
    NSInteger l2 = a2.count;
    NSInteger len = l1 + l2;
    // 中位数的所在值
    NSInteger cur = 0;
    NSInteger pre = 0;
    
    for (NSInteger i = 0; i <= floor(len/2); i++) {
        pre = cur;
        if (p1 < l1 && (p2>=l2 || [a1[p1] longValue] < [a2[p2] longValue])) {
            cur = [a1[p1] longValue];
            p1++;
        }
        else {
            cur = [a2[p2] longValue];
            p2++;
        }
    }
    
    return len%2==0 ? (cur+pre)/2.0 : cur;
}


/*
 5. 最长回文子串
 给你一个字符串 s，找到 s 中最长的回文子串。
 示例 1：
 输入：s = "babad"
 输出："bab"
 解释："aba" 同样是符合题意的答案。
 示例 2：
 输入：s = "cbbd"
 输出："bb"
 示例 3：
 输入：s = "cbd"
 输出："c"
 */
static NSInteger left = 0;
static NSInteger right = 0;
static NSInteger maxLength = 0;
- (NSString *)r5:(NSString *)str
{
    for (int i = 0; i < str.length; i++) {
        [self extend:str center1:i center2:i];
        [self extend:str center1:i center2:i+1];
    }
    
    return [str substringWithRange:NSMakeRange(left, maxLength)];
}
// i向左延展，j向右延展
- (void)extend:(NSString *)str center1:(NSInteger)i center2:(NSInteger)j
{
    while (i >= 0&& j < str.length && [[str substringWithRange:NSMakeRange(i, 1)] isEqualToString:[str substringWithRange:NSMakeRange(j, 1)]]) {
        if (j-i+1 > maxLength) {
            left = i;
            right = j;
            maxLength = j-i+1;
        }
        i--;
        j++;
    }
}
/*
 6. Z 字形变换
 将一个给定字符串 s 根据给定的行数 numRows ，以从上往下、从左到右进行 Z 字形排列。
 比如输入字符串为 "PAYPALISHIRING" 行数为 3 时，排列如下：
 P   A   H   N
 A P L S I I G
 Y   I   R
 之后，你的输出需要从左往右逐行读取，产生出一个新的字符串，比如："PAHNAPLSIIGYIR"。
 */
- (NSString *)r6:(NSString *)s :(int)numRows
{
    int tmp = 0;
    int flag = -1;
    NSMutableArray *array = [NSMutableArray array];
    
    for (long i = 0; i < s.length; i++) {
        NSString *cStr = [s substringWithRange:NSMakeRange(i, 1)];
        NSString *str = [NSString stringWithFormat:@"%@%@", (tmp < array.count ? array[tmp] : @""), cStr];
        array[tmp] = str;
        if (tmp == 0 || tmp == numRows - 1) {
            flag = -flag;
        }
        tmp += flag;
    }
    
    return [array componentsJoinedByString:@""];
}

@end
