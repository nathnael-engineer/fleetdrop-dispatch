package main

import (
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/ws/telemetry", func(w http.ResponseWriter, r *http.Request) {
		log.Println("[FleetDrop] Telemetry client connected")
	})
	log.Println("FleetDrop Go Engine listening on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}