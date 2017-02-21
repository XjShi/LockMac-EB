# LockMac-EB
当你远离 Mac 时，自动锁定。

## 实现思路
把安装该软件的 Mac 作为 Central ，把 iPhone、iPad 等设备作为 Peripheral 。连接之后，根据信号强度来大致判断 Central 与 Peripheral 之间的距离。

## 使用
1. 输入设备名字（设置-通用-关于本机-名称）；
2. 确保 iPhone 蓝牙打开。

## 可以改进的地方
* UI ；
* iPhone、iPad 等设备在锁定之后，蓝牙无效。所以，可以对代码进行改进，以便用蓝牙设备的 UUID 来代替目前的方案。