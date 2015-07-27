1.在命令行 cd 到 mwsc 的 bin 目录
2.运行命令 mwsc -pico -prefix TSYWS_Method -d generated http://oa.ctitech.cn:5301/MobileWebService.asmx?wsdl 
3.-prefix 文件前缀，这里统一为 TSYWS_Method 
-d 生成到目录 generated，这里不会自己创建目录，所以我手动建好，不要删 
最后面是wsdl的URL
4.命令完成后拷贝整个generated文件夹到项目即可,注意这里生成的文件是非arc的需到工程中设置,方可编译通过.
5.执行此命令,电脑需已安装jdk
