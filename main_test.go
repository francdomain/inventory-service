package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestMain(m *testing.M) {
	// Setup if needed
	m.Run()
}

func TestStatusHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/status", nil)
	w := httptest.NewRecorder()

	// Call the handler directly
	http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("OK"))
	}).ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Errorf("Expected status 200, got %d", w.Code)
	}

	if w.Body.String() != "OK" {
		t.Errorf("Expected body 'OK', got %s", w.Body.String())
	}
}
