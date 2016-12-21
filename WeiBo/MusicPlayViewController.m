//
//  MusicPlayViewController.m
//  WeiBo
//
//  Created by Luobu on 24/11/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "MusicPlayControlView.h"

@interface MusicPlayViewController ()

@property(strong, nonatomic) UIImageView *musicBg;


@end

@implementation MusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    MusicPlayControlView *controlView = [[MusicPlayControlView alloc] init];
    controlView.frame = self.view.bounds;
    [self.view addSubview:controlView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
