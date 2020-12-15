#import "ViewController.h"
#import "DrawView.h"
#import "MBProgressHUD+XMG.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (IBAction)eraser:(id)sender {
    _drawView.paintType = NO;
}


- (IBAction)paint:(id)sender {
    _drawView.paintType = YES;
    _drawView.lineColor = [UIColor blackColor];
}

@end
