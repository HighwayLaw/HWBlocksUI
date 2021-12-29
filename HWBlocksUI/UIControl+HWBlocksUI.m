//
//  UIControl+HWBlocksUI.m
//  TestApp
//
//  Created by liuhaiwei on 2021/12/22.
//

#import "UIControl+HWBlocksUI.h"
#import "HWBlocksUIProxy.h"
#import "objc/runtime.h"

static void *HWBlocksUIHandlersDicKey = &HWBlocksUIHandlersDicKey;


@interface UIControl (HWBlocksUI)

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, HWControlEventsActionBlock> *handlersDic;

@end

@implementation UIControl (HWBlocksUI)

#pragma mark - public methods

- (void)setHandler:(HWControlEventsActionBlock)eventsHandler forControlEvents:(UIControlEvents)controlEvents {
    NSAssert(eventsHandler, @"eventsHandler cannot be nil");

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
        @(UIControlEventValueChanged),
        @(UIControlEventEditingDidBegin),
        @(UIControlEventEditingChanged),
        @(UIControlEventEditingDidEnd),
        @(UIControlEventEditingDidEndOnExit),
        @(UIControlEventAllTouchEvents),
        @(UIControlEventAllEditingEvents),
        @(UIControlEventApplicationReserved),
        @(UIControlEventSystemReserved),
        @(UIControlEventAllEvents),
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
        case UIControlEventValueChanged: {
            [self addTarget:target action:@selector(handleValueChanged:) forControlEvents:UIControlEventValueChanged];
            break;
        }
        case UIControlEventEditingDidBegin: {
            [self addTarget:target action:@selector(handleEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            break;
        }
        case UIControlEventEditingChanged: {
            [self addTarget:target action:@selector(handleEditingChanged:) forControlEvents:UIControlEventEditingChanged];
            break;
        }
        case UIControlEventEditingDidEnd: {
            [self addTarget:target action:@selector(handleEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            break;
        }
        case UIControlEventEditingDidEndOnExit: {
            [self addTarget:target action:@selector(handleEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
            break;
        }
        default:
            break;
    }
}

#pragma mark - setters

- (void)setHandlersDic:(NSMutableDictionary<NSNumber *,HWControlEventsActionBlock> *)handlersDic {
    objc_setAssociatedObject(self, HWBlocksUIHandlersDicKey, handlersDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters

- (NSMutableDictionary<NSNumber *,HWControlEventsActionBlock> *)handlersDic {
    NSMutableDictionary *resultDic = objc_getAssociatedObject(self, &HWBlocksUIHandlersDicKey);
    if (!resultDic) {
        resultDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, HWBlocksUIHandlersDicKey, resultDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return resultDic;
}

@end
