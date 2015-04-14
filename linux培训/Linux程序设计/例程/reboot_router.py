#! /usr/bin/env python
#coding=utf-8

"""
soft reboot router

For WR740N 5.0/WR700N 1.0/WR340G 4.0 and descendent models

Note: this script can be only applied to Windows XP, neither Vista nor Win7
"""

import os
import sys
import time
import string
import subprocess
import urllib2

IS_CHINESE_VERSION = 1
ROUTER_ADMIN_IP = "192.168.1.253"

if IS_CHINESE_VERSION:
    reboot_url = string.Template("http://${router_admin_ip}/userRpm/SysRebootRpm.htm?Reboot=%D6%D8%C6%F4%C2%B7%D3%C9%C6%F7").substitute(router_admin_ip = ROUTER_ADMIN_IP)
else:
    reboot_url = string.Template("http://${router_admin_ip}/userRpm/SysRebootRpm.htm?Reboot=Reboot").substitute(router_admin_ip = ROUTER_ADMIN_IP)

def reboot_router():
    """
    reboot DUT
    
    NOTE: only support Chinese Edition
    """
    auth_handler = urllib2.HTTPBasicAuthHandler(urllib2.HTTPPasswordMgrWithDefaultRealm())
    auth_handler.add_password(None, string.Template("http://${router_admin_ip}/").substitute(router_admin_ip = ROUTER_ADMIN_IP), "admin", "admin")

    openerDirector = urllib2.build_opener(auth_handler)

    req = urllib2.Request(reboot_url)
    req.add_header("Host", ROUTER_ADMIN_IP)
    req.add_header("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5")
    req.add_header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    req.add_header("Accept-Language", "zh-cn,en-us;q=0.7,en;q=0.3")
    req.add_header("Accept-Encoding", "gzip,deflate")
    req.add_header("Accept-Charset", "ISO-8859-1,utf-8;q=0.7,*;q=0.7")
    req.add_header("Keep-Alive", "300")
    req.add_header("Connection", "keep-alive")
    req.add_header("Referer", string.Template("http://${router_admin_ip}/userRpm/SysRebootRpm.htm").substitute(router_admin_ip = ROUTER_ADMIN_IP))

    f = openerDirector.open(req)
    f.read()        # read response, but discard silently

    time.sleep(20)  # wait for router finish

    # is router really finished?
    po = subprocess.Popen(string.Template("ping ${router_admin_ip} -n 2").substitute(router_admin_ip = ROUTER_ADMIN_IP), 
                            stdout=subprocess.PIPE)
    
    if "Reply from" not in po.stdout.read():
        print "failed"
        os.system("pause")
        sys.exit(-1)
    
    po.wait()

def counter_generator():
    """
    generate infinite counter
    """
    i = 0
    while True:
        yield i
        i = i + 1

def main():
    for i in counter_generator():
        reboot_router()
        print i, "reboot passed"
    
    os.system("pause")
    sys.exit(0)

if __name__ == '__main__':
    main()