FROM centos:7
LABEL maintainer="245967906@qq.com"
ENV LANG en_US.UTF-8
RUN set -x \
    && yum -y install \
        epel-release \
    && yum -y install \
        bind-utils \
        bzip2 \
        cmake \
        file \
        gcc \
        gcc-c++ \
        git \
        go \
        iproute \
        lua-devel \
        make \
        mysql-devel \
        ncurses-devel \
        net-tools \
        npm \
        openssh-server \
        python36 \
        python36-devel \
        python36-pip \
        texinfo \
        wget \
        which \
        zip \
        zsh \
    && ln -sf /usr/bin/python3.6 /usr/bin/python \
    && ln -sf /usr/bin/pip-3.6 /usr/bin/pip \
    && sed -i '1s/python/python2/g' /usr/bin/yum \
    && sed -i '1s/python/python2/g' /usr/libexec/urlgrabber-ext-down \
    && sed -i 's/\(^session.*pam_loginuid.so\)/#\1/g' /etc/pam.d/sshd \
    && curl -fLo gcc-6.2.0.tar.gz  https://ftp.gnu.org/gnu/gcc/gcc-6.2.0/gcc-6.2.0.tar.gz \
    && tar xf gcc-6.2.0.tar.gz \
    && cd gcc-6.2.0/ \
    && ./contrib/download_prerequisites \
    && ./configure --disable-multilib \
    && make \
    && make install \
    && ln -sf /usr/local/lib64/libstdc++.so.6.0.22 /usr/lib64/libstdc++.so.6 \
    && cd ../ \
    && rm -rf gcc-6.2.0.tar.gz gcc-6.2.0/ \
    && npm config set strict-ssl false \
    && npm install -g n \
    && export PATH="$PATH" \
    && n latest \
    && git clone https://github.com/vim/vim.git \
    && cd vim/ \
    && ./configure \
        --with-features=huge \
        --enable-multibyte \
        --enable-pythoninterp \
        --enable-python3interp \
        --enable-luainterp \
        --enable-tclinterp \
    && make \
    && make install \
    && cd ../ \
    && rm -rf vim/ \
    && pip install \
        pipenv \
        yapf \
        flake8 \
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && curl -fLo ~/.vimrc \
        https://raw.githubusercontent.com/245967906/vimrc/master/vimrc \
    && export TERM=xterm \
    && yes | vim +PlugInstall +qa \
    && yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
