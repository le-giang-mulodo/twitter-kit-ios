/*
 * Copyright (C) 2017 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#import "TwitterAppAPIClient.h"
#import "TWTRAuthenticationConstants.h"
#import "TwitterAppAPIClient+Subclasses.h"

@implementation TwitterAppAPIClient

- (instancetype)initWithAuthConfig:(TWTRAuthConfig *)authConfig accessToken:(NSString *)accessToken
{
    NSParameterAssert(authConfig);
    NSParameterAssert(accessToken);

    self = [super initWithAuthConfig:authConfig];
    if (self) {
        _accessToken = [accessToken copy];
    }
    return self;
}

- (NSURLRequest *)URLRequestWithMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    NSURLRequest *request = [super URLRequestWithMethod:method URL:URLString parameters:parameters];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest setValue:[self authHeaderValue] forHTTPHeaderField:TWTRAuthorizationHeaderField];
    return mutableRequest;
}

- (NSString *)authHeaderValue
{
    NSAssert([self accessToken] != nil, TWTRMissingAccessTokenMsg);
    return [NSString stringWithFormat:@"Bearer %@", [self accessToken]];
}

@end