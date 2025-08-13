# Paso 1: Descargar la imagen oficial de Go
FROM golang:1.22 AS build

# Instalar git para clonar el repo
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Paso 2: Clonar el repo desde GitHub
WORKDIR /src
RUN git clone https://github.com/komuro8/dockergo.git

# Paso 3: Reemplazar el main.go para Hola Mundo
WORKDIR /src/dockergo
RUN rm -f main.go
RUN echo 'package main\n\
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
}' > main.go

# Paso 4: Descargar dependencias y compilar
RUN go mod tidy && go build -o server .

# Paso 5: Crear la imagen final
FROM debian:bookworm-slim
WORKDIR /app
COPY --from=build /src/dockergo/server .
EXPOSE 8080
CMD ["./server"]
