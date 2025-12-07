package main

import (
	"encoding/json"
	"net/http"
)

func main() {
	// Health check endpoint
	http.HandleFunc("/status", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("OK"))
	})

	// Items endpoint
	http.HandleFunc("/items", func(w http.ResponseWriter, r *http.Request) {
		items := []string{"Laptop", "Keyboard", "Phone"}
		json.NewEncoder(w).Encode(items)
	})

	// Start server
	http.ListenAndServe(":8080", nil)
}
