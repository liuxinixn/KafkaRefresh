/*************************************************************
 * Copyright (c) 2016-present, K.							 *
 * All rights reserved.										 *
 *															 *
 * e-mail: xorshine@icloud.com								 *
 * github:https://github.com/xorshine						 *
 *															 *
 * This source code is licensed under the MIT license.		 *
 *************************************************************/


#import "UIScrollView+KafkaConfiguration.h"
#import "UIScrollView+Kafka.h"
#import "KafkaRefreshStyle.h"
#import "KafkaReplicatorLayer.h"
#import "KafkaRefreshDefaults.h"

@implementation UIScrollView (KafkaConfiguration)

- (void)bindRefreshStyle:(KafkaRefreshStyle)style
			  fillColor:(UIColor *)fillColor
				atPosition:(KafkaRefreshPosition)position
			 refreshHanler:(KakfkaRefreshHandler)handler{
	__kindof KafkaRefreshControl *control = [self _classWithRefreshStyle:style color:fillColor position:position];
	if (!control) return;
	control.refreshHandler = handler;
	if (position == KafkaRefreshPositionHeader) {
		self.headRefreshControl = control;
	}else{
		self.footRefreshControl = control;
	}
}

- (void)bindDefaultRefreshStyleAtPosition:(KafkaRefreshPosition)position
							refreshHanler:(KakfkaRefreshHandler)handler{
	if (position == KafkaRefreshPositionHeader) {
		__kindof KafkaRefreshControl *control = [self _classWithRefreshStyle:[KafkaRefreshDefaults standardRefreshDefaults].headDefaultStyle
																	   color:[KafkaRefreshDefaults standardRefreshDefaults].fillColor
																	position:position];
		self.headRefreshControl = control;
		control.refreshHandler = handler;
	}else{
		__kindof KafkaRefreshControl *control = [self _classWithRefreshStyle:[KafkaRefreshDefaults standardRefreshDefaults].footDefaultStyle
																	   color:[KafkaRefreshDefaults standardRefreshDefaults].fillColor
																	position:position];
		self.footRefreshControl = control;
		control.refreshHandler = handler;
	}
}

- (__kindof KafkaRefreshControl *)_classWithRefreshStyle:(KafkaRefreshStyle)style
												   color:(UIColor *)color
												position:(KafkaRefreshPosition)position{
	KafkaRefreshControl *cls = nil;
	switch (style) {
		case KafkaRefreshStyleNative:{
			if (position == KafkaRefreshPositionHeader) {
				cls = [[KafkaNativeHeader alloc] init];
			}else{
				cls = [[KafkaNativeFooter alloc] init];
			} 
			break;
		}
			
		case KafkaRefreshStyleReplicatorWoody:
		case KafkaRefreshStyleReplicatorAllen:
		case KafkaRefreshStyleReplicatorCircle:
		case KafkaRefreshStyleReplicatorDot:
		case KafkaRefreshStyleReplicatorArc:
		case KafkaRefreshStyleReplicatorTriangle:{
			if (position == KafkaRefreshPositionHeader) {
				cls = [[KafkaReplicatorHeader alloc] init];
			}else{
				cls = [[KafkaReplicatorFooter alloc] init];
			}
			((KafkaReplicatorHeader *)cls).animationStyle = style - 1;
			break;
		}
			
		case KafkaRefreshStyleAnimatableRing:{
			if (position == KafkaRefreshPositionHeader) {
				cls = [[KafkaRingIndicatorHeader alloc] init];
			}else{
				cls = [[KafkaRingIndicatorFooter alloc] init];
			}
			break;
		}
			
		case KafkaRefreshStyleAnimatableArrow:{
			if (position == KafkaRefreshPositionHeader) {
				cls = [[KafkaArrowHeader alloc] init];
			}else{
				cls = [[KafkaArrowFooter alloc] init];
			}
			break;
		}
	}
	cls.fillColor = color;
	return cls;
}

@end


