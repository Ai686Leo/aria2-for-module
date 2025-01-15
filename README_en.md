**🇬🇧English** | [🇨🇳中文](README.md) 

# aria2-for-module
Running aria2 and ariang with root module manager (Magisk/KernelSU/APatch)

# Required and optional configurations
 1.**After installing the module, you need to set the Aria2 RPC address to aria2-127-0-0-1.nip.io in the Web UI**, if you don't want to use this address please check the following
 
2. The module generates a default aria2 configuration, which you can replace
 
3. The module contains a self-signed root certificate and a set of self-signed certificates and keys for aria2 to open HTTPS, if you feel insecure, you can replace them

# FAQs
 1.What is 1.aria2-127-0-0-1.nip.io? --- This domain is provided by [nip.io](nip.io), you can go to that site to see what it is
 
 2. Why is aria2-127-0-0-1.nip.io? --- Module Manager opens the Web UI using HTTPS by default, and Module Manager doesn't seem to be able to use addresses like 127.0.0.1 and localhost. I'm not looking for a solution at this stage, but if you want to use a local address, you can build your own server and use localhost (your certificate is signed for localhost).
 
 3. 
