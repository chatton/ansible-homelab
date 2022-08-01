package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"os"
	"os/user"

	"github.com/chatton/portainer/client"
)

const (
	applicationJson = "application/json"
	baseUrl         = "http://qnap:9000"
)

type PortainerCredentials struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func loadCreds() PortainerCredentials {
	usr, _ := user.Current()
	credPath := fmt.Sprintf("%s/.homelab/portainer-creds.json", usr.HomeDir)

	if _, err := os.Stat(credPath); errors.Is(err, os.ErrNotExist) {
		log.Fatal(fmt.Errorf("there must be a credentials file under: %s", credPath))
	}

	fileBytes, err := os.ReadFile(credPath)
	if err != nil {
		log.Fatal(err)
	}

	creds := PortainerCredentials{}
	if err := json.Unmarshal(fileBytes, &creds); err != nil {
		log.Fatal(err)
	}
	return creds
}

func main() {
	c := client.NewPortainerClient(baseUrl)
	creds := loadCreds()
	err := c.Login(creds.Username, creds.Password)
	if err != nil {
		log.Fatalln(err)
	}
}
