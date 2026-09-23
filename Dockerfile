FROM alpine:latest

RUN apk add --no-cache curl unzip

# Download and extract the official 64-bit Linux Xray release binary
RUN curl -L -H "Cache-Control: no-cache" -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    mkdir -p /usr/local/xray && \
    unzip xray.zip -d /usr/local/xray && \
    rm xray.zip

COPY config.json /etc/xray/config.json

# Replace 8080 with Koyeb's dynamic $PORT environment variable at container startup
CMD sed -i "s/8080/$PORT/g" /etc/xray/config.json && /usr/local/xray/xray -config /etc/xray/config.json
