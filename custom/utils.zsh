wechat() {
    current_path=$(pwd)
    cd $HOME/wechat/
    nohup docker-compose up >/dev/null 2>&1 &
    cd $current_path
}

tim() {
    current_path=$(pwd)
    cd $HOME/tencentqq/
    nohup docker-compose up >/dev/null 2>&1 &
    cd $current_path
}

set_proxy() {
    export HTTP_PROXY="http://127.0.0.1:7890"
    export HTTPS_PROXY="http://127.0.0.1:7890"
    echo "HTTP_PROXY is $HTTP_PROXY"
    echo "HTTPS_PROXY is $HTTPS_PROXY"
}

unset_proxy() {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    echo "HTTP_PROXY is $HTTP_PROXY"
    echo "HTTPS_PROXY is $HTTPS_PROXY"
}

set_default() {
    FILETYPE=$(xdg-mime query filetype $1)
    APP=$(find /usr/share -type f -name "*.desktop" -printf "%p\n" | fzf)
    APP=$(basename -- $APP)
    xdg-mime default "$APP" "$FILETYPE"
    echo "$APP set as default application to open $FILETYPE"
}

web_login() {
    para='callback=dr1003&login_method=1&user_account=291249&user_password=06152519lyl&wlan_user_ip=172.29.38.211&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.1.3&terminal_type=2&lang=en&lang=en'
    agent='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'
    curl -d $para http://172.30.255.42:801/eportal/portal/login
    echo "curl -d $para --user-agent $agent http://172.30.255.42:801/eportal/portal/login"
}

timer() {
    start=$(date +%s)
    while true; do
        time="$(($(date +%s) - $start))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    done
}

xv6-build() {
    make clean
    make
    make qemu
}
