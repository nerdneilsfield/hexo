FROM alpine
MAINTAINER Dengqi <dengqi935@outlook.com> 
RUN apk add --update --no-cache  nodejs git 
RUN echo "Asia/Shanghai" > /etc/timezone
RUN npm install -g hexo --save && \
    npm install hexo-generator-feed --save
RUN mkdir /blog/
RUN hexo init /blog
WORKDIR /blog
RUN	npm install
RUN git clone https://github.com/tommy351/hexo-theme-phase.git themes/phase && \
    rm _config.yml && rm themes/phase/_config.yml
ADD them/_config.yml themes/phase/
ADD _config.yml /blog/
RUN hexo new page "about" && \
	hexo new page "tags"	&& \ 
    hexo new page categories
RUN rm -f /blog/source/tags/index.md /blog/source/categories/index.md
ADD favicon.ico /post/source/
ADD tags.md /blog/source/tags/index.md
ADD cat.md /blog/source/categories/index.md
ADD 404.html /blog/source/
CMD ["hexo", "generate","--watch"]
