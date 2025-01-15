**🇨🇳中文** | [🇬🇧English](README_en.md)

# aria2-for-module
使用root模块管理器（Magisk/KernelSU/APatch）运行aria2和ariang

# 必要和可选的配置
1.**在安装完模块后，你需要在Web UI中将Aria2 RPC地址设置为 aria2-127-0-0-1.nip.io**，若不想使用此地址请查看下文
 
2.模块会生成默认的aria2配置，你可以替换他
 
3.模块含有一个自签名根证书和一个套用于aria2开启HTTPS的自签名证书和密钥，如果觉得不安全，你可以替换他们

# 常见问题
1.aria2-127-0-0-1.nip.io是什么？——— 此域名由[nip.io](nip.io)提供，你可以前往该网站查看这是什么

2.为什么是aria2-127-0-0-1.nip.io？——— 模块管理器默认使用HTTPS打开Web UI，并且模块管理器貌似并不能使用像127.0.0.1和localhost这样地址，现阶段没有找解决的方法

如何使用自定义地址？——— 你需要将域名指向本地地址后进行签名


# 项目依赖
该项目包含[**aria2**](https://github.com/aria2/aria2)、[**AriaNG**](https://github.com/mayswind/AriaNg)

模块中这两个项目的文件版权归原作者所有
