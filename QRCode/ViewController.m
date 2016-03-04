//
//  ViewController.m
//  QRCode
//
//  Created by ivy.sun on 16/3/4.
//  Copyright © 2016年 zxh. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)btn1Click:(id)sender;
- (IBAction)btn2Click:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;


@end

@implementation ViewController
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return <#expression#>
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return  YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//生成二维码
- (IBAction)btn1Click:(id)sender {
    NSString *str = self.textField.text;
    self.imageView1.image = [self CreatQRCodeWithString:str ImageName:nil QRcodeSize:self.imageView1.bounds.size];
}
//生成带图片的二维码
- (IBAction)btn2Click:(id)sender {
    NSString *str = self.textField.text;
    self.imageView2.image = [self CreatQRCodeWithString:str ImageName:@"22" QRcodeSize:self.imageView2.bounds.size];
}

-(UIImage *)CreatQRCodeWithString:(NSString *)str ImageName:(NSString *)imageName QRcodeSize:(CGSize)size
{
    if (str==nil || [str isEqualToString:@""]) {
        str = @"你没有输入文字哦~";
    }
    //创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //初始化滤镜
    [filter setDefaults];
    //DATa化字符串
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //传入data给filter
    [filter setValue:data forKeyPath:@"inputMessage"];
    //生成二维码
    CIImage *outputImage = [filter outputImage];
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    if(imageName==nil) return image;
    
    //如果带图片，则通过绘图将图片水印至二维码中
    UIImage *avatar = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    CGRect rect = CGRectMake(size.width/5*2, size.height/5*2, size.width/5.0, size.height/5.0);
    [avatar drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
@end
