# Linux

## Redhat
- [PERFORMANCE TUNING GUIDE](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/performance_tuning_guide/index)

## Network

- [Monitoring and Tuning the Linux Networking Stack: Receiving Data](https://blog.packagecloud.io/eng/2016/06/22/monitoring-tuning-linux-networking-stack-receiving-data/)
- [Linux networking stack from the ground up](https://www.privateinternetaccess.com/blog/2016/01/linux-networking-stack-from-the-ground-up-part-1/)

### Reverse path filtering

The max value below is used for source validation on network interface `$ifi`.

	/proc/sys/net/ipv4/conf/{all,$ifi}/rp_filter

### Tcpdump
- [A tcpdump Tutorial with Examples — 50 Ways to Isolate Traffic](https://danielmiessler.com/study/tcpdump/)

### UDP
- [Boost UDP Transaction Performance](https://events.static.linuxfound.org/sites/events/files/slides/LinuxConJapan2016_makita_160712.pdf).
- [The need for speed and the kernel datapath – recent improvements in UDP packets processing](https://developers.redhat.com/blog/2017/06/09/the-need-for-speed-and-the-kernel-datapath-recent-improvements-in-udp-packets-processing/)

## Jemalloc
MALLOC_CONF=tcache:false,prof:true,prof_leak:true,lg_prof_interval:34,lg_prof_sample:14

- lg_prof_interval: Average interval (log base 2) between memory profile dumps, as measured in bytes of allocation activity.
- lg_prof_sample: Average interval (log base 2) between allocation samples, as measured in bytes of allocation activity.

Generate graph

	jeprof $exe $j.heap --base=$i.heap --show_bytes --heapcheck --drop_negative --dot > $i_to_$j.dot


## Time

- [Measuring Latency in Linux](http://btorpey.github.io/blog/2014/02/18/clock-sources-in-linux/)
- [Pitfalls of TSC usage](http://oliveryang.net/2015/09/pitfalls-of-TSC-usage/)
- [Time is an illusion](https://queue.acm.org/detail.cfm?id=2878574)

`constant_tsc` indicates that the TSC runs at constant frequency irrespective
of P/T-states, and `nonstop_tsc` indicates that TSC does not stop in deep
C-states.

	$ cat /proc/cpuinfo | grep -E "constant_tsc|nonstop_tsc"

If TSC sync test passed during Linux kernel boot, following sysfs file would
export tsc as current clock source.

	$ cat /sys/devices/system/clocksource/clocksource0/current_clocksource

## Docker

- [Runtime options with Memory, CPUs, and GPUs](https://docs.docker.com/config/containers/resource_constraints/)

## K8s

- [So you want to expose a pod to multiple network interfaces? Enter Multus-CNI](http://dougbtv.com/nfvpe/2017/02/22/multus-cni/)
- [A Hacker’s Guide to Kubernetes Networking](https://thenewstack.io/hackers-guide-kubernetes-networking/)

### Flannel
- [Kubernetes: Flannel networking](https://blog.laputa.io/kubernetes-flannel-networking-6a1cb1f8ec7c)
- [Flannel Networking Demystify](https://msazure.club/flannel-networking-demystify/)

## Video
- [Programmer's Guide to Video Systems](https://lurkertech.com/lg/video-systems/)
