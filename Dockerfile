FROM occitech/magento:php5.5-apache

ENV MAGENTO_VERSION 1.8.1.0

RUN cd /tmp && curl https://codeload.github.com/OpenMage/magento-mirror/tar.gz/$MAGENTO_VERSION -o $MAGENTO_VERSION.tar.gz && tar xvf $MAGENTO_VERSION.tar.gz && mv magento-mirror-$MAGENTO_VERSION/* magento-mirror-$MAGENTO_VERSION/.htaccess /var/www/htdocs

RUN chown -R www-data:www-data /var/www/htdocs

RUN apt-get update \
    && apt-get install -y mysql-client-5.5 \
    && apt-get install -y libxml2-dev
RUN docker-php-ext-install soap

COPY ./bin/install-magento /usr/local/bin/install-magento

RUN chmod +x /usr/local/bin/install-magento

COPY ./sampledata/magento-sample-data-1.6.1.0.tar.gz /opt/
COPY ./bin/install-sampledata-1.6_1.8 /usr/local/bin/install-sampledata
RUN chmod +x /usr/local/bin/install-sampledata
