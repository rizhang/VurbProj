//
//  CardModel.h
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CardModel : NSObject
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* thumbNailUrl;

/*!
 * Subclasses will override this method so they can insert their customviews
 */
-(void) getCustomUIViewWithView: (UIView*) viewToUpdate;

@end
