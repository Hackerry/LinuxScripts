# LinuxScripts
This project contains various Linux scipts.<br>

CentOS: PS1="\[\033[31m\][\T]\[\033[34m\]\u@ \[\033[32m\]\w:\[\033[0m\]\$ "<br>
Ubuntu: PS1='\\[\033[31m\\][\T]\\[\033[01;34m\\]\u@ \\[\033[32m\\]\w:\\[\033[0m\\]$ '<br>

To use ssh behind VPN using a proxy with gitbash and openssh:<br>
Edit "~/.ssh/config" file and add "ProxyCommand /bin/connect.exe -H proxy.server.name:3128 %h %p"<br>

To add proxy for a specific host only:<br>
Host <custom name>
  User <user>
  Port 22
  Hostname <hostname or ip>
  IdentityFile <id_rsa>
  TCPKeepAlive yes
  IdentitiesOnly yes
