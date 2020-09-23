package main

import (
	"net/http"
	"log"
	//"fmt"
    "io/ioutil"
	"github.com/gin-gonic/gin"
)

func main() {
    //myPath()
	r := gin.Default()
	r.LoadHTMLGlob("templates/*")

	r.GET("/", handleIndex)
	r.GET("/ping", handlePing)
	r.GET("/health", handleHealth)
	r.GET("/path", myPath)
	r.Run("0.0.0.0:80") // listen and serve on 0.0.0.0:80
}

func handleIndex(c *gin.Context) {
	c.HTML(http.StatusOK, "simpleweb.tmpl", gin.H{})
}

func myPath(c *gin.Context) {
    files, err := ioutil.ReadDir("./")
    if err != nil {
        log.Fatal(err)
    }
    out := make([]string, 0)
    for _, f := range files {
        out = append(out, f.Name())
    }
    c.JSON(200, out)
}

func handlePing(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "pong"})
}

func handleHealth(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "healthy"})
}
