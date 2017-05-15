//
//  NSString+Decimal.h
//
//
//  Created by zzd on 08/05/2017.
//  Copyright © 2017 yourcompany. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Decimal)

- (NSDecimalNumber *)decimalNumber;

- (NSString *)add:(NSString *)string;      // +
- (NSString *)subtract:(NSString *)string; // -
- (NSString *)multiply:(NSString *)string; // *
- (NSString *)divide:(NSString *)string;   // /

- (NSString *)raisingToPower:(NSUInteger)power;
- (NSString *)multiplyingByPowerOf10:(short)power;

- (NSString *)roundToScale:(short)scale;
- (NSString *)roundDownToScale:(short)scale;
- (NSString *)roundUpToScale:(short)scale;
- (NSString *)roundBankersToScale:(short)scale;

- (NSComparisonResult)compareDecimalValue:(NSString *)string;

- (NSString *)currencyStyleToScale:(short)scale;
- (NSString *)currencyStyle; // Accurate to two decimal places.
- (NSString *)noStyle;

@end

NS_ASSUME_NONNULL_END
