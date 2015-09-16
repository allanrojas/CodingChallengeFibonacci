//
//  MOBMainViewController.m
//  CodingChallengeFibonacci
//
//  Created by Allan Rojas on 9/15/15.
//  Copyright (c) 2015 Mobiquity, Inc. All rights reserved.
//

#import "MOBMainViewController.h"

@interface MOBMainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation MOBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentIndex = 0;
    self.items = @[].mutableCopy;
    
    [self loadItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Private

- (void) loadItems {
    
    for (int i = 0; i <= 20; i++) {
        self.items[self.currentIndex] = @([self fib:self.currentIndex]);
        self.currentIndex++;
    }
    
    [self.tableView reloadData];
}

- (NSUInteger)fib:(NSUInteger)x {
    NSUInteger result = 0;
    if (x <= 1) {
        result = x;
    } else {
        NSUInteger y1 = (NSUInteger)[self.items[x-1] integerValue];
        NSUInteger y2 = (NSUInteger)[self.items[x-2] integerValue];
        result = y1 + y2;
    }
    return result;
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellItemIdentifier = @"itemIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellItemIdentifier];
    
    if (indexPath.row == self.items.count -1) {
        [self loadItems];
    }
    
    UILabel *lbl = (UILabel*)[cell.contentView viewWithTag:100];
    lbl.text = [NSString stringWithFormat:@"Fib for %lu is: %@", indexPath.row, [self.items[indexPath.row] stringValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
