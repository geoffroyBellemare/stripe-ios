//
//  STPPaymentMethodPrzelewy24Tests.m
//  StripeiOS Tests
//
//  Created by Vineet Shah on 4/23/20.
//  Copyright © 2020 Stripe, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "STPAPIClient+Private.h"
#import "STPPaymentIntent+Private.h"
#import "STPPaymentMethod.h"
#import "STPPaymentMethodPrzelewy24.h"
#import "STPTestingAPIClient.h"

@interface STPPaymentMethodPrzelewy24Tests : XCTestCase

@property (nonatomic, readonly) NSDictionary *przelewy24JSON;

@end

@implementation STPPaymentMethodPrzelewy24Tests

- (void)_retrievePrzelewy24JSON:(void (^)(NSDictionary *))completion {
    if (self.przelewy24JSON) {
        completion(self.przelewy24JSON);
    } else {
        STPAPIClient *client = [[STPAPIClient alloc] initWithPublishableKey:STPTestingDefaultPublishableKey];
        [client retrievePaymentIntentWithClientSecret:@"pi_1GbFK2FY0qyl6XeWQ37XICJV_secret_6KKrMKcONxH3oM6XldyyIGj9s"
                                               expand:@[@"payment_method"]
                                           completion:^(STPPaymentIntent * _Nullable paymentIntent, __unused NSError * _Nullable error) {
            self->_przelewy24JSON = paymentIntent.paymentMethod.przelewy24.allResponseFields;
            completion(self.przelewy24JSON);
        }];
    }
}

- (void)testCorrectParsing {
    [self _retrievePrzelewy24JSON:^(NSDictionary *json) {
        STPPaymentMethodPrzelewy24 *przelewy24 = [STPPaymentMethodPrzelewy24 decodedObjectFromAPIResponse:json];
        XCTAssertNotNil(przelewy24, @"Failed to decode JSON");
    }];
}

@end
