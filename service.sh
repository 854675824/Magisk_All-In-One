# 延迟执行
sleep 1m
# 设置 CPU 应用分配
# 用户的后台应用（减少使用核心省电，影响后台下载，不过流畅）
echo "0-1" > /dev/cpuset/background/cpus
# 系统的后台应用（减少使用核心省电）
echo "0-2" > /dev/cpuset/system-background/cpus
# 前台的应用（不限制使用核心）
echo "0-7" > /dev/cpuset/foreground/cpus
# 显示在上层的应用（不限制使用核心）
echo "0-7" > /dev/cpuset/top-app/cpus


# 调节 CPU 激进度百分比%
# 前台的应用（100%会把cpu拉满）
echo "10" > /dev/stune/foreground/schedtune.boost
# 显示在上层的应用
echo "0" > /dev/stune/top-app/schedtune.boost
# 用户的后台应用（减少cpu乱跳，省电）
echo "0" > /dev/stune/background/schedtune.boost


# 核心分配优化
# 大核 提高这个值有利于性能，不利于降低功耗。
echo "40 40" > /proc/sys/kernel/sched_downmigrate
# 小核 提高这个值有利于降低功耗，不利于性能。
echo "60 60" > /proc/sys/kernel/sched_upmigrate

# GPU 温控 115度 极限120 到120会过热保护 
echo "115000" > /sys/class/thermal/thermal_zone32/trip_point_0_temp
# CPU 温控 修改为99度 
echo "99000" >/sys/class/thermal/thermal_zone36/trip_point_0_temp

# CPU 负载均衡，改1为核心均衡，2为软件均衡，可能只会有部分生效，是因为系统限制
echo 1 > /dev/cpuset/sched_relax_domain_level
echo 1 > /dev/cpuset/system-background/sched_relax_domain_level
echo 1 > /dev/cpuset/background/sched_relax_domain_level
echo 1 > /dev/cpuset/camera-background/sched_relax_domain_level
echo 1 > /dev/cpuset/foreground/sched_relax_domain_level
echo 1 > /dev/cpuset/top-app/sched_relax_domain_level
echo 1 > /dev/cpuset/restricted/sched_relax_domain_level
echo 1 > /dev/cpuset/asopt/sched_relax_domain_level
echo 1 > /dev/cpuset/camera-daemon/sched_relax_domain_level
# CPU 调整
echo 100 > /dev/stune/schedtune.boost
echo 100 > /dev/stune/foreground/schedtune.boost
echo 100 > /dev/stune/top-app/schedtune.boost
echo 20 > /dev/stune/background/schedtune.boost
echo 20 > /dev/stune/rt/schedtune.boost
echo 50 > /dev/stune/io/schedtune.boost
echo 50 > /dev/stune/camera-daemon/schedtune.boost
# CPU 调度
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
# 禁用 调度自动分组
echo 0 > /proc/sys/kernel/sched_autogroup_enabled
# 功耗换性能
echo 1 > /sys/module/ged/parameters/gx_game_mode
echo 47 > /sys/module/ged/parameters/gx_fb_dvfs_margin
echo 1 > /sys/module/ged/parameters/enable_cpu_boost
echo 1 > /sys/module/ged/parameters/enable_gpu_boost
echo 1 > /sys/module/ged/parameters/gx_dfps
echo 1 > /sys/devices/system/cpu/cpufreq/performance/boost
echo 1 > /sys/devices/system/cpu/cpufreq/performance/max_freq_hysteresis
echo 1 > /sys/devices/system/cpu/cpufreq/performance/align_windows
echo 0 > /sys/module/adreno_idler/parameters/adreno_idler_active
echo 1 > /sys/module/msm_performance/parameters/touchboost
echo -1 > /sys/kernel/fpsgo/fbt/thrm_limit_cpu
echo -1 > /sys/kernel/fpsgo/fbt/thrm_sub_cpu


# 通过DEBUG模式开启GPU加速
settings put global enable_gpu_debug_layers 0
settings put system debug.composition.type dyn
# 关闭内存压缩
settings put global "app_memory_compression" "0"
# 通过UBWC降低屏幕功耗
settings put global debug.gralloc.enable_fb_ubwc 1
# 关闭内存回收优化 低运存用户可删
settings put global persist.sys.purgeable_assets 1
# 关闭ZRAM 减少性能/磁盘损耗
settings put global zram_enabled 0 


# CPU 优化
echo "1" > /proc/cpu_loading/debug_enable
echo "1" > /proc/cpu_loading/uevent_enable
echo "68" > /proc/cpu_loading/overThrhld
echo "45" > /proc/cpu_loading/underThrhld
echo "68" > /proc/cpu_loading/specify_overThrhld
echo "7654" > /proc/cpu_loading/specify_cpus
# iostats 优化
echo "0" > /sys/block/mmcblk0/queue/iostats
echo "0" > /sys/block/sda/queue/iostats
echo "0" > /sys/block/sde/queue/iostats
# 页面簇优化
echo "0" > /proc/sys/vm/page-cluster
# 内核堆
echo 0 > /proc/sys/kernel/randomize_va_space
# 禁止压缩不可压缩的进程
echo 0 > /proc/sys/vm/compact_unevictable_allowed
#删除wlan_logs
rm -rf /data/vendor/wlan_logs





# TCP 优化
echo "
net.ipv4.conf.all.route_localnet=1
net.ipv4.ip_forward = 1
net.ipv4.conf.all.forwarding = 1
net.ipv4.conf.default.forwarding = 1
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.default.forwarding = 1
net.ipv6.conf.lo.forwarding = 1
net.ipv6.conf.all.accept_ra = 2
net.ipv6.conf.default.accept_ra = 2
net.core.netdev_max_backlog = 100000
net.core.netdev_budget = 50000
net.core.netdev_budget_usecs = 5000
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.rmem_default = 67108864
net.core.wmem_default = 67108864
net.core.optmem_max = 65536
net.core.somaxconn = 10000
net.ipv4.icmp_echo_ignore_all = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.all.rp_filter = 0
net.ipv4.tcp_keepalive_time = 8
net.ipv4.tcp_keepalive_intvl = 8
net.ipv4.tcp_keepalive_probes = 1
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syncookies = 0
net.ipv4.tcp_rfc1337 = 0
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 8
net.ipv4.ip_local_port_range = 1024 65535
net.ipv4.tcp_max_tw_buckets = 2000000
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192
net.ipv4.tcp_mtu_probing = 0
net.ipv4.tcp_autocorking = 0
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_max_syn_backlog = 30000
net.ipv4.tcp_notsent_lowat = 16384
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.tcp_frto = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv4.neigh.default.gc_thresh3=8192
net.ipv4.neigh.default.gc_thresh2=4096
net.ipv4.neigh.default.gc_thresh1=2048
net.ipv6.neigh.default.gc_thresh3=8192
net.ipv6.neigh.default.gc_thresh2=4096
net.ipv6.neigh.default.gc_thresh1=2048
net.ipv4.tcp_max_syn_backlog = 262144
net.netfilter.nf_conntrack_max = 262144
net.nf_conntrack_max = 262144
" > /data/sysctl.conf

chmod 777 /data/sysctl.conf

sysctl -p /data/sysctl.conf

ip route | while read r; do
ip route change $r initcwnd 20;
done

ip route | while read r; do
ip route change $r initrwnd 20;
done