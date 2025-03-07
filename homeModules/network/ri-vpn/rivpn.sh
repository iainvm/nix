testURL='https://jenkins.prod.awscentral.ri-tech.io/'
case "$1" in
    start)
        systemctl --user start ri-vpn.service
        echo "Attempting to resolve $testURL"
        until curl --silent --head --output /dev/null --fail "$testURL"; do
            echo "Waiting for $testURL to resolve..."
            sleep 2  # Wait for 2 seconds before trying again
        done
        echo "$testURL reached. VPN confirmed started..."
        ;;
    stop)
        systemctl --user stop ri-vpn.service
        ;;
    status)
        systemctl --user status ri-vpn.service
        ;;
    *)
        echo "Usage: rivpn {start|stop|status}"
        ;;
esac
