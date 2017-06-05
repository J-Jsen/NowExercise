//
//  IconViewController.m
//  NowExercise
//
//  Created by mac on 17/3/23.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "IconViewController.h"

@interface IconViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic , strong) UIImageView * imageV;

@end

@implementation IconViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = THEMECOLOR;
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64)];
    self.imageV.backgroundColor = THEMECOLOR;
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV.image = self.image;
    
    [self.view addSubview:self.imageV];
    
}

- (void)createNavigationView{
    
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 22)];
//    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [btn setTitle:@"个人信息" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
//    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"头像.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    
    self.navigationItem.rightBarButtonItem = right;
//
//    
    
    //关闭导航栏毛玻璃效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = COLOR(31, 31, 31);
    //导航栏标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:HEIGHT_6(20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"个人头像";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 返回
- (void)leftBarButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark 修改头像按钮
- (void)rightBarButtonClick{
    [LSActionSheet showWithTitle:@"更换头像" destructiveTitle:@"保存图片" otherTitles:@[@"拍照",@"从手机相册里选择"] block:^(int index) {
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];

        switch (index) {
            case 0://拍照
            {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

            }
                break;
            case 1://手机相册
            {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

            }
                break;
            case 2://保存图片
            {
                    UIImageWriteToSavedPhotosAlbum(_imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                return;
            }
                break;
                
            default:
                break;
        }
        
        // 2.允许编辑
        imagePickerController.allowsEditing = YES;
        // 3.设置代理
        imagePickerController.delegate = self;
        // 4.显示照片选择控制器
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [self presentViewController:imagePickerController animated:YES completion:nil];

        
    }];
    
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [HttpRequest showAlertWithTitle:msg];
}
#pragma mark - UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSString* url = [NSString stringWithFormat:@"%@api/?method=user.set_headimg", BASEURL];
    NSData *data  = UIImageJPEGRepresentation(info[UIImagePickerControllerEditedImage], 1);
    __weak typeof(self) weakSelf = self;

    [HttpRequest postWithUrl:url params:nil body:@[@{@"myfiles":data}] progress:nil success:^(NSDictionary *responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.iconBackBlock(info[UIImagePickerControllerEditedImage]);
            _imageV.image = info[UIImagePickerControllerEditedImage];
            [HttpRequest showAlertWithTitle:@"上传成功"];
            
        });
    }];
    
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
