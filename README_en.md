**🇬🇧English** | [🇨🇳中文](README.md) 

# Aria2 for Android Module

Run the aria2 download service and AriaNg Web UI on Android devices using module managers such as Magisk/KernelSU/APatch.

## 📋 Essential Post-Installation Configuration

1. **RPC Address Configuration**
   
   - Within the AriaNg Web UI, set the Aria2 RPC address to: `aria2-127-0-0-1.nip.io`
   - For custom address usage, refer to the instructions below
2. **Configuration File**
   
   - The module includes a default aria2 configuration file
   - You may replace the configuration file located in the `/data/adb/modules/aria2-Android/` directory as required
3. **Security Certificates**
   
   - The module provides a self-signed root certificate and HTTPS certificate
   - For enhanced security, you may replace the certificate files yourself
   - Certificate location: The `certs/` folder within the module's installation directory
4. **RPC Key**
   
   - Default key: `123456`
   - Can be modified in the configuration file
5. **Autostart Control**
   
   - To disable autostart, create an empty file named `noaria2` in the module directory
   - Alternatively, select this option using the volume keys during module installation

## ❓ Frequently Asked Questions

### Q1: What is `aria2-127-0-0-1.nip.io`?

A: This is a domain service provided by [nip.io](https://nip.io), which resolves domain names containing IP addresses to their corresponding IP addresses.

### Q2: Why must this domain be used instead of a local address?

A: Module managers typically require HTTPS access to the Web UI and cannot directly use local addresses like `127.0.0.1` or `localhost`. This solution circumvents that restriction.

**Note**: If you absolutely require a local address (e.g., `localhost`), you must: 1. Set up your own server environment 2. Add the certificate to both your user certificates and the browser's built-in certificate store (required by some browsers, e.g., Firefox). The module's included certificate is already signed for `localhost` and can be used directly.

### Q3: How do I configure a custom address?

Follow these steps:

1. Point the custom domain to your local address
2. Generate and configure an SSL certificate for that domain
3. Replace the certificate file within the module

Reference resources: [One](https://blog.csdn.net/xiejianweifdd/article/details/132520188) | [Two](https://www.gworg.com/ssl/832.html)

### Q4: What should I do if I cannot connect to aria2?

Please troubleshoot in sequence:

1. Verify whether the certificate has expired
2. Examine the log files within the module directory
3. Validate the syntax of the aria2 configuration file
4. Confirm the certificate configuration is correct
5. Android 15+ users should check system certificate compatibility
6. Ensure no proxy connection is enabled
7. Android 14+ users may encounter conflicts if other certificate modules are installed

### Q5: How to access the Web UI?

- **Recommended method**: Access via the module manager's Web UI functionality
- **Alternative approach**: Use plugins supporting Web UI access for modules

![Module Manager Interface Example](jpg/cn.jpg)

## 📁 Project Composition

This module integrates the following open-source projects:

- **[aria2](https://github.com/aria2/aria2)**
- **[AriaNg](https://github.com/mayswind/AriaNg)**

> Copyright for the above components remains with their respective original authors. This module serves solely as an integration package.


———————————

Translated from the Chinese version using deepl, the meaning may be wrong
