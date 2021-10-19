//
//  OKScreenshotViewController.m
//

#import "OKScreenshotViewController.h"
#import <WebKit/WebKit.h>
#import <OneKit/OKSnapshotScroll.h>
#import <Photos/PHPhotoLibrary.h>
#import <OneKit/OKScreenshotTools.h>

@interface OKScreenshotViewController ()
@property (nonatomic,strong) WKWebView *webView;

@end

@implementation OKScreenshotViewController

- (void)viewDidLoad {
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
    self.webView.scrollView.bounces = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];

    NSString *urlStr = @"https://www.baidu.com/";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];//超时时间10秒
    //加载地址数据
    [self.webView loadRequest:request];

    self.title = @"截屏";
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *btn0 = [[UIBarButtonItem alloc] initWithTitle:@"全屏截图" style:UIBarButtonItemStylePlain target:self action:@selector(snapshotBtnClick)];
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"webview截图" style:UIBarButtonItemStylePlain target:self action:@selector(webviewSnapshotBtnClick)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:btn0, btn1, nil];
    
}

- (void)snapshotBtnClick {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
          onMainThreadAsync(^{
            [OKSnapshotScroll screenSnapshot:[UIApplication sharedApplication].keyWindow finishBlock:^(UIImage *snapshotImage) {
              [self saveImage:snapshotImage];
            }];
          });
        }
    }];
}

- (void)webviewSnapshotBtnClick {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
          onMainThreadAsync(^{
            [OKSnapshotScroll screenSnapshot:self.webView finishBlock:^(UIImage *snapshotImage) {
              [self saveImage:snapshotImage];
            }];
          });
        }
    }];
}



- (void)saveImage:(UIImage *)image {
  //save to photosAlbum
  UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
  if (error != NULL) {
      NSLog(@"save failed");
  } else {
      NSLog(@"save success");
  }
}

@end
