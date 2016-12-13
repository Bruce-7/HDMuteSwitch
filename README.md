# HDMuteSwitch

HDMuteSwitch是一个检测iPhone手机是否静音.

### Examples【示例】

```

[[HBMuteSwitch shareInstance] detectMuteSwitch:^(BOOL muted) {       	  
 	if (muted) {         
 	 	// 静音         						      	
 		[[HBMuteSwitch shareInstance] repeatPlaySystemSoundVibrate]; 	    
 	} else {       											      	 
   		[[HBMuteSwitch shareInstance] repeatPlaySystemSoundVibrate]; 	         
   		// 播放其他自己定义的声音或者歌曲     								 
    } 																	
}];																	

```

### CocoaPods

推荐使用CocoaPods安装

platform :ios, '7.0'

target :'your project' do

pod 'HDMuteSwitch'

end

Pod install

### Manually【手动导入】

通过 Clone or download 下载 HDMuteSwitch 文件夹内的所有内容.

将 HDMuteSwitch 内的源文件添加(拖放)到你的工程.

导入#import "HDMuteSwitch.h".

添加 AudioToolbox.framework依赖库 

### 补充

类似微信语音通话和语音视频处理逻辑.

##### 如果在使用过程中遇到BUG, 希望你能Issues我. 如果对你有所帮助请Star

##### Twitter : [@Bruce_7_Seven](https://twitter.com/Bruce_7_Seven)

##### 感谢@Rich2k共享的代码和思路.[@Rich2k](https://github.com/Rich2k/RBDMuteSwitch)

## License

HDMuteSwitch is released under the MIT license. See LICENSE for details.