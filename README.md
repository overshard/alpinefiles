# alpinefiles

Some of the files that I use on my Alpine Linux servers.


## Server quickstart guide

This quickstart requires that you have an Alpine Linux server running with a
domain name pointed to it. I'm currently using Linode as my host since they
support Alpine Linux nicely.

**TIP**: During the ufw portion to enable the firewall I recommend only allowing
your IP address or your ISP's IP address range which you can find on whois
lookups at the top. For example, replace `192.230.176.0/20` with your IP or your
ISP's IP range.

    ufw allow from 192.230.176.0/20 proto tcp to any port 22

I allow my local ISP's range because I have a DHCP lease from them and I get
tired of logging into my server from my hosting provider's UI to update it. It's
good enough security and much better than nothing!

I don't recommend running this script without downloading and modifying it for
your needs but you can if you want!

    curl -o- https://raw.githubusercontent.com/overshard/alpinefiles/master/quickstart.sh | sh
