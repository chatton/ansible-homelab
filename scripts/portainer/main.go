package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"os"
	"os/user"
	"strings"

	"github.com/chatton/portainer/client"
)

const (
	portainerUserNameEnv = "PORTAINER_USER_NAME"
	portainerPasswordEnv = "PORTAINER_PASSWORD"
	portainerBaseUrlEnv  = "PORTAINER_BASE_URL"
)

func loadCredsFromEnv() client.Credentials {
	userName, _ := os.LookupEnv(portainerUserNameEnv)
	password, _ := os.LookupEnv(portainerPasswordEnv)
	baseUrl, _ := os.LookupEnv(portainerBaseUrlEnv)
	return client.Credentials{
		Username: userName,
		Password: password,
		BaseUrl:  baseUrl,
	}
}

func loadCreds() client.Credentials {
	// look for env vars first
	creds := loadCredsFromEnv()
	if creds.IsValid() {
		return creds
	}
	// fallback to file
	return loadCredsFromFile()
}

func loadCredsFromFile() client.Credentials {
	usr, _ := user.Current()
	credPath := fmt.Sprintf("%s/.homelab/portainer-creds.json", usr.HomeDir)

	if _, err := os.Stat(credPath); errors.Is(err, os.ErrNotExist) {
		log.Fatal(fmt.Errorf("there must be a credentials file under: %s", credPath))
	}

	fileBytes, err := os.ReadFile(credPath)
	if err != nil {
		log.Fatal(err)
	}

	creds := client.Credentials{}
	if err := json.Unmarshal(fileBytes, &creds); err != nil {
		log.Fatal(err)
	}
	return creds
}

type StackResult struct {
	Name string `json:"name"`
	Id   int    `json:"id"`
}

func main() {
	args := os.Args
	if len(args) != 2 {
		fmt.Println("must specify name of stack to start!")
		os.Exit(1)
	}

	stackName := args[1]
	creds := loadCreds()
	c, err := client.NewPortainerClient(creds)
	if err != nil {
		log.Fatal(err)
	}
	s, err := c.GetStackByName(stackName)
	if err != nil {
		log.Fatal(err)
	}
	if s == nil {
		log.Fatalf("no stack found with name: %s\n", stackName)
	}

	msg, err := c.StartStack(s.ID)
	if err != nil {
		log.Fatal(err)
	}

	if msg.Details != "" && !strings.Contains(msg.Details, "is already running") {
		log.Fatalf("problem starting stack: %s", msg.Details)
	}

	sr := StackResult{
		Name: stackName,
		Id:   s.ID,
	}

	bytes, err := json.Marshal(sr)
	if err != nil {
		log.Fatal(err)
	}
	// output details of the stack that was started (or is already started)
	fmt.Println(string(bytes))
}
