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

func loadCreds() client.Credentials {
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

	err = c.StartStack(s.ID)
	if err != nil && strings.Contains(err.Error(), "is already running") {
		log.Fatal(err)
	}
}
