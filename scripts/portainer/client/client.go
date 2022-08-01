package client

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

const (
	applicationJson = "application/json"
)

type PortainerClient struct {
	authToken string
	baseUrl   string
}

func NewPortainerClient(baseUrl string) *PortainerClient {
	return &PortainerClient{
		baseUrl: baseUrl,
	}
}

func (c *PortainerClient) IsLoggedIn() bool {
	return c.authToken != ""
}

func (c *PortainerClient) post(path string, payload interface{}) ([]byte, error) {
	jsonBytes, err := json.Marshal(payload)
	if err != nil {
		return nil, err
	}

	url := fmt.Sprintf("%s/%s", c.baseUrl, path)
	resp, err := http.Post(url, applicationJson, bytes.NewBuffer(jsonBytes))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	return body, nil
}

func (c *PortainerClient) Login(username, password string) error {
	payload := map[string]string{"Username": username, "Password": password}
	body, err := c.post("api/auth", payload)
	if err != nil {
		return err
	}
	type JwtToken struct {
		Token string `json:"jwt"`
	}
	token := JwtToken{}
	if err := json.Unmarshal(body, &token); err != nil {
		return err
	}
	c.authToken = token.Token
	return nil
}
