#付费维护脚本，请勿破解修改                                                                                                
#===================================================================#
#   System Required:  CentOS 7                                      #
#   Description: Install sspanel for CentOS7                        #
#   Author: Azure <3074744699@qq.com>                                #
#===================================================================#
#一键脚本
#version=v1.1
#check root
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
rm -rf all
rm -rf $0
#
# 设置字体颜色函数
function blue(){
    echo -e "\033[34m\033[01m $1 \033[0m"
}
function green(){
    echo -e "\033[32m\033[01m $1 \033[0m"
}
function greenbg(){
    echo -e "\033[43;42m\033[01m $1 \033[0m"
}
function red(){
    echo -e "\033[31m\033[01m $1 \033[0m"
}
function redbg(){
    echo -e "\033[37;41m\033[01m $1 \033[0m"
}
function yellow(){
    echo -e "\033[33m\033[01m $1 \033[0m"
}
function white(){
    echo -e "\033[37m\033[01m $1 \033[0m"
}

#            
# @安装docker
install_docker() {
    docker version > /dev/null || curl -fsSL get.docker.com | bash 
    service docker restart 
    systemctl enable docker  
}

# 单独检测docker是否安装，否则执行安装docker。
check_docker() {
	if [ -x "$(command -v docker)" ]; then
		blue "docker is installed"
		# command
	else
		echo "Install docker"
		# command
		install_docker
	fi
}

# check docker


# 以上步骤完成基础环境配置。
echo "恭喜，您已完成基础环境安装，可执行安装程序。"

backend_docking_set(){
    white "本骄脚本支持 green "webapi" 和 green "数据库对接" 两种对接方式"
    green "请选择对接方式(默认推荐webapi)"
    yellow "1.webapi对接"
    yellow "2.数据库对接"
    echo
    read -e -p "请输入数字[1~2](默认1)：" vnum
    [[ -z "${vnum}" ]] && vnum="1" 
	if [[ "${vnum}" == "1" ]]; then
        greenbg "当前对接模式：webapi"
        greenbg "使用前请准备好 redbg "节点ID、前端网站ip或url、前端token" "
        green "请输入网址：示例http://baiyue.one 或http://23.94.13.115 (ip地址)"
        read -p "请输入网址:" web_url
        green "请输入网站webapi_token:如未修改默认的NimaQu,可直接回车下一步"
        read -e -p "请输入webapi_token(默认值NimaQu)：" webapi_token
        [[ -z "${webapi_token}" ]] && webapi_token="NimaQu"
        green "节点ID：示例3"
        read -p "请输入节点ID:" node_id
        yellow "配置已完成，正在部署后端。。。。"
        check_docker
        docker run -d --name=ssrmu -e NODE_ID=$node_id -e API_INTERFACE=modwebapi -e WEBAPI_URL=$web_url -e WEBAPI_TOKEN=$webapi_token --network=host --log-opt max-size=50m --log-opt max-file=3 --restart=always baiyuetribe/sspanel:backend
        greenbg "恭喜您，后端节点已搭建成功"        
	elif [[ "${vnum}" == "2" ]]; then
        greenbg "当前对接模式：数据库对接"
        greenbg "使用前请准备好 redbg "节点ID、前端网站ip、数据库ROOT密码" "
        green "请输入前端网网站IP：23.94.13.115 (ip数字)"
        read -p "请输入ip:" web_ip
        green "请输入前端数据库密码"
        read -p "请输入前端数据库密码:" root_pwd
        green "节点ID：示例3"
        read -p "请输入节点ID:" node_id
        yellow "配置已完成，正在部署后端。。。。"
        check_docker
        docker run -d --name=ssrmu -e NODE_ID=$node_id -e API_INTERFACE=glzjinmod -e MYSQL_HOST=$web_ip -e MYSQL_USER=root -e MYSQL_DB=sspanel -e MYSQL_PASS=$root_pwd --network=host --log-opt max-size=50m --log-opt max-file=3 --restart=always baiyuetribe/sspanel:backend
        greenbg "恭喜您，后端节点已搭建成功"   
	fi       
}


#开始菜单
start_menu(){
    clear
	echo "
  ██████╗  █████╗ ██╗██╗   ██╗██╗   ██╗███████╗    ██████╗ ███╗   ██╗███████╗
  ██╔══██╗██╔══██╗██║╚██╗ ██╔╝██║   ██║██╔════╝   ██╔═══██╗████╗  ██║██╔════╝
  ██████╔╝███████║██║ ╚████╔╝ ██║   ██║█████╗     ██║   ██║██╔██╗ ██║█████╗  
  ██╔══██╗██╔══██║██║  ╚██╔╝  ██║   ██║██╔══╝     ██║   ██║██║╚██╗██║██╔══╝  
  ██████╔╝██║  ██║██║   ██║   ╚██████╔╝███████╗██╗╚██████╔╝██║ ╚████║███████╗
  ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝                                                            
    "
    greenbg "==============================================================="
    greenbg "程序：sspanel后端对接【付费授权版】                                      "
    greenbg "系统：Centos7、Ubuntu、Debian等                                         "
    greenbg "脚本作者：Azure  联系QQ：2894049053                                 "
    greenbg "程序开发者：Nimaqu Github:nimaqu/sspanel                        "
    greenbg "网站： https://baiyue.one                                       "
    greenbg "主题：专注分享优质web资源                                        "
    greenbg "Youtube/B站： 佰阅部落                                          "
    greenbg "==============================================================="
    echo
    yellow "使用前提：脚本会自动安装docker，国外服务器搭建只需1min~2min"
    yellow "目前支持webapi和数据库对接两种方式"
    echo
    white "—————————————程序安装——————————————"
    green "1.sspanel后端安装"
    white "—————————————杂项管理——————————————"
    white "2.停止节点"
    white "3.重启节点"
    white "4.卸载节点"
    white "—————————————后端BBr加速——————————————" 
    green "5.节点bbr加速"
    green ""
    blue "0.退出脚本"
    echo
    echo
    read -p "请输入数字:" num
    case "$num" in
    1)
    greenbg "此脚本适用于Centos7、Ubutun、Debian等系统"
    backend_docking_set
	;;
	2)
    docker stop ssrmu
    green "当前节点已停止运行"
	;;
	3)
    docker restart ssrmu
    green "节点已重启完毕"
	;;
	4)
    redbg "正在卸载本机节点。。。"
    docker rm -f ssrmu
	;;
	5)
    yellow "bbr加速选用94ish.me的轮子"
    bash <(curl -L -s https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh)
	;;            
	0)
	exit 1
	;;
	*)
	clear
	echo "请输入正确数字[0~5],退出请按0"
	sleep 3s
	start_menu
	;;
    esac
}

start_menu
