package main

import (
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
)

const defaultPort = "8080"

func setupRouter() *gin.Engine {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.String(200, "pong")
	})
	return r
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	r := setupRouter()
	r.Run(
		fmt.Sprintf(":%s", port),
	)
}
