FROM ubuntu:14.04
MAINTAINER Dengqi <dengqi935@outlook.com> 
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y  git nodejs npm supervisor nginx &&\
	apt-get clean && \
     rm -rf /var/lib/apt/lists/*
RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN npm install -g hexo --save && \
    npm install hexo-generator-feed --save
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN hexo init /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html/
RUN	npm install
RUN git clone https://github.com/nerdneilsfield/Hexo-theme-Teas themes/teas
RUN rm _config.yml
ADD _config.yml /usr/share/nginx/html/
RUN echo "hello"
RUN hexo new page "about"
RUN	hexo new page "tags"
RUN	hexo new page categories
RUN rm -f /usr/share/nginx/html/source/tags/index.md /usr/share/nginx/html/source/categories/index.md
ADD favicon.ico /usr/share/nginx/html/source/
ADD tags.md /usr/share/nginx/html/source/tags/index.md
ADD cat.md /usr/share/nginx/html/source/categories/index.md
ADD 404.html /usr/share/nginx/html/source/
ADD default.conf /etc/nginx/conf.d/default.conf
# RUN rm -r /blog/source/_post
ADD supervisor.conf /etc/supervisor/conf.d/
EXPOSE 5000

CMD ["supervisord", "-n"]