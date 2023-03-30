//
//  CommonRefreshFooter.m
//  LiveCoach
//
//  Created by mutou on 2022/11/09.
//

#import "CommonRefreshFooter.h"

@implementation CommonRefreshFooter

- (void)prepare {
    [super prepare];

}

- (void)placeSubviews {
    [super placeSubviews];
    self.stateLabel.hidden = YES;
    self.refreshingTitleHidden = YES;
}

@end
