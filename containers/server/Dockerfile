FROM golang:1.21.0
WORKDIR /app
COPY dist .
RUN go mod download
RUN go build -o server .
CMD [ "./server" ]