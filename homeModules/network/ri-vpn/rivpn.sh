#!/usr/bin/env sh

binary='rivpn'
service='ri-vpn.service'

url='https://jenkins.prod.awscentral.ri-tech.io/'
timeout=5

testConnection() {
    echo "Attempting to resolve $url"
    sleep 2
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
