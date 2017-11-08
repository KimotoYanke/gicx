FROM base

RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

ENV CONFIGURE_OPTS --disable-install-doc
ADD ./ruby-versions.txt /root/ruby-versions.txt
RUN xargs -L 1 rbenv install < /root/ruby-versions.txt

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bash -l -c 'for v in $(cat /root/ruby-versions.txt); do rbenv global $v; gem install bundler; done'

RUN apt-get install -y sqlite3 libsqlite3-dev

RUN apt-get install -y software-properties-common
RUN apt-get update
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nodejs

RUN mkdir /root/.ssh/

ADD id_rsa /root/.ssh/id_rsa

RUN touch /root/.ssh/known_hosts

RUN mkdir -p /var/www
RUN git clone git@github.com:KimotoYanke/gicx.git /var/www/gicx
WORKDIR /var/www/gicx

# railsのセットアップ
RUN bash -l -c 'bundle install'
RUN bash -l -c 'bundle exec rake db:create; bundle exec rake db:migrate'
RUN bash -l -c 'yarn'
RUN bash -l -c 'webpack'

EXPOSE 3000
CMD bash
