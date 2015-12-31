FROM ubuntu:14.04
MAINTAINER Dengqi <dengqi935@outlook.com> 
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y  git nodejs npm supervisor
RUN npm install -g hexo --save
RUN npm install hexo-generator-feed --save
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN mkdir /blog
RUN hexo init /blog
RUN apt-get clean && \
     rm -rf /var/lib/apt/lists/*
RUN cd /blog
RUN npm install
RUN git clone https://github.com/nerdneilsfield/Hexo-theme-Teas themes/teas
RUN rm _config.yml
ADD _config.yml /blog/
RUN hexo new page "about" && \
	hexo new page "tags" && \
	hexo new page categories \
#克隆我的主题下来
ADD 404.html /blog/source/
RUN rm -r /blog/source/_post
ADD supervisor.conf /etc/supervisor/conf.d/

WORKDIR /blog
EXPOSE 4000

CMD ["supervisord", "-n"]