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
    
    // 第六题
    NSString *r6 = [self r6:@"PAYPALISHIRING" :3];
    NSLog(@"r6：%@", r6);
    
    // 第七题
    NSInteger r7 = [self r7:-16158];
    NSLog(@"r7：%ld", r7);
    
    // 第八题
    NSInteger r8 = [self r8:@"  +232  "];
    NSLog(@"r8：%ld", r8);
    
    // 第九题
    BOOL r9 = [self r9:1223221];
    NSLog(@"r9：%d", r9);
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

/*
 7. 整数反转
 给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。
 如果反转后整数超过 32 位的有符号整数的范围 [−231,  231 − 1] ，就返回 0。
 假设环境不允许存储 64 位整数（有符号或无符号）。
 提示：
 -231 <= x <= 231 - 1
 示例 1：
 输入：x = 123
 输出：321
 */
- (NSInteger)r7:(NSInteger)x
{
    NSInteger res = 0;
    
    while (x != 0) {
        NSInteger digit = x % 10;
        x = x / 10;
        res = res * 10 + digit;
    }
    
    if (res < pow(-2, 31) || res > pow(2, 31) - 1) {
        res = 0;
    }
    
    return res;
}

/*
 8. 字符串转换整数 (atoi)
 请你来实现一个 myAtoi(string s) 函数，使其能将字符串转换成一个 32 位有符号整数（类似 C/C++ 中的 atoi 函数）。
 函数 myAtoi(string s) 的算法如下：
 读入字符串并丢弃无用的前导空格
 检查下一个字符（假设还未到字符末尾）为正还是负号，读取该字符（如果有）。 确定最终结果是负数还是正数。 如果两者都不存在，则假定结果为正。
 读入下一个字符，直到到达下一个非数字字符或到达输入的结尾。字符串的其余部分将被忽略。
 将前面步骤读入的这些数字转换为整数（即，"123" -> 123， "0032" -> 32）。如果没有读入数字，则整数为 0 。必要时更改符号（从步骤 2 开始）。
 如果整数数超过 32 位有符号整数范围 [−231,  231 − 1] ，需要截断这个整数，使其保持在这个范围内。具体来说，小于 −231 的整数应该被固定为 −231 ，大于 231 − 1 的整数应该被固定为 231 − 1 。
 返回整数作为最终结果。
 注意：
 本题中的空白字符只包括空格字符 ' ' 。
 除前导空格或数字后的其余字符串外，请勿忽略 任何其他字符。
 */
- (NSInteger)r8:(NSString *)str
{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    NSString *s = [str stringByTrimmingCharactersInSet:set];
    if (s.length == 0) return 0;
    
    NSInteger flag = 1;
    NSInteger res = 0;
    NSString *first = [s substringWithRange:NSMakeRange(0, 1)];
    if ([first isEqualToString:@"-"]) {
        flag = -1;
        s = [s substringFromIndex:1];
    }
    else if ([first isEqualToString:@"+"]) {
        s = [s substringFromIndex:1];
    }
    
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    for (int i = 0; i < s.length; i++) {
        NSString *c = [s substringWithRange:NSMakeRange(i, 1)];
        if ([array containsObject:c]) {
            res = res * 10 + c.integerValue;
        }
        else {
            break;
        }
    }
    res *= flag;
    
    
    return MAX(MIN(res, pow(2, 31) - 1), pow(-2, 31));
}

/*
 9. 回文数
 给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。
 回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
 例如，121 是回文，而 123 不是。
 示例 1：
 输入：x = 121
 输出：true
 */
- (BOOL)r9:(NSInteger)x
{
    NSString *s = [NSString stringWithFormat:@"%ld",x];
    NSMutableString *str = [NSMutableString string];
    for (NSInteger i = s.length - 1; i >= 0; i--) {
        [str appendString:[s substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return [str isEqualToString:s];
}


@end
