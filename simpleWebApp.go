package main

import (
        "net/http"
        "github.com/gin-gonic/gin"
)

func main() {
        r := gin.Default()
        r.LoadHTMLGlob("templates/*")

		r.GET("/", handleIndex)
		r.GET("/ping", handlePing)
		r.Run("0.0.0.0:8080") // listen and serve on 0.0.0.0:8080
}

func handleIndex(c *gin.Context) {
        c.HTML(http.StatusOK, "simpleweb.tmpl", gin.H{})
}

func handlePing(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{
		"message": "pong",})
}