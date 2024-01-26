#!/bin/bash

#设置变量name接收第一个参数（要创建的用户名），$n表示第n个参数，且=两边不能有空格
name=$1
#设置变量pass接收第二个参数（要为其设置的密码）
pass=`echo $(date +%Y%m%d) | md5sum | cut -c 8-15`
#echo语句会输出到控制台，${变量}或者 $变量 表示变量代表的字符串
echo "you are setting username : ${name}"
echo "you are setting password : $pass for ${name}"
echo "you are setting password : $pass for ${name}" > accout.txt
#添加用户$name，此处sudo需要设置为无密码，后面将会作出说明
sudo useradd -m $name -s /bin/bash # cyh 是我的用户名
#如果上一个命令正常运行，则输出成功，否则提示失败并以非正常状态退出程序
# $?表示上一个命令的执行状态，-eq表示等于，[ 也是一个命令
# if fi 是成对使用的，后面是前面的倒置，很多这样的用法。
if [ $? -eq 0 ];then
   echo "user ${name} is created successfully!!!"
else
   echo "user ${name} is created failly!!!"
   exit 1
fi
#sudo passwd $name会要求填入密码，下面将$pass作为密码传入
#echo $pass | sudo passwd $name --stdin  &>/dev/null
#交互式
#chpasswd user_name:password 
#非交互式
echo $name:$pass | sudo chpasswd  &>/dev/null

#echo $pass | sudo passwd $name --stdin  &>/dev/null
if [ $? -eq 0 ];then
   echo "${name}'s password is set successfully"
else
   echo "${name}'s password is set failly!!!"
   # exit 1
fi

#!/bin/bash

#设置变量name接收第一个参数（用户名），$n表示第n个参数，且=两边不能有空格
# name=$1

echo "${name} set rsa start"
sudo usermod -a -G sudo $name 
sudo usermod -a -G adm $name
sudo usermod -a -G docker $name 
sudo cp /etc/sudoers /etc/sudoers.bak
sudo chmod 220 /etc/sudoers
sudo echo "$name ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo chmod 440 /etc/sudoers
sudo mkdir -p /home/$name/.ssh
sudo cp /root/.ssh/authorized_keys /home/$name/.ssh/
sudo chown -R $name:$name /home/$name

#sudo chown $name:$name /home/$name/.ssh
#sudo chown $name:$name /home/$name/.ssh/authorized_keys
sudo chmod 750 /home/$name
sudo chmod 700 /home/$name/.ssh
sudo chmod 600 /home/$name/.ssh/authorized_keys


