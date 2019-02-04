#!/bin/bash
if [ $# -ne 1 ];then
        exit 0
else
        distro=$1
fi

case $distro in
        archlinux)
                echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
                ;;
        debian)
                sed -i -s 's/deb.debian.org/mirrors.163.com/g' /etc/apt/sources.list
                ;;
        fedora)
                cat > /etc/yum.repos.d/fedora.repo << END_OF_LINE
[fedora]
name=Fedora \$releasever - \$basearch
failovermethod=priority
baseurl=https://mirrors.163.com/fedora/releases/\$releasever/Everything/\$basearch/os/
metadata_expire=28d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$releasever-\$basearch
skip_if_unavailable=False
END_OF_LINE

                cat > /etc/yum.repos.d/fedora-updates.repo << END_OF_LINE
[updates]
name=Fedora \$releasever - \$basearch - Updates
failovermethod=priority
baseurl=https://mirrors.163.com/fedora/updates/\$releasever/Everything/\$basearch/
enabled=1
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$releasever-\$basearch
skip_if_unavailable=False
END_OF_LINE
                ;;
        ubuntu)
                sed -i -s 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list
                ;;
        *)
                true
                ;;
esac
