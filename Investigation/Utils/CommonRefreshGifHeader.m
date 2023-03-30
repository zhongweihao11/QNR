//
//  CommonRefreshGifHeader.m
//  LiveCoach
//
//  Created by mutou on 2022/10/25.
//

#import "CommonRefreshGifHeader.h"

@implementation CommonRefreshGifHeader

- (void)prepare {
    [super prepare];

}

- (void)placeSubviews {
    [super placeSubviews];
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
