#!/bin/sh

sysctlprop() {
    echo "sysctl -w $1 \"$2\""
    sysctl -w $1="$2"
}

# increase number of opened files
sysctlprop fs.file-max "1000000"

# increase TCP max buffer size setable using setsockopt()
sysctlprop net.core.rmem_max "16777216"
sysctlprop net.core.wmem_max "16777216"

# increase Linux autotuning TCP buffer limits
sysctlprop net.ipv4.tcp_rmem "4096 87380 16777216"
sysctlprop net.ipv4.tcp_wmem "4096 87380 16777216"

# http://www.cyberciti.biz/faq/linux-tcp-tuning/
sysctlprop net.ipv4.tcp_no_metrics_save "1"
sysctlprop net.core.netdev_max_backlog "10000"

# http://www.mjmwired.net/kernel/Documentation/networking/ip-sysctl.txt
# http://datatag.web.cern.ch/datatag/howto/tcp.html
sysctlprop net.ipv4.tcp_tw_recycle "1"
sysctlprop net.ipv4.tcp_tw_reuse "1"
sysctlprop net.ipv4.tcp_max_syn_backlog "262144"
sysctlprop net.ipv4.tcp_sack "0"

# listen() backlog limit for established sockets.
# unsigned int everywhere else except struct sock which has unsigned short.
sysctlprop net.core.somaxconn "262144"

# Increase the local port range. This alone has *huge* implications
# on the total number of sockets open before we start getting bind
# failures.
sysctlprop net.ipv4.ip_local_port_range "1024 65535"
# Increases the number of ARP cache entries to bypass the 
# linux OS related problems
sysctlprop net.ipv4.neigh.default.gc_thresh3 "80100"


#additional tweaks
sysctlprop net.ipv4.tcp_keepalive_time "60"
sysctlprop net.ipv4.tcp_keepalive_probes "3"
sysctlprop net.ipv4.tcp_keepalive_intvl "90"

