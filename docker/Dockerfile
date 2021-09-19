FROM alpine
RUN apk add --no-cache \
        python3 \
        python3-dev \
        py-pip \
        build-base \
        linux-headers \
        && pip install uwsgi Flask \
        && apk del \
        linux-headers \
        build-base \
        py-pip \
        python3-dev

WORKDIR /flask_app
EXPOSE 8080

CMD [ "uwsgi", "--socket", "0.0.0.0:8080", \
               "--protocol", "http", \
               "--wsgi", "app:app" ]
