# SLCPageFlowLayout
SLCPageFlowLayout

1、卡片，居中放大，覆盖<br> 
```c
SLCPageFlowLayout *layout = [[SLCPageFlowLayout alloc] init];
layout.transformBlock = ^CGAffineTransform(CGFloat apartScale) {
	CGFloat scale = fabs(cos(apartScale * M_PI/4));
	return CGAffineTransformMakeScale(1.2, scale);
};
```
![1.png](https://github.com/hahajzy64/SLCPageFlowLayout/blob/master/result/1.png)

2、卡片、居中放大<br> 
```c
SLCPageFlowLayout *layout = [[SLCPageFlowLayout alloc] init];
layout.transformBlock = ^CGAffineTransform(CGFloat apartScale) {
    CGFloat scale = fabs(cos(apartScale * M_PI/4));
    return CGAffineTransformMakeScale(1.0, scale);
};
```
![2.png](https://github.com/hahajzy64/SLCPageFlowLayout/blob/master/result/2.png)

3、卡片<br> 
```c
SLCPageFlowLayout *layout = [[SLCPageFlowLayout alloc] init];
```

![3.png](https://github.com/hahajzy64/SLCPageFlowLayout/blob/master/result/3.png)
