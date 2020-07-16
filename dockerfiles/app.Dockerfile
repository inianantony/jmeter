FROM openjdk
LABEL maintiner "Antony"

USER root

COPY ./app /app

WORKDIR /app

EXPOSE 8080

ENTRYPOINT ["./demo.sh"]
