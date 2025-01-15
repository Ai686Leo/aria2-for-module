**🇬🇧English** | [🇨🇳中文](README.md) 

# aria2-for-module
Running aria2 and ariang with root module manager (Magisk/KernelSU/APatch)

# Required and optional configurations
 1. **After installing the module, you need to set the Aria2 RPC address to aria2-127-0-0-1.nip.io in the Web UI**, if you don't want to use this address please check the following
 
2. The module generates a default aria2 configuration, which you can replace
 
3. The module contains a self-signed root certificate and a set of self-signed certificates and keys for aria2 to open HTTPS, if you feel insecure, you can replace them

# FAQs
 1. What is 1.aria2-127-0-0-1.nip.io? --- This domain is provided by [nip.io](nip.io), you can go to that site to see what it is
 
 2. Why is aria2-127-0-0-1.nip.io? --- Module Manager opens the Web UI using HTTPS by default, and Module Manager doesn't seem to be able to use addresses like 127.0.0.1 and localhost. I'm not looking for a solution at this stage, but if you want to use a local address, you can build your own server and use localhost (your certificate is signed for localhost).

 3. How do I use a custom address? --- You need to sign the domain name after pointing it to a local address, see [this](https://blog.csdn.net/xiejianweifdd/article/details/132520188) and [ this](https://www.gworg.com/ssl/832.html)
 
 4. Can't connect to aria2? --- Please check if the certificate signature is expired, please check the logs (located in the module directory), please check if the aria2 configuration file is correct, please check if the certificate is correct, please check if the system's certificate system is different from that of Android 15 and below (15 and above may not be an error either)

# Project dependencies
The project contains [**aria2**](https://github.com/aria2/aria2), [**AriaNG**](https://github.com/mayswind/AriaNg)

The files for these two items in the module are copyrighted by the original authors

———————————
 
由中文版使用deepl翻译而来，可能意思有误

Translated from the Chinese version using deepl, the meaning may be wrong
