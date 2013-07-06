
#import "TOSampleViewController.h"
#import "TumbleOnUtils.h"

@interface TOSampleViewController () <TOSimpleTableViewDelegate>
@property (nonatomic, strong) TOSimpleTableView * simpleTableView;
@end

@implementation TOSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.dataSource == nil) {
        self.dataSource = [@[@"TOWidgetDemoViewController"] mutableCopy];
        
    }
    self.simpleTableView = [TOSimpleTableView wrapTableView:self.tableView dataSource:self.dataSource delegate:self];
}

- (UITableViewCell *)toSimpleTableView:(TOSimpleTableView *)simpleTableView createCellForObject:(NSObject *)object index:(int)index {
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableView.defaultCellIdentifier];
    cell.textLabel.text = [TOClassUtil prettyPrintClassNameFromString:(NSString*)object];
    return cell;
}

- (void)toSimpleTableView:(TOSimpleTableView *)simpleTableView objectSelected:(NSObject *)object index:(int)index cell:(UITableViewCell *)cell {
    [self push:(UIViewController *)toInit((NSString*)object)];
}


@end
