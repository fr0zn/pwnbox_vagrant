msg() {
    printf '%b\n' "$1" >&2
}

msg_info() {
    if [[ "${2}" == "in" ]]; then
        msg "\33[94m  ->\33[0m ${1}"
    else
        msg "\33[94m==>\33[0m ${1}"
    fi
}

msg_ok() {
    if [[ "${2}" == "in" ]]; then
        msg "\33[92m  ->\33[0m ${1}"
    else
        msg "\33[92m==>\33[0m ${1}"
    fi
}

msg_error() {
    if [[ "${2}" == "in" ]]; then
        msg "\33[91m  -> ERROR:\33[0m ${1}"
    else
        msg "\33[91m==> ERROR:\33[0m ${1}"
    fi
}


msg_info "Updating system"
sudo apt-get -y update

msg_info "Installing utils, build-essential and gdb"
sudo apt-get -y install git
sudo apt-get -y install gdb gdb-multiarch
sudo apt-get -y install build-essential

msg_info "Installing python 2.7"
sudo apt-get -y install python2.7 python-pip python-dev
sudo apt-get -y install libssl-dev libffi-dev
sudo pip2 install --upgrade pip

msg_info "Installing python 3"
sudo apt-get -y install python3-pip
sudo pip3 install --upgrade pip

msg_info "Installing multilib gcc"
sudo apt-get -y install gcc-multilib

msg_info "Installing arm binutils"
sudo apt-get install binutils-arm-linux-gnueabi

# Install Pwntools
msg_info "Installing pwntools"
sudo pip2 install --upgrade pwntools
msg_ok "Done installing pwntools"

cd
mkdir tools
cd tools

# Install pwndbg
msg_info "Installing pwndbg"
git clone https://github.com/zachriggle/pwndbg
pushd pwndbg
./setup.sh
popd
msg_ok "Done installing pwndbg"

# Install radare2
msg_info "Installing radare2"
git clone https://github.com/radare/radare2
pushd radare2
./sys/install.sh
popd
msg_ok "Done installing radare2"

# Enable 32bit binaries on 64bit host
msg_info "Enable 32bit binaries to run on 64bit host"
sudo dpkg --add-architecture i386
sudo apt-get -y update
sudo apt-get -y install libc6:i386 libc6-dbg:i386 libncurses5:i386 libstdc++6:i386

msg_info "Updating locale to utf-8"
sudo update-locale LANG=en_US.utf8 LANGUAGE=en_US.utf8

msg_ok "Done provisioning!"


