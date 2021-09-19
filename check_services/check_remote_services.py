import socket
import requests
import json
import time
import sys
import os

server_ip = "http://docker.qwe"

if len (sys.argv) > 1:
    server_ip = "http://" + sys.argv[1]
    print("checking remote host...")
    
    response = os.system("ping -c 4 " + sys.argv[1])
    if response == 0:
        print("remote host is up")
    else:
        print("remote host does not exist")
        sys.exit()
else:
    print("using host by default")
    print(server_ip)

ip_list = open(os.path.dirname(os.path.realpath(__file__)) + "/ip_list", "r")
lines = ip_list.readlines()
while True:
    for line in lines:

        ip, separator, port = line.rpartition(':')
        #assert separator
        port = int(port)
        
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            s.connect((ip, port))
        except socket.error:
            print(ip, port)
            print("Not available")
            host_addr = str(ip) + ":" + str(port)
            data = {'failed': host_addr}
            headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
            r = requests.post(server_ip, data=json.dumps(data), headers=headers)
        finally:
            s.close()
    print("pause")
    time.sleep(60)

ip_list.close
