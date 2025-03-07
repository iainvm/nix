#!/usr/bin/env sh

binary='rivpn'
service='ri-vpn.service'

url='https://jenkins.prod.awscentral.ri-tech.io/'
timeout=30

testConnection() {
    echo "Attempting to resolve $url"
    until curl --max-time "$timeout" --silent --head --output /dev/null "$url"; do
        echo "Timed out request, trying again"
    done
    echo "Connection confirmed. VPN operational..."
}

case "$1" in
    start)
        systemctl --user start "$service"
        sleep 2
        testConnection
        ;;
    stop)
        systemctl --user stop "$service"
        ;;
    status)
        systemctl --user status "$service"
        ;;
    *)
        echo "Usage: $binary {start|stop|status}"
        ;;
esac
