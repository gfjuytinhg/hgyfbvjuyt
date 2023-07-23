jdlirjjjfnnvldsjdssdksldkslm kknoneioieoiwefjkfdjfdjfkdjfklldkvkjlfldldkjjojjjfjjjjrjjjjfkdddddddddddddddddddddjjjjjjjjjjjfffffkkkdddd,,,,,,,sssskkkkffffffffffffhhhhhdjjjjdnhjkbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbllllllllllllllllllllllllllllllllllllllllllllllllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

gggggggggggggggggggggggggggggggggggggguuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuoooooooooooooooooooooooooooooooooooooo
bjdhhhhhhdoooosssslllllllllllsssss..../cldjjjjjjjjdnnnnnncccccccccccccnnnnnnnnncggduuuuufoooo
hhhhhhhhhhhhhhhhhhhhhh
jjjjjjjjjjjjsssssssssssskk
xxxxxxxxxxxxxxxxxxkkkkkkkkkkkkkkvvvvv
nnnnnnnnnnnnnnnnnnnnnnnnnnnnxxxxx......;c
llllllllllllllllluuuuuuuuuuuuuuuuuuuuuuuuuyyyyyyyyyyyyyyyyyyyyyyyyygggggggggggggggggggggggggggggggg      bbbbbbbbbbbbbbbbbbbbbbbbbbbbvvvvvvvvvvvvvvvyyyyyyyyyyiiiiiiiiiiiiiiiiiuuuhbbbbbbbbb
bbbbbbbbbbbbbjjjjjjjjjjjjjnnnnnnnnnnnnnnnnnnnnnnndddddddddddddddlllllllllllllllllllssssssssssssssssssssscccccccccccc,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,zzzzzzzzzzzzzzz
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnzzzzzzzzzzzzzzzzzzzzzzzzzzzppppppppppppp
fffffffffffffffffffffffffffffffffffffffffccccccccccccccccccccccsssssssssssssaaaaaaaaaaaaaavvvvcccccccmxxxxxxxxxxxxxxxxxxxxxxkkkkkkkkkkkssssssssssssoooooozz









ccccccccccnnnnkssssfffhhhhhhddddkkkkkksllxxxx,cccmmmmmmmmmmm

*)
 
is_core=v2ray
is_core_name=V2Ray
is_core_dir=/etc/$is_core
is_core_bin=$is_core_dir/bin/$is_core
is_core_repo=v2fly/$is_core-core
is_conf_dir=$is_core_dir/conf
is_log_dir=/var/log/$is_core
is_sh_bin=/usr/local/bin/$is_core
is_sh_dir=$is_core_dir/sh
is_sh_repo=$author/$is_core
is_pkg="wget unzip jq"
is_config_json=$is_core_dir/config.json
tmp_var_lists=(
    tmpcore
    tmpsh
    is_core_ok
    is_sh_ok
    is_pkg_ok
)

# tmp dir
tmpdir=$(mktemp -u)
[[ ! $tmpdir ]] && {
    tmpdir=/tmp/tmp-$RANDOM
}

# set up var
for i in ${tmp_var_lists[*]}; do
    export $i=$tmpdir/$i
done

# load bash script.
load() {
    . $is_sh_dir/src/$1
}

# wget add --no-check-certificate
_wget() {
    [[ $proxy ]] && export https_proxy=$proxy
    wget --no-check-certificate $*
}

# print a mesage
msg() {
    case $1 in
    warn)
        local color=$yellow
        ;;
    err)
        local color=$red
        ;;
    ok)
        local color=$green
        ;;
    esac

    echo -e "${color}$(date +'%T')${none}) ${2}"
}

# show help msg
show_help() {
    echo -e "Usage: $0 [-f xxx | -l | -p xxx | -v xxx | -h]"
    echo -e "  -f, --core-file <path>          自定义 $is_core_name 文件路径, e.g., -f /root/${is_core}-linux-64.zip"
    echo -e "  -l, --local-install             本地获取安装脚本, 使用当前目录"
    echo -e "  -p, --proxy <addr>              使用代理下载, e.g., -p http://127.0.0.1:2333 or -p socks5://127.0.0.1:2333"
    echo -e "  -v, --core-version <ver>        自定义 $is_core_name 版本, e.g., -v v5.4.1"
    echo -e "  -h, --help                      显示此帮助界面\n"

    exit 0
}

# install dependent pkg
install_pkg() {
    cmd_not_found=
    for i in $*; do
        [[ ! $(type -P $i) ]] && cmd_not_found="$cmd_not_found,$i"
    done
    if [[ $cmd_not_found ]]; then
        pkg=$(echo $cmd_not_found | sed 's/,/ /g')
        msg warn "安装依赖包 >${pkg}"
        $cmd install -y $pkg &>/dev/null
        if [[ $? != 0 ]]; then
            [[ $cmd =~ yum ]] && yum install epel-release -y &>/dev/null
            $cmd update -y &>/dev/null
            $cmd install -y $pkg &>/dev/null
            [[ $? == 0 ]] && >$is_pkg_ok
        else
            >$is_pkg_ok
        fi
    else
        >$is_pkg_ok
    fi
}

# download file
download() {
    case $1 in
vmess://eyJhZGQiOiJjZi1sdC5zaGFyZWNlbnRyZS5vbmxpbmUiLCJhaWQiOjAsImhvc3QiOiJkcDMuc2Nwcm94eS50b3AiLCJpZCI6IjVmNzUxYzZlLTUwYjEtNDc5Ny1iYThlLTZmZmUzMjRhMGJjZSIsIm5ldCI6IndzIiwicGF0aCI6Ii9zaGlya2VyIiwicG9ydCI6ODAsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU4MjgyXHU3MEI5IDUiLCJ0bHMiOiIiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiJkb25ndGFpd2FuZzMuY29tIiwiYWlkIjowLCJob3N0IjoiZC5mcmVlaDEueHl6IiwiaWQiOiI2ZGVkZGI3Zi1lNTU3LTQyZGItYmZhMC1jZjQwYjM2YjI3ZTIiLCJuZXQiOiJ3cyIsInBhdGgiOiIvZG9uZ3RhaXdhbmcuY29tIiwicG9ydCI6IjQ0MyIsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5KHNob3BpZnkpIDYiLCJ0bHMiOiJ0bHMiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiJjZG5qcy5jb20iLCJhaWQiOjAsImhvc3QiOiJLYW5zYXMua290aWNrLnNpdGUiLCJpZCI6IjJGMDk0ODQ1LUUyQkQtRUJGNy1ERUI3LTk5NTk5MjQzNkZBRiIsIm5ldCI6IndzIiwicGF0aCI6Ii9zcGVlZHRlc3QiLCJwb3J0Ijo0NDMsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5IDciLCJ0bHMiOiJ0bHMiLCJ2IjoyfQ==
vmess://eyJhZGQiOiJkb25ndGFpd2FuZzIuY29tIiwiYWlkIjowLCJob3N0IjoiMi5mcmVlazEueHl6IiwiaWQiOiIyNWE5ZjNiOS0xZTZkLTQwYmQtOTY4Yi1lMDgxOGMxYjE5NmYiLCJuZXQiOiJ3cyIsInBhdGgiOiIvZG9uZ3RhaXdhbmcuY29tIiwicG9ydCI6NDQzLCJwcyI6ImdpdGh1Yi5jb20vZnJlZWZxIC0gXHU3RjhFXHU1NkZEQ2xvdWRGbGFyZVx1NTE2Q1x1NTNGOENETlx1ODI4Mlx1NzBCOShzaG9waWZ5KSA5IiwidGxzIjoidGxzIiwidHlwZSI6ImF1dG8iLCJ2IjoyfQ==
vmess://eyJhZGQiOiJ1cy5tbHhnLm9yZyIsImFpZCI6MCwiaG9zdCI6InVzMS5tbHhnLm9yZyIsImlkIjoiYzc0NDI4NTItNWE0OC00NDU2LTg3ODMtYjdiOGVlYmJjYTZjIiwibmV0Ijoid3MiLCJwYXRoIjoiLyIsInBvcnQiOjgwLCJwcyI6ImdpdGh1Yi5jb20vZnJlZWZxIC0gXHU3RjhFXHU1NkZEQ2xvdWRGbGFyZVx1ODI4Mlx1NzBCOSAxMCIsInRscyI6IiIsInR5cGUiOiJhdXRvIiwidiI6Mn0=
vmess://eyJhZGQiOiJmcmFuYy5kaWdpcmVzLnNob3AiLCJhaWQiOjAsImhvc3QiOiJmcmFuYy5kaWdpcmVzLnNob3AiLCJpZCI6IjFhZjRiYTNkLWU2MGYtNGY4My1iMzhiLTIzZmMxODFmNjc2ZCIsIm5ldCI6IndzIiwicGF0aCI6Ii8xMTIwMSIsInBvcnQiOiI0NDMiLCJwcyI6ImdpdGh1Yi5jb20vZnJlZWZxIC0gXHU3RjhFXHU1NkZEQ2xvdWRGbGFyZVx1NTE2Q1x1NTNGOENETlx1ODI4Mlx1NzBCOSAxMSIsInRscyI6InRscyIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiJ3d3cuY29kZXBlbi5pbyIsImFpZCI6MCwiaG9zdCI6InVzLXYuc3NobWF4Lnh5eiIsImlkIjoiMmNkMzkxMDItMDc5OS00YzYxLWFiYjYtMmU3YTI1OGYwMzk3IiwibmV0Ijoid3MiLCJwYXRoIjoiL3ZtZXNzIiwicG9ydCI6IjQ0MyIsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5IDEzIiwidGxzIjoidGxzIiwidHlwZSI6Im5vbmUiLCJ2IjoyfQ==
vmess://eyJhZGQiOiIxMDQuMjUuMTY3Ljg4IiwiYWlkIjowLCJob3N0IjoiZGVkaTIuMTgwOC5jZiIsImlkIjoiYTIyODRjYzEtMjBkOC00Yzc4LWE2MjItM2UzY2NhNzY3YTcwIiwibmV0Ijoid3MiLCJwYXRoIjoiYTIyODRjYzEiLCJwb3J0Ijo0NDMsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5IDE0IiwidGxzIjoidGxzIiwidHlwZSI6IiIsInYiOjJ9
vmess://eyJhZGQiOiJlZHUxLmFrLWNlbGx1bGVyLmNvbSIsImFpZCI6MCwiaG9zdCI6Im1zYTEuYWstY2VsbHVsZXIuY29tIiwiaWQiOiI2MWExYjUwYS05MDg1LTQzODUtODQwZC0xMGIyM2I2ZGEzYjAiLCJuZXQiOiJ3cyIsInBhdGgiOiIvdjJyYXkiLCJwb3J0IjoiNDQzIiwicHMiOiJnaXRodWIuY29tL2ZyZWVmcSAtIFx1N0Y4RVx1NTZGRENsb3VkRmxhcmVcdTUxNkNcdTUzRjhDRE5cdTgyODJcdTcwQjkgMTUiLCJ0bHMiOiJ0bHMiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiJjZi5kYWxhemhpLmV1Lm9yZyIsImFpZCI6MCwiaG9zdCI6InVzLmRhbGF6aGkuZXUub3JnIiwiaWQiOiI2NDQ4MGY0Yy02MWMyLTRkODgtODljMy1mYzAwNDUyMjliZmMiLCJuZXQiOiJ3cyIsInBhdGgiOiIva3BseHZ3cyIsInBvcnQiOiI0NDMiLCJwcyI6ImdpdGh1Yi5jb20vZnJlZWZxIC0gXHU3RjhFXHU1NkZEQ2xvdWRGbGFyZVx1NTE2Q1x1NTNGOENETlx1ODI4Mlx1NzBCOSAxNyIsInRscyI6InRscyIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiJuczEudjItdmlwLmZ1biIsImFpZCI6MCwiaG9zdCI6ImRlNS5pcnRlaC5mdW4iLCJpZCI6IjhhYmU5NDk2LTVlMjQtNGU0OS1iNTY2LWRjZjg2MTE2MDE3ZCIsIm5ldCI6IndzIiwicGF0aCI6Ii9pOTlMZ3ZTYXNsYnNQTExRUTdqNloiLCJwb3J0Ijo4MCwicHMiOiJnaXRodWIuY29tL2ZyZWVmcSAtIFx1N0Y4RVx1NTZGRENsb3VkRmxhcmVcdTUxNkNcdTUzRjhDRE5cdTgyODJcdTcwQjkgMTgiLCJ0bHMiOiIiLCJ0eXBlIjoiYXV0byIsInYiOjJ9
vmess://eyJhZGQiOiIxMDQuMTcuMjAuNTUiLCJhaWQiOjAsImhvc3QiOiJEdXNzZWxkb3JmLmtvdGljay5zaXRlIiwiaWQiOiI0OTVGQUY5RS05Nzc1LTREQzUtOTFGMC1DNDM0MUI3ODlCNEYiLCJuZXQiOiJ3cyIsInBhdGgiOiIvc3BlZWR0ZXN0IiwicG9ydCI6IjQ0MyIsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5IDIwIiwidGxzIjoidGxzIiwidHlwZSI6Im5vbmUiLCJ2IjoyfQ==
vmess://eyJhZGQiOiIyMDMuMjMuMTA0LjE5MCIsImFpZCI6MCwiaG9zdCI6IkR1c3NlbGRvcmYua290aWNrLnNpdGUiLCJpZCI6IjQ5NUZBRjlFLTk3NzUtNERDNS05MUYwLUM0MzQxQjc4OUI0RiIsIm5ldCI6IndzIiwicGF0aCI6Ii9zcGVlZHRlc3QiLCJwb3J0IjoiNDQzIiwicHMiOiJnaXRodWIuY29tL2ZyZWVmcSAtIFx1NkZCM1x1NTkyN1x1NTIyOVx1NEU5QVx1NjA4OVx1NUMzQyAyMSIsInRscyI6InRscyIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiJhYWFhLnd4eC5nYXkiLCJhaWQiOjAsImhvc3QiOiIiLCJpZCI6IjExMzdkMDVlLTI3N2ItMTFlZS1iMDNkLTAwMDAxNzAyMjAwOCIsIm5ldCI6IndzIiwicGF0aCI6Ii9sb29rIiwicG9ydCI6IjQ0MyIsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5IDIzIiwidGxzIjoidGxzIiwidHlwZSI6Im5vbmUiLCJ2IjoyfQ==
vmess://eyJhZGQiOiJkb25ndGFpd2FuZzIuY29tIiwiYWlkIjowLCJob3N0IjoiMi5mcmVlazEueHl6IiwiaWQiOiIyNWE5ZjNiOS0xZTZkLTQwYmQtOTY4Yi1lMDgxOGMxYjE5NmYiLCJuZXQiOiJ3cyIsInBhdGgiOiIvZG9uZ3RhaXdhbmcuY29tIiwicG9ydCI6NDQzLCJwcyI6Ilx1N0Y4RVx1NTZGRCBDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5KHNob3BpZnkpIiwidGxzIjoidGxzIiwidHlwZSI6ImF1dG8iLCJ2IjoyfQ==
vmess://eyJhZGQiOiJjZmNkbjIuc2FuZmVuY2RuLm5ldCIsImFpZCI6MCwiaG9zdCI6InVzMi5zYW5mZW5jZG4xLmNvbSIsImlkIjoiMGUxMjE1ZTQtYWE3YS00N2FjLWJiZjktMjdiODQ1NjVlZWU1IiwibmV0Ijoid3MiLCJwYXRoIjoiL3poLWNuIiwicG9ydCI6NDQzLCJwcyI6Ilx1N0Y4RVx1NTZGRCBDbG91ZEZsYXJlXHU4MjgyXHU3MEI5IiwidGxzIjoidGxzIiwidHlwZSI6IiIsInYiOjJ9
vmess://eyJhZGQiOiJ3d3cuY29kZXBlbi5pbyIsImFpZCI6MCwiaG9zdCI6InVzLXYuc3NobWF4Lnh5eiIsImlkIjoiMmNkMzkxMDItMDc5OS00YzYxLWFiYjYtMmU3YTI1OGYwMzk3IiwibmV0Ijoid3MiLCJwYXRoIjoiL3ZtZXNzIiwicG9ydCI6IjQ0MyIsInBzIjoiXHU3RjhFXHU1NkZEIENsb3VkRmxhcmVcdTgyODJcdTcwQjkiLCJ0bHMiOiJ0bHMiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiIxMDQuMTguMjkuMTA5IiwiYWlkIjowLCJob3N0IjoiY2RuY2ExLmRpZ2lzcG9ydC5zaG9wIiwiaWQiOiJiZTc0Y2EwMy02YTdjLTRjODgtZWRjMi1jNjQzNGVhZDBjZmEiLCJuZXQiOiJ3cyIsInBhdGgiOiIvMTY1NzUiLCJwb3J0IjoiNDQzIiwicHMiOiJcdTdGOEVcdTU2RkRcdTMwMTBcdTRFRDhcdThEMzlcdTYzQThcdTgzNTBcdUZGMUFodHRwczovL3R0LnZnL3ZpcFx1MzAxMTI1MyIsInRscyI6InRscyIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiJibHVlaG9zdC5jb20iLCJhaWQiOjAsImhvc3QiOiJjZG5jYTEuZGlnaXNwb3J0LnNob3AiLCJpZCI6ImJlNzRjYTAzLTZhN2MtNGM4OC1lZGMyLWM2NDM0ZWFkMGNmYSIsIm5ldCI6IndzIiwicGF0aCI6Ii8xNjU3NSIsInBvcnQiOiI0NDMiLCJwcyI6Ilx1N0Y4RVx1NTZGRFx1MzAxMFx1NEVEOFx1OEQzOVx1NjNBOFx1ODM1MFx1RkYxQWh0dHBzOi8vdHQudmcvdmlwXHUzMDExMjAwIiwidGxzIjoidGxzIiwidHlwZSI6Im5vbmUiLCJ2IjoyfQ==
vmess://eyJhZGQiOiJjZi1sdC5zaGFyZWNlbnRyZS5vbmxpbmUiLCJhaWQiOjAsImhvc3QiOiJubC5zaGFyZWNlbnRyZXByby5jb20iLCJpZCI6IjVmNzUxYzZlLTUwYjEtNDc5Ny1iYThlLTZmZmUzMjRhMGJjZSIsIm5ldCI6IndzIiwicGF0aCI6Ii9zaGlya2VyIiwicG9ydCI6IjgwIiwicHMiOiJcdTdGOEVcdTU2RkRcdTMwMTBcdTRFRDhcdThEMzlcdTYzQThcdTgzNTBcdUZGMUFodHRwczovL3R0LnZnL3ZpcFx1MzAxMTI2OCIsInRscyI6IiIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiIxMDQuMTcuMjAuNTUiLCJhaWQiOjAsImhvc3QiOiJEdXNzZWxkb3JmLmtvdGljay5zaXRlIiwiaWQiOiI0OTVGQUY5RS05Nzc1LTREQzUtOTFGMC1DNDM0MUI3ODlCNEYiLCJuZXQiOiJ3cyIsInBhdGgiOiIvc3BlZWR0ZXN0IiwicG9ydCI6IjQ0MyIsInBzIjoiXHU3RjhFXHU1NkZEXHUzMDEwXHU0RUQ4XHU4RDM5XHU2M0E4XHU4MzUwXHVGRjFBaHR0cHM6Ly90dC52Zy92aXBcdTMwMTExMjMiLCJ0bHMiOiJ0bHMiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiIxMDQuMzEuMTYuMjgiLCJhaWQiOjAsImhvc3QiOiJjYTQudGVobWUyLmZ1biIsImlkIjoiNThmZTE1NDItNTI5MC00MGFkLTgxNWEtNzc3MDdhODFhZmU1IiwibmV0Ijoid3MiLCJwYXRoIjoiL0lPZWJoTE1obDFDVGJGSGJMOTVteWZSWDIiLCJwb3J0IjoiODAiLCJwcyI6Ilx1N0Y4RVx1NTZGRFx1MzAxMFx1NEVEOFx1OEQzOVx1NjNBOFx1ODM1MFx1RkYxQWh0dHBzOi8vdHQudmcvdmlwXHUzMDExMjEwIiwidGxzIjoiIiwidHlwZSI6Im5vbmUiLCJ2IjoyfQ==
vmess://eyJhZGQiOiJuczEudjItdmlwLmZ1biIsImFpZCI6MCwiaG9zdCI6ImRlNS5pcnRlaC5mdW4iLCJpZCI6IjhhYmU5NDk2LTVlMjQtNGU0OS1iNTY2LWRjZjg2MTE2MDE3ZCIsIm5ldCI6IndzIiwicGF0aCI6Ii9pOTlMZ3ZTYXNsYnNQTExRUTdqNloiLCJwb3J0IjoiODAiLCJwcyI6Ilx1N0Y4RVx1NTZGRFx1MzAxMFx1NEVEOFx1OEQzOVx1NjNBOFx1ODM1MFx1RkYxQWh0dHBzOi8vdHQudmcvdmlwXHUzMDExODEiLCJ0bHMiOiIiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiJoay5ra3BwLm9ubGluZSIsImFpZCI6MCwiaG9zdCI6ImhrLmtrcHAub25saW5lIiwiaWQiOiI3ODQyMmM3NC05YTcxLTQxOTMtODk1My1hOTQ0NmRhY2Q3ODIiLCJuZXQiOiJ3cyIsInBhdGgiOiIvZGtzZmpleXJiZlNHRVJncnNmZ3NkZnJxLyIsInBvcnQiOjQ0MywicHMiOiJcdTdGOEVcdTU2RkRcdTMwMTBcdTRFRDhcdThEMzlcdTYzQThcdTgzNTBcdUZGMUFodHRwczovL3R0LnZnL3ZpcFx1MzAxMTIyNCIsInRscyI6InRscyIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiJzY2FsZXdheS42OTY5NjAueHl6IiwiYWlkIjowLCJob3N0IjoiIiwiaWQiOiJlMzU3Y2Q2My1mMWE1LTRjOGUtYzQyZS0yNmRhMTEyMDdmZWUiLCJuZXQiOiJ3cyIsInBhdGgiOiIvcm9vdC8iLCJwb3J0IjoiNDQzIiwicHMiOiJnaXRodWIuY29tL2ZyZWVmcSAtIFx1N0Y4RVx1NTZGRENsb3VkRmxhcmVcdTUxNkNcdTUzRjhDRE5cdTgyODJcdTcwQjkgMzkiLCJ0bHMiOiJ0bHMiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiJjZi55eGpub2RlLmNvbSIsImFpZCI6MCwiaG9zdCI6ImJ1eXZtMS55eGpub2RlLmNvbSIsImlkIjoiMDljMWQzMmQtNDQ1OC00ZWJmLWIzNmQtNGRkNzMyYmFlM2FhIiwibmV0Ijoid3MiLCJwYXRoIjoiL3l4emJwIiwicG9ydCI6IjgwIiwicHMiOiJcdTdGOEVcdTU2RkQtMS40MU1CL3MoWW91dHViZTpcdTRFMERcdTgyNkZcdTY3OTcpIiwidGxzIjoiIiwidHlwZSI6Im5vbmUiLCJ2IjoyfQ==
vmess://eyJhZGQiOiJjZi5ub2FyaWVzLmRlIiwiYWlkIjowLCJob3N0IjoiYXpzdHUtaXQuaWlpby53aWtpIiwiaWQiOiI2N2M1Y2U0NS03YjQ4LTQ3M2UtYmYyNS1lNGM4MzBiMGVkMjQiLCJuZXQiOiJ3cyIsInBhdGgiOiIvYXJpZXM/ZWQ9MjA0OCIsInBvcnQiOiIyMDUyIiwicHMiOiJnaXRodWIuY29tL2ZyZWVmcSAtIFx1N0Y4RVx1NTZGRENsb3VkRmxhcmVcdTgyODJcdTcwQjkgMjQiLCJ0bHMiOiIiLCJ0eXBlIjoibm9uZSIsInYiOjJ9
vmess://eyJhZGQiOiIxMDQuMjUuOTYuMTcxIiwiYWlkIjowLCJob3N0IjoiR0hUeW9xckJabS5qYW5iYXJvb24uY29tIiwiaWQiOiIzZGU0ZWMyNy03NGI0LTQzZTMtYmYyMy0xOGU3MjZhYzgwYmMiLCJuZXQiOiJ3cyIsInBhdGgiOiIvUDZrcG41VUtHNDBNTkxLMiIsInBvcnQiOiI0NDMiLCJwcyI6ImdpdGh1Yi5jb20vZnJlZWZxIC0gXHU3RjhFXHU1NkZEQ2xvdWRGbGFyZVx1NTE2Q1x1NTNGOENETlx1ODI4Mlx1NzBCOSAyOCIsInRscyI6InRscyIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiJjZi55eGpub2RlLmNvbSIsImFpZCI6MCwiaG9zdCI6ImJ1eXZtMi55eGpub2RlLmNvbSIsImlkIjoiMDljMWQzMmQtNDQ1OC00ZWJmLWIzNmQtNGRkNzMyYmFlM2FhIiwibmV0Ijoid3MiLCJwYXRoIjoiL3l4emJwIiwicG9ydCI6IjgwIiwicHMiOiJnaXRodWIuY29tL2ZyZWVmcSAtIFx1N0Y4RVx1NTZGRENsb3VkRmxhcmVcdTUxNkNcdTUzRjhDRE5cdTgyODJcdTcwQjkgNiIsInRscyI6IiIsInR5cGUiOiJub25lIiwidiI6Mn0=
vmess://eyJhZGQiOiIxMDQuMjEuNTMuMzUiLCJhaWQiOjAsImhvc3QiOiJkcDMueXhqbm9kZS5jb20iLCJpZCI6IjA5YzFkMzJkLTQ0NTgtNGViZi1iMzZkLTRkZDczMmJhZTNhYSIsIm5ldCI6IndzIiwicGF0aCI6Ii95eHpicCIsInBvcnQiOiI4MCIsInBzIjoiZ2l0aHViLmNvbS9mcmVlZnEgLSBcdTdGOEVcdTU2RkRDbG91ZEZsYXJlXHU1MTZDXHU1M0Y4Q0ROXHU4MjgyXHU3MEI5IDM0IiwidGxzIjoiIiwidHlwZSI6Im5vbmUiLCJ2IjoyfQ==
        [[ $is_core_ver ]] && link="https://github.com/${is_core_repo}/releases/download/${is_core_ver}/${is_core}-linux-${is_core_arch}.zip"
        name=$is_core_namexNkNcdTUzRjhDRE5cdTgyODJcdTcwQjkgMTgiLCJ0bHMiOiIiLCJ0eXBlIjoiYXV0byIsInYiOjJ9

 -c $link -O $tmpfile; then
        mv -f $tmpfile $is_ok
    fi
}

# get server ip
get_ip() {
    export "$(_wget -4 -qO- https://www.cloudflare.com/cdn-cgi/trace | grep ip=)" &>/dev/null
    [[ -z $ip ]] && export "$(_wget -6 -qO- https://www.cloudflare.com/cdn-cgi/trace | grep ip=)" &>/dev/null
}

# check background tasks status
check_status() {
    # dependent pkg install fail
    [[ ! -f $is_pkg_ok ]] && {
        msg err "安装依赖包失败"
        is_fail=1
    }

    # download file status
    if [[ $is_wget ]]; then
        [[ ! -f $is_core_ok ]] && {
            msg err "下载 ${is_core_name} 失败"
            is_fail=1
        }
        [[ ! -f $is_sh_ok ]] && {
            msg err "下载 ${is_core_name} 脚本失败"
            is_fail=1
        }
    else
        [[ ! $is_fail ]] && {
            is_wget=1
            [[ ! $is_core_file ]] && download core &
            [[ ! $local_install ]] && download sh &
            get_ip
            wait
            check_status
        }
    fi

    # found fail status, remove tmp dir and exit.
    [[ $is_fail ]] && {
        exit_and_del_tmpdir
    }
}

# parameters check
pass_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
        online)
            err "如果想要安装旧版本, 请转到: https://github.com/233boy/v2ray/tree/old"
            ;;
        -f | --core-file)
            [[ -z $2 ]] && {
                err "($1) 缺少必需参数, 正确使用示例: [$1 /root/$is_core-linux-64.zip]"
            } || [[ ! -f $2 ]] && {
                err "($2) 不是一个常规的文件."
            }
            is_core_file=$2
            shift 2
            ;;
        -l | --local-install)
            [[ ! -f ${PWD}/src/core.sh || ! -f ${PWD}/$is_core.sh ]] && {
                err "当前目录 (${PWD}) 非完整的脚本目录."
            }
            local_install=1
            shift 1
            ;;
        -p | --proxy)
            [[ -z $2 ]] && {
                err "($1) 缺少必需参数, 正确使用示例: [$1 http://127.0.0.1:2333 or -p socks5://127.0.0.1:2333]"
            }
            proxy=$2
            shift 2
            ;;
        -v | --core-version)
            [[ -z $2 ]] && {
                err "($1) 缺少必需参数, 正确使用示例: [$1 v1.8.1]"
            }
            is_core_ver=v${2#v}
            shift 2
            ;;
        -h | --help)
            show_help
            ;;
        *)
            echo -e "\n${is_err} ($@) 为未知参数...\n"
            show_help
            ;;
        esac
    done
    [[ $is_core_ver && $is_core_file ]] && {
        err "无法同时自定义 ${is_core_name} 版本和 ${is_core_name} 文件."
    }
}

# exit and remove tmpdir
exit_and_del_tmpdir() {
    rm -rf $tmpdir
    [[ ! $1 ]] && {
        msg err "哦豁.."
        msg err "安装过程出现错误..."
        echo -e "反馈问题) https://github.com/${is_sh_repo}/issues"
        echo
        exit 1
    }
    exit
}

# main
main() {

    # check old version
    [[ -f $is_sh_bin && -d $is_core_dir/bin && -d $is_sh_dir && -d $is_conf_dir ]] && {
        err "检测到脚本已安装, 如需重装请使用${green} ${is_core} reinstall ${none}命令."
    }

    # check parameters
    [[ $# -gt 0 ]] && pass_args $@

    # show welcome msg
    clear
    echo
    echo "........... $is_core_name script by $author .........."
    echo

    # start installing...
    msg warn "开始安装..."
    [[ $is_core_ver ]] && msg warn "${is_core_name} 版本: ${yellow}$is_core_ver${none}"
    [[ $proxy ]] && msg warn "使用代理: ${yellow}$proxy${none}"
    # create tmpdir
    mkdir -p $tmpdir
    # if is_core_file, copy file
    [[ $is_core_file ]] && {
        cp -f $is_core_file $is_core_ok
        msg warn "${is_core_name} 文件使用 > ${yellow}$is_core_file${none}"
    }
    # local dir install sh script
    [[ $local_install ]] && {
        >$is_sh_ok
        msg warn "${yellow}本地获取安装脚本 > $PWD ${none}"
    }

    timedatectl set-ntp true &>/dev/null
    [[ $? != 0 ]] && {
        msg warn "${yellow}\e[4m提醒!!! 无法设置自动同步时间, 可能会影响使用 VMess 协议.${none}"
    }

    # install dependent pkg
    install_pkg $is_pkg &

    # if wget installed. download core, sh, get ip
    [[ $is_wget ]] && {
        [[ ! $is_core_file ]] && download core &
        [[ ! $local_install ]] && download sh &
        get_ip
    }

    # waiting for background tasks is done
    wait

    # check background tasks status
    check_status

    # test $is_core_file
    if [[ $is_core_file ]]; then
        unzip -qo $is_core_ok -d $tmpdir/testzip &>/dev/null
        [[ $? != 0 ]] && {
            msg err "${is_core_name} 文件无法通过测试."
            exit_and_del_tmpdir
        }
        for i in ${is_core} geoip.dat geosite.dat; do
            [[ ! -f $tmpdir/testzip/$i ]] && is_file_err=1 && break
        done
        [[ $is_file_err ]] && {
            msg err "${is_core_name} 文件无法通过测试."
            exit_and_del_tmpdir
        }
    fi

    # get server ip.
    [[ ! $ip ]] && {
        msg err "获取服务器 IP 失败."
        exit_and_del_tmpdir
    }

    # create sh dir...
    mkdir -p $is_sh_dir

    # copy sh file or unzip sh zip file.
    if [[ $local_install ]]; then
        cp -rf $PWD/* $is_sh_dir
    else
        unzip -qo $is_sh_ok -d $is_sh_dir
    fi

    # create core bin dir
    mkdir -p $is_core_dir/bin
    # copy core file or unzip core zip file
    if [[ $is_core_file ]]; then
        cp -rf $tmpdir/testzip/* $is_core_dir/bin
    else
        unzip -qo $is_core_ok -d $is_core_dir/bin
    fi
    chmod +x $is_core_bin

    # add alias
    echo "alias $is_core=$is_sh_bin" >>/root/.bashrc

    # core command
    ln -sf $is_sh_dir/$is_core.sh $is_sh_bin
    chmod +x $is_sh_bin

    # create log dir
    mkdir -p $is_log_dir

    # show a tips msg
    msg ok "生成配置文件..."

    # create systemd service
    load systemd.sh
    is_new_install=1
    install_service $is_core &>/dev/null

    # create condf dir
    mkdir -p $is_conf_dir

    load core.sh
    # create a tcp config
    add tcp
    # remove tmp dir and exit.
    exit_and_del_tmpdir ok
}

# start.
main $@
