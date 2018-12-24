FROM python:3.6-alpine3.6

RUN apk add --no-cache git build-base openssl openssl-dev \
 && apk add --no-cache \
    --repository http://nl.alpinelinux.org/alpine/edge/testing leveldb-dev \
 && pip install \
    aiorpcx==0.10.1 \
    aiohttp==3.3.2 \
    pylru==1.1.0 \
    plyvel==1.0.4 \
    uvloop==0.11.0 \
    x11_hash==1.4 \
    pycryptodomex==3.7.0 \
    quark_hash==1.0 \
 && addgroup -S -g 700 electrum \
 && adduser -S -G electrum -u 700 electrum \
 && cd /home/electrum \
 && git clone https://github.com/kyuupichan/electrumx.git \
 && chown -R electrum:electrum electrumx
RUN cd /home/electrum/electrumx \
 && python setup.py install \
 && rm -rf /tmp/* \
 && mkdir /data  \
 && chown -R electrum:electrum /data 
USER electrum:electrum
WORKDIR /home/electrum/
CMD ["/home/electrum/electrumx/electrumx_server"]
