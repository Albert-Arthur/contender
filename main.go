package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"io"
	"net/http"
	"os"
)

func main() {
	logFile, _ := os.Create("logs/server.log")
	gin.DefaultWriter = io.MultiWriter(logFile, os.Stdout)

	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, http.StatusText(http.StatusOK))
	})

	r.POST("/", func(c *gin.Context) {
		c.String(http.StatusOK, http.StatusText(http.StatusOK))
	})

	err := r.Run()
	if err != nil {
		fmt.Println("Run error:", err)
	}
}
