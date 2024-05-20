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

	responseString := fmt.Sprintf("<h1>Cluster k8s - AMBIENTE %s </h1>", environmentType)

	response.Write([]byte(responseString))
}
