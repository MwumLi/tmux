# tmux

生成 tmux config  

## 为什么有这个项目?

通过这个项目的生成脚本，可以自动化解决下面两个问题:  

* 不同版本的 tmux 的某些配置是不一样的
* Mac 中终端中需要使用 [tmux-MacOSX-pasteboard](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard) 去解决 tmux 中无法使用剪贴板的问题  

## 使用

	$ git clone https://github.com/MwumLi/tmux.git
	$ cd tmux
	tmux $ ./gen.sh
