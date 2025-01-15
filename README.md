**🇨🇳中文** | [🇬🇧English](README_en.md)

# aria2-for-module
使用root模块管理器（Magisk/KernelSU/APatch）运行aria2和ariang

# 必要和可选的配置
1.**在安装完模块后，你需要在Web UI中将Aria2 RPC地址设置为 aria2-127-0-0-1.nip.io**，若不想使用此地址请查看下文
 
2.模块会生成默认的aria2配置，你可以替换他
 
3.模块含有一个自签名根证书和一个套用于aria2开启HTTPS的自签名证书和密钥，如果觉得不安全，你可以替换他们

# 常见问题
1.aria2-127-0-0-1.nip.io是什么？——— 此域名由[nip.io](nip.io)提供，你可以前往该网站查看这是什么
 
2.为什么是aria2-127-0-0-1.nip.io？——— 模块管理器默认使用HTTPS打开Web UI，并且模块管理器貌似并不能使用像127.0.0.1和localhost这样地址，现阶段没有找解决的方法，如果就想使用本地地址的话可以自建服务器后使用localhost（自带证书也对localhost签名了）

3.如何使用自定义地址？——— 你需要将域名指向本地地址后进行签名，可参考[这个](https://blog.csdn.net/xiejianweifdd/article/details/132520188)和[这个](https://www.gworg.com/ssl/832.html)
 
4.无法连接到aria2？———
 
   -a请检查证书签名是否过期
 
   -b请检查日志（位于模块目录）
 
   -c请检查aria2配置文件是否正确
 
   -d请检查证书是否正确
 
   -e请检查系统的证书系统是否与Android15及以下不同（15以上可能也不会出错）
 
   -f在模块管理器连不上时，请检查RPC地址是否正确，以及是否开启了代理

# 项目依赖
该项目包含[**aria2**](https://github.com/aria2/aria2)、[**AriaNG**](https://github.com/mayswind/AriaNg)

模块中这两个项目的文件版权归原作者所有
