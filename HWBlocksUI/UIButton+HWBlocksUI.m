//
//  UIButton+HWBlocksUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import "UIButton+HWBlocksUI.h"
#import "HWBlocksUIProxy.h"
#import "objc/runtime.h"

static void *HWBlocksUIClickHandlerKey = &HWBlocksUIClickHandlerKey;
static void *HWBlocksUIHandlersDicKey = &HWBlocksUIHandlersDicKey;


@interface UIButton (HWBlocksUI)

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, HWControlEventsActionBlock> *handlersDic;

@end

@implementation UIButton (HWBlocksUI)

#pragma mark - public methods

- (void)setEventsHandler:(HWControlEventsActionBlock)eventsHandler forControlEvents:(UIControlEvents)controlEvents {
    NSAssert(eventsHandler, @"clickHandler cannot be nil");
    if (controlEvents & UIControlEventTouchUpInside) {
        objc_setAssociatedObject(self, HWBlocksUIClickHandlerKey, eventsHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    static NSArray *allEvents = @[
        @(UIControlEventTouchDown),
        @(UIControlEventTouchDownRepeat),
        @(UIControlEventTouchDragInside),
        @(UIControlEventTouchDragOutside),
        @(UIControlEventTouchDragEnter),
        @(UIControlEventTouchDragExit),
        @(UIControlEventTouchUpInside),
        @(UIControlEventTouchUpOutside),
        @(UIControlEventTouchCancel),
    ];
    
    for (NSNumber *event in allEvents) {
        if (controlEvents & event.unsignedIntValue) {
            [self configTargetForEvent:event.unsignedIntValue];
            self.handlersDic[event] = eventsHandler;
        }
    }
}

- (HWControlEventsActionBlock)handlerForControlEvent:(UIControlEvents)controlEvent {
    return self.handlersDic[@(controlEvent)];
}

#pragma mark - private methods

- (void)configTargetForEvent:(UIControlEvents)event {
    HWBlocksUIProxy *target = [HWBlocksUIProxy sharedInstance];
    switch (event) {
        case UIControlEventTouchDown: {
            [self addTarget:target action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
            break;
        }
        case UIControlEventTouchDownRepeat: {
            [self addTarget:target action:@selector(handleTouchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
            break;
        }
        case UIControlEventTouchDragInside: {
            [self addTarget:target action:@selector(handleTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
            break;
        }
        case UIControlEventTouchDragOutside: {
            [self addTarget:target action:@selector(handleTouchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
            break;
        }
        case UIControlEventTouchDragEnter: {
            [self addTarget:target action:@selector(handleTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
            break;
        }
        case UIControlEventTouchDragExit: {
            [self addTarget:target action:@selector(handleTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
            break;
        }
        case UIControlEventTouchUpInside: {
            [self addTarget:target action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case UIControlEventTouchUpOutside: {
            [self addTarget:target action:@selector(handleTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
            break;
        }
        case UIControlEventTouchCancel: {
            [self addTarget:target action:@selector(handleTouchCancel:) forControlEvents:UIControlEventTouchCancel];
            break;
        }
        default:
            break;
    }
}

#pragma mark - setters

- (void)setClickHandler:(HWControlEventsActionBlock)clickHandler {
    [self setEventsHandler:clickHandler forControlEvents:UIControlEventTouchUpInside];
}

- (void)setHandlersDic:(NSMutableDictionary<NSNumber *,HWControlEventsActionBlock> *)handlersDic {
    objc_setAssociatedObject(self, HWBlocksUIHandlersDicKey, handlersDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters

- (HWControlEventsActionBlock)clickHandler {
    return objc_getAssociatedObject(self, &HWBlocksUIClickHandlerKey);
}

- (NSMutableDictionary<NSNumber *,HWControlEventsActionBlock> *)handlersDic {
    NSMutableDictionary *resultDic = objc_getAssociatedObject(self, &HWBlocksUIHandlersDicKey);
    if (!resultDic) {
        resultDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, HWBlocksUIHandlersDicKey, resultDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return resultDic;
}

@end
