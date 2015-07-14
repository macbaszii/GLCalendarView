//
//  ViewController.m
//  GLPeriodCalendar
//
//  Created by ltebean on 15-4-16.
//  Copyright (c) 2015 glow. All rights reserved.
//

#import "GLCalendarViewDemoController.h"
#import "GLCalendarView.h"
#import "GLCalendarDateRange.h"
#import "GLDateUtils.h"
#import "GLCalendarDayCell.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GLCalendarViewDemoController ()<GLCalendarViewDelegate>
@property (weak, nonatomic) IBOutlet GLCalendarView *calendarView;
@property (nonatomic, weak) GLCalendarDateRange *rangeUnderEdit;
@end

@implementation GLCalendarViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.calendarView.delegate = self;
    self.calendarView.showMaginfier = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSDate *today = [NSDate date];
        
    [self.calendarView reload];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarView scrollToDate:self.calendarView.lastDate animated:NO];
    });
}

- (BOOL)calenderView:(GLCalendarView *)calendarView canAddRangeWithBeginDate:(NSDate *)beginDate {
    
//    NSDate *today = [NSDate date];
//    if ([beginDate isEarlierThan:today]) {
//        return NO;
//    }
    
    return YES;
}

- (BOOL)calenderView:(GLCalendarView *)calendarView canUpdateRange:(GLCalendarDateRange *)range
         toBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate {
    
//    NSDate *today = [NSDate date];
//    if ([beginDate isEarlierThan:today]) {
//        return NO;
//    }
    return YES;
}

- (GLCalendarDateRange *)calenderView:(GLCalendarView *)calendarView rangeToAddWithBeginDate:(NSDate *)beginDate {
    if (self.calendarView.ranges.count == 1) {
        [self.calendarView.ranges removeAllObjects];
        [self.calendarView reload];
    }
    
    NSDate *endDate = beginDate;
    GLCalendarDateRange *range = [self dateRangeWithStartDate:beginDate
                                                   andEndDate:endDate];
    
    [self.calendarView beginToEditRange:range];
    
    return range;
}

- (GLCalendarDateRange *)dateRangeWithStartDate:(NSDate *)startDate
                                     andEndDate:(NSDate *)endDate {
    GLCalendarDateRange *range = [GLCalendarDateRange rangeWithBeginDate:startDate endDate:endDate];
    range.editable = YES;
    
    return range;
}

- (void)calenderView:(GLCalendarView *)calendarView beginToEditRange:(GLCalendarDateRange *)range {
    self.rangeUnderEdit = range;
}

- (void)calenderView:(GLCalendarView *)calendarView didUpdateRange:(GLCalendarDateRange *)range
         toBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate {
}

- (void)calenderView:(GLCalendarView *)calendarView finishEditRange:(GLCalendarDateRange *)range continueEditing:(BOOL)continueEditing {
    self.rangeUnderEdit = nil;
}

- (IBAction)deleteButtonPressed:(id)sender
{
    if (self.rangeUnderEdit) {
        [self.calendarView removeRange:self.rangeUnderEdit];
    }
}

@end
