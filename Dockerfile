FROM centos:7
RUN yum groupinstall -y "Development Tools"
RUN yum install -y openssl-devel readline-devel zlib-devel asciidoc bc net-tools newt-devel openssl xmlto audit-libs-devel binutils-devel elfutils-devel java-1.8.0-openjdk-devel numactl-devel 'perl(ExtUtils::Embed)' python-devel slang-devel xz-devel pciutils-devel

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN mkdir -p "$(rbenv root)"/plugins
RUN source ~/.bashrc && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

RUN source ~/.bashrc && rbenv install 2.5.1
RUN source ~/.bashrc && rbenv global 2.5.1

RUN source ~/.bashrc && gem install --no-user-install --no-document pkgforge targit

RUN ln -s ~/.rbenv/shims/pkgforge /usr/local/bin/pkgforge

ENV EDITOR vim
WORKDIR /opt/build
CMD ["pkgforge", "build"]
