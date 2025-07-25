**🇨🇳中文** | [🇬🇧English](README_en.md)

# aria2-for-module
使用root模块管理器（Magisk/KernelSU/APatch）运行aria2和ariang

# 必要和可选的配置
1.**在安装完模块后，你需要在Web UI中将Aria2 RPC地址设置为 aria2-127-0-0-1.nip.io**，若不想使用此地址请查看下文
 
2.模块会生成默认的aria2配置，你可以替换他
 
3.模块含有一个自签名根证书和一个用于aria2开启HTTPS的自签名证书和密钥，如果觉得不安全，你可以替换他们
 
4.默认RPC密钥为123456，可自行在配置文件更改

5.aria2可设置为开机不自启动，需要在此模块目录添加名为noaria2的文件

# 常见问题
1.aria2-127-0-0-1.nip.io是什么？——— 此域名由[nip.io](nip.io)提供，你可以前往该网站查看这是什么
 
2.为什么是aria2-127-0-0-1.nip.io？——— 模块管理器默认使用HTTPS打开Web UI，并且模块管理器貌似并不能使用像127.0.0.1和localhost这样地址，现阶段没有找解决的方法，如果就想使用本地地址的话可以自建服务器（客户端浏览器可能还需要把证书添加进用户证书和浏览器自带证书）后使用localhost（自带证书也对localhost签名了）

3.如何使用自定义地址？——— 你需要将域名指向本地地址后进行签名，可参考[这个](https://blog.csdn.net/xiejianweifdd/article/details/132520188)和[这个](https://www.gworg.com/ssl/832.html)
 
4.无法连接到aria2？———
 
   -a.请检查证书签名是否过期
 
   -b.请检查日志（位于模块目录）
 
   -c.请检查aria2配置文件是否正确
 
   -d.请检查证书是否正确
 
   -e.请检查系统的证书系统是否与Android15及以下不同（15以上可能也不会出错）
 
   -f.在模块管理器连不上时，请检查RPC地址是否正确，以及是否关闭了代理（不是指Web UI里的设置项）
 
   -g.请检查是否有其他证书模块，同时Android版本≥14，可能会有冲突

5.Web UI在哪里？激活在哪里？——— 在模块管理器中。如果找不到，可能是你的模块管理器缺少相关功能？正常的话应该是图示的样子。如果管理器不支持，你可以用专门打开Web UI的应用（手机上的浏览器可能用不了该Web UI，即使是打包好的，这也是为什么我把它们写成了模块）
  ![截屏](jpg/cn.jpg)

# 项目依赖
该项目包含[**aria2**](https://github.com/aria2/aria2)、[**AriaNG(Web UI)**](https://github.com/mayswind/AriaNg)

模块中这两个项目的文件版权归原作者所有
