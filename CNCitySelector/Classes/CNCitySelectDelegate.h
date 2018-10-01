//
//  CNCitySelectDelegate.h
//  Pods
//
//  Created by Enix Yu on 2018/10/1.
//

#ifndef CNCitySelectDelegate_h
#define CNCitySelectDelegate_h

#import <Foundation/Foundation.h>

@class CNRegion;

@protocol CNCitySelectDelegate <NSObject>

- (void)didSelectRegion:(CNRegion *)region;

@end

#endif /* CNCitySelectDelegate_h */
