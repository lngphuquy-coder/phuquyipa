#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#include <iostream>
#include <string>
#include <vector>
#include <random>
#include <algorithm>
#include <chrono>

// ==========================================================
// C++ KEY GENERATOR CORE ENGINE (Thuật toán C++ tạo Key bản quyền)
// ==========================================================
class OnyxzKeyEngine {
public:
    static std::string generateKey() {
        const std::string upperLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const std::string digits = "0123456789";

        std::mt19937 rng(static_cast<unsigned int>(
            std::chrono::high_resolution_clock::now().time_since_epoch().count()
        ));
        std::uniform_int_distribution<int> letterDist(0, upperLetters.size() - 1);
        std::uniform_int_distribution<int> digitDist(0, digits.size() - 1);

        std::string keyBody = "";

        // 1. Chọn đúng 7 chữ cái in hoa ngẫu nhiên
        for (int i = 0; i < 7; ++i) {
            keyBody += upperLetters[letterDist(rng)];
        }

        // 2. Chọn đúng 3 chữ số ngẫu nhiên
        for (int i = 0; i < 3; ++i) {
            keyBody += digits[digitDist(rng)];
        }

        // 3. Trộn ngẫu nhiên 10 ký tự lại với nhau
        std::shuffle(keyBody.begin(), keyBody.end(), rng);

        return "ONYXZ-" + keyBody;
    }
};

// ==========================================================
// OBJECTIVE-C++ VIEW CONTROLLER CHO ỨNG DỤNG IOS (.IPA)
// ==========================================================
@interface OnyxzMainViewController : UIViewController <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation OnyxzMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.03 green:0.04 blue:0.06 alpha:1.0];

    // Cấu hình WKWebView hiệu năng cao cho giao diện hoạt họa C++/HTML5
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;
    config.preferences.javaScriptEnabled = YES;

    // Cầu nối giao tiếp Native iOS và C++
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"onyxzNative"];
    config.userContentController = userContentController;

    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.backgroundColor = [UIColor colorWithRed:0.03 green:0.04 blue:0.06 alpha:1.0];
    self.webView.opaque = NO;

    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    [self.view addSubview:self.webView];

    // Tải trực tiếp file index.html nằm ngay bên trong gói App IPA (100% Offline độc lập)
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    if (htmlPath) {
        NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
        [self.webView loadFileURL:fileURL allowingReadAccessToURL:[fileURL URLByDeletingLastPathComponent]];
    }
}

// Xử lý thông điệp từ JavaScript gọi xuống mã nguồn C++
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"onyxzNative"]) {
        NSDictionary *body = message.body;
        NSString *action = body[@"action"];

        if ([action isEqualToString:@"copyToClipboard"]) {
            NSString *content = body[@"text"];
            if (content) {
                [UIPasteboard generalPasteboard].string = content;
            }
        } else if ([action isEqualToString:@"generateNativeCppKey"]) {
            std::string cppKey = OnyxzKeyEngine::generateKey();
            NSString *nsKey = [NSString stringWithUTF8String:cppKey.c_str()];
            NSString *jsCallback = [NSString stringWithFormat:@"if(window.onNativeKeyGenerated){ window.onNativeKeyGenerated('%@'); }", nsKey];
            [self.webView evaluateJavaScript:jsCallback completionHandler:nil];
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end

// ==========================================================
// APP DELEGATE
// ==========================================================
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    OnyxzMainViewController *rootVC = [[OnyxzMainViewController alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end

// ==========================================================
// MAIN ENTRY POINT
// ==========================================================
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
