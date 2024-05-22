package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", hello)
	http.ListenAndServe(":8080", nil)
}

func hello(response http.ResponseWriter, request *http.Request) {

	environmentType := os.Getenv("ENVIRONMENT_TYPE")

	podName := os.Getenv("POD_NAME")

	responseString := fmt.Sprintf("<h1>Cluster k8s - AMBIENTE %s - POD: %s </h1>", environmentType, podName)

	response.Write([]byte(responseString))
}
