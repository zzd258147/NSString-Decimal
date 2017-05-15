//
//  NSString+Decimal.m
//
//
//  Created by zzd on 08/05/2017.
//  Copyright © 2017 yourcompany. All rights reserved.
//

#import "NSString+Decimal.h"

#define CHECK_NOT_A_NUMBER(Number)                                      \
    if ([Number compare:NSDecimalNumber.notANumber] == NSOrderedSame) { \
        return nil;                                                     \
    }

#define CHECK_ZERO(Number)                                        \
    if ([Number compare:NSDecimalNumber.zero] == NSOrderedSame) { \
        return nil;                                               \
    }

@implementation NSString (Decimal)

- (NSDecimalNumber *)decimalNumber {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    return [NSDecimalNumber decimalNumberWithString:string];
}

#pragma mark -
- (NSString *)add:(NSString *)string {
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    NSDecimalNumber *right = [string decimalNumber];
    CHECK_NOT_A_NUMBER(right);
    return [left decimalNumberByAdding:right].stringValue;
}

- (NSString *)subtract:(NSString *)string {
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    NSDecimalNumber *right = [string decimalNumber];
    CHECK_NOT_A_NUMBER(right);
    return [left decimalNumberBySubtracting:right].stringValue;
}

- (NSString *)multiply:(NSString *)string {
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    NSDecimalNumber *right = [string decimalNumber];
    CHECK_NOT_A_NUMBER(right);
    return [left decimalNumberByMultiplyingBy:right].stringValue;
}

- (NSString *)divide:(NSString *)string {
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    NSDecimalNumber *right = [string decimalNumber];
    CHECK_NOT_A_NUMBER(right);
    CHECK_ZERO(right); // Zero can not be used as a denominator.
    return [left decimalNumberByDividingBy:right].stringValue;
}

#pragma mark -
- (NSString *)raisingToPower:(NSUInteger)power {
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    return [left decimalNumberByRaisingToPower:power].stringValue;
}

- (NSString *)multiplyingByPowerOf10:(short)power {
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    return [left decimalNumberByMultiplyingByPowerOf10:power].stringValue;
}

#pragma mark -
- (NSString *)roundingAccordingToRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale {
    BOOL isNegative = [[self decimalNumber] compare:NSDecimalNumber.zero] == NSOrderedAscending;
    NSDecimalNumber *left = [(isNegative ? [@"0" subtract:self] : self) decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSString *result = [left decimalNumberByRoundingAccordingToBehavior:handler].stringValue;
    return isNegative ? [@"0" subtract:result] : result;
}

- (NSString *)roundToScale:(short)scale {
    return [self roundingAccordingToRoundingMode:NSRoundPlain scale:scale];
}

- (NSString *)roundDownToScale:(short)scale {
    return [self roundingAccordingToRoundingMode:NSRoundDown scale:scale];
}

- (NSString *)roundUpToScale:(short)scale {
    return [self roundingAccordingToRoundingMode:NSRoundUp scale:scale];
}

- (NSString *)roundBankersToScale:(short)scale {
    return [self roundingAccordingToRoundingMode:NSRoundBankers scale:scale];
}

#pragma mark -
- (NSComparisonResult)compareDecimalValue:(NSString *)string {
    return [[self decimalNumber] compare:[string decimalNumber]];
}

#pragma mark -
+ (NSNumberFormatter *)sharedNumberFormatter {
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
    });
    return numberFormatter;
}

- (NSString *)currencyStyleToScale:(short)scale {
    if ([self isEqualToString:@"-"]) {
        return self;
    }
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    NSNumberFormatter *numberFormatter = [NSString sharedNumberFormatter];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.minimumFractionDigits = scale;
    numberFormatter.maximumFractionDigits = scale;
    return [numberFormatter stringFromNumber:[[self roundToScale:scale] decimalNumber]];
}

- (NSString *)currencyStyle {
    return [self currencyStyleToScale:2];
}

- (NSString *)noStyle {
    if ([self isEqualToString:@"-"]) {
        return self;
    }
    NSDecimalNumber *left = [self decimalNumber];
    CHECK_NOT_A_NUMBER(left);
    NSNumberFormatter *numberFormatter = [NSString sharedNumberFormatter];
    numberFormatter.numberStyle = NSNumberFormatterNoStyle;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.maximumFractionDigits = INT_MAX;
    return [numberFormatter stringFromNumber:left];
}

@end
