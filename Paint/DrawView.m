#import "DrawView.h"

#import "DrawPath.h"

@interface DrawView ()

@property (nonatomic, strong) NSMutableDictionary *paths;
@property (nonatomic, strong) NSMutableDictionary *pointIndex;
@property (nonatomic, strong) UIBezierPath *path;
@property int pathIndex;

@end


@implementation DrawView


- (void)awakeFromNib{
    _paintType = YES; //画笔YSE，橡皮擦NO，通过ViewController.m里面的（IBAction）eraser赋值
    _lineWidth = 2; //线的宽度
    _lineColor = [UIColor blackColor]; //线的颜色
    _pointIndex = [NSMutableDictionary dictionary]; //储存线的字典
    _pathIndex = 1; //第一条线的编号
}

- (NSMutableDictionary *)paths{
    if (_paths == nil) {
        _paths = [NSMutableDictionary dictionary];
    }
    return _paths;
}

// 当手指点击view,就需要记录下起始点
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 获取UITouch
    UITouch *touch = [touches anyObject];
    
    // 获取起始点
    CGPoint curP = [touch locationInView:self];
    
    // 只要一开始触摸控件,设置起始点
    DrawPath *path = [DrawPath path];
    
    path.lineColor = _lineColor;
    
    [path moveToPoint:curP];
    
    path.lineWidth = _lineWidth;
    
    // 记录当前正在描述的路径
    _path = path;
    
    if(_paintType == YES){ // 只有画笔的时候才储存线条
        // 保存当前的路径
        [self.paths setObject:path forKey:[NSString stringWithFormat:@"%d", _pathIndex]];
        _pathIndex++;
    }
}

// 每次手指移动的时候调用
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // 获取UITouch
    UITouch *touch = [touches anyObject];
    
    // 获取当前触摸点
    CGPoint curP = [touch locationInView:self];
    
    [_path addLineToPoint:curP];
    NSString *key = [[NSString alloc]initWithFormat:@"%d%@%d",(int)curP.x/10, @"_", (int)curP.y/10];
    if(_paintType!=NO){ // 如果是画笔，就储存
        [_pointIndex setObject:[[NSString alloc]initWithFormat:@"%d",_pathIndex-1] forKey:key];
    }else{//否则是橡皮擦，就移除这个对象
        NSString *indexString = [_pointIndex objectForKey:key]; //如果当前点在线条的字典里，就赋值线条的编号
        NSLog(@"%@", key);
        if(indexString!=nil){
            [_pointIndex removeObjectForKey:key];  // 擦出
            [_paths removeObjectForKey:indexString];  // 擦出
        }
    }
    
    // 重绘
    [self setNeedsDisplay];
    
}

// 绘制东西
- (void)drawRect:(CGRect)rect{
    
    for(NSString *pathKey in self.paths) {   // 正确的字典遍历方式
        
        DrawPath *path = [self.paths objectForKey:pathKey];
        
        if ([path isKindOfClass:[UIImage class]]) { // 图片
            UIImage *image = (UIImage *)path;
            
            [image drawAtPoint:CGPointZero];
        }else{
            
            [path.lineColor set];
            
            [path stroke];
        }
        
    }
}

@end
