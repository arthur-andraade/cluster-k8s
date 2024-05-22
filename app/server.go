package main

import (
	"fmt"
	"net/http"
	"os"
	"time"
)

const SECONDS_START = 25

var startedAt = time.Now()

func main() {
	http.HandleFunc("/health", health)
	http.HandleFunc("/", hello)
	http.ListenAndServe(":8080", nil)
}

func hello(response http.ResponseWriter, request *http.Request) {

	environmentType := os.Getenv("ENVIRONMENT_TYPE")

	podName := os.Getenv("POD_NAME")

	responseString := fmt.Sprintf("<h1>Cluster k8s - AMBIENTE %s - POD: %s </h1>", environmentType, podName)

	response.Write([]byte(responseString))
}

func health(response http.ResponseWriter, request *http.Request) {

	duration := time.Since(startedAt)

	if duration < SECONDS_START {
		response.WriteHeader(500)
	} else {
		response.WriteHeader(200)
	}

	response.Write([]byte(fmt.Sprintf("Duration: %f", duration.Seconds())))
}
