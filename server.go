package main

import "net/http"

func main() {
	http.HandleFunc("/", hello)
	http.ListenAndServe(":80", nil)
}

func hello(response http.ResponseWriter, request *http.Request) {
	response.Write([]byte("<h1>Hello cluster k8s</h1>"))
}
