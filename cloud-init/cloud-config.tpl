#cloud-config
write_files:
  - encoding: b64
    path: /opt/synclounge/haproxy/haproxy.cfg
    permissions: '0644'
    content: ${base64encode(file("${path}/haproxy/haproxy.cfg"))}
  - encoding: b64
    path: /opt/synclounge/docker-compose.yml
    permissions: '0644'
    content: ${base64encode(file("${path}/docker/docker-compose.yml"))}
  - encoding: b64
    path: /opt/synclounge/install.sh
    permissions: '0755'
    content: ${base64encode(file("${path}/scripts/install.sh"))}
runcmd:
  - /opt/synclounge/install.sh ${web_accessurl} ${sl.room} ${sl.password}
