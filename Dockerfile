FROM golang:1.15.14-buster as builder

WORKDIR /

RUN go get github.com/crunchydata/postgresql-prometheus-adapter
COPY . .
RUN make


FROM debian:buster-slim

WORKDIR /

RUN apt-get update && apt-get dist-upgrade
COPY --from=builder /postgresql-prometheus-adapter ./
COPY start.sh ./

ENTRYPOINT ["./start.sh"]
