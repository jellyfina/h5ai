# 使用官方 alpine 镜像作为基础
FROM alpine:3.19


# Docker 镜像信息
LABEL maintainer="9385966@gmail.com"
LABEL description="Alpine based image with apache2 and php8.3"

# 安装 Apache2 和 PHP-FPM
RUN apk add --no-cache apache2-ssl tzdata curl php83-apache2 php83-fpm php83-cli php83-json php83-phar php83-iconv php83-openssl php83-zlib php83-session php83-gd php83-exif ffmpeg imagemagick zip

# 设置工作目录为 /www
WORKDIR /www

# 配置 Apache2
RUN (sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf ;\
     sed -i "s/ServerAdmin\ you@example.com/ServerAdmin\ 9385966@gmail.com/" /etc/apache2/httpd.conf ;\
     sed -i "s/#ServerName\ www.example.com:80/ServerName\ localhost/" /etc/apache2/httpd.conf ;\
     sed -i 's#^DocumentRoot ".*#DocumentRoot "/www"#g' /etc/apache2/httpd.conf ;\
     sed -i 's#Directory "/var/www/localhost/htdocs"#Directory "/www"#g' /etc/apache2/httpd.conf ;\
     sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf ;\
     sed -i 's#^ErrorLog .*#ErrorLog "/dev/stderr"\nTransferLog "/dev/stdout"#g' /etc/apache2/httpd.conf ;\
     sed -i 's#CustomLog .* combined#CustomLog "/dev/stdout" combined#g' /etc/apache2/httpd.conf ;\
     sed -i 's#^ErrorLog .*#ErrorLog "/dev/stderr"#g' /etc/apache2/conf.d/ssl.conf ;\
     sed -i 's#^TransferLog .*#TransferLog "/dev/stdout"#g' /etc/apache2/conf.d/ssl.conf ;\
     sed -i 's#^DocumentRoot ".*#DocumentRoot "/www"#g' /etc/apache2/conf.d/ssl.conf ;\
     sed -i "s/ServerAdmin\ you@example.com/ServerAdmin\ 9385966@gmail.com/" /etc/apache2/conf.d/ssl.conf ;\
     sed -i "s/ServerName\ www.example.com:443/ServerName\ localhost/" /etc/apache2/conf.d/ssl.conf ;\
     sed -i 's/#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf ;\
     sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories ;\
     sed -i 's/#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf )

# 设置时区为 Asia/Shanghai
ENV TZ=Asia/Shanghai

# 设置 web 端口
EXPOSE 80 443

# 启动 Apache2 服务器
CMD ["httpd", "-D", "FOREGROUND"]
