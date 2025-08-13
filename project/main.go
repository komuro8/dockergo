package main\n\
import (\n\
    "net/http"\n\
    "github.com/gin-gonic/gin"\n\
)\n\
func main() {\n\
    r := gin.Default()\n\
    r.GET("/", func(c *gin.Context) {\n\
        c.JSON(http.StatusOK, gin.H{"message": "Hola Mundo desde Go + Gin"})\n\
    })\n\
    r.Run(":8080")\n\
}
