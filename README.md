# All-In-One 系统深度优化模块 / System deep optimization module
模块集成了大部分功能，CPU 优化 / CPU 自动调控 / GPU 优化 / 提升存储空间读写速度等功能。详细可自行查看 system.prop 文件以及 service.sh 文件。

## 模块特色 / Feature
- 触摸屏优化 (提高全局触摸屏响应、提高滚动反映、开启硬件加速)
- 画面显示优化 (解锁 FPS 限制、减少缓冲区数量、开启垂直同步)
- 系统优化 (关闭内核日志、关闭蓝牙日志、优化 SDCard 性能、优化网络性能、默认关闭定位、禁用没啥用的 WPA 调试)
- SQLite 优化 (关闭 SQLite 日志、关闭 Wal SQLite 同步模式)
- CPU 优化 (后台应用 CPU 调控、优化 CPU 温控、优化 CPU 速度)
- GPU 优化 (开启 GPU 加速功能、优化 GPU 温控)
- 内存优化 (默认关闭 ZRAM、优化内存回收)
- TCP 网络优化