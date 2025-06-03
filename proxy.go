package main

import (
	"fmt"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"strconv"
	"strings"
)

const (
	port           = 3000
	codeServerPort = 8443
	snakesBasePort = 5000
	docsURL        = "https://github.com/secomp2025/docs/archive/refs/heads/main.zip"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		path := strings.TrimPrefix(r.URL.Path, "/")
		segments := strings.SplitN(path, "/", 3)

		// Parse /snake/{id}
		if len(segments) >= 2 && segments[0] == "snake" {
			id, err := strconv.Atoi(segments[1])
			if err != nil {
				http.Error(w, "Invalid snake ID", http.StatusBadRequest)
				return
			}
			if id < 1 || id > 50 {
				http.NotFound(w, r)
				return
			}

			snakePort := snakesBasePort + id - 1
			snakeHost := fmt.Sprintf("localhost:%d", snakePort)
			target := &url.URL{Scheme: "http", Host: snakeHost}

			r.URL.Path = "/" + strings.Join(segments[2:], "/") // strip /snake/{id} from request path
			log.Printf("Proxying /snake/%d to %s", id, target)
			httputil.NewSingleHostReverseProxy(target).ServeHTTP(w, r)
			return
		}

		// parse /docs-dl
		if len(segments) == 1 && segments[0] == "docs-dl" {
			http.Redirect(w, r, docsURL, http.StatusFound)
			return
		}

		// fallback to localhost:8443 (code-server)
		coderServerHost := fmt.Sprintf("localhost:%d", codeServerPort)
		target := &url.URL{Scheme: "http", Host: coderServerHost}
		log.Printf("Proxying %s to %s", r.URL.Path, target)
		httputil.NewSingleHostReverseProxy(target).ServeHTTP(w, r)
	})

	portStr := fmt.Sprintf(":%d", port)
	log.Printf("Listening on %s", portStr)
	log.Fatal(http.ListenAndServe(portStr, nil))
}
