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

// api docs
// https://app.swaggerhub.com/apis/portainer/portainer-ce/2.9.3

type PortainerClient struct {
	authToken string
	baseUrl   string
}

type Credentials struct {
	Username string `json:"username"`
	Password string `json:"password"`
	BaseUrl  string `json:"baseUrl"`
}

func NewPortainerClient(creds Credentials) (*PortainerClient, error) {
	c := &PortainerClient{
		baseUrl: creds.BaseUrl,
	}
	return c, c.Login(creds.Username, creds.Password)
}

func (c *PortainerClient) IsLoggedIn() bool {
	return c.authToken != ""
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

func (c *PortainerClient) GetAllStacks() ([]Stack, error) {
	b, err := c.get("stacks")
	if err != nil {
		return nil, err
	}
	var stacks []Stack
	if err := json.Unmarshal(b, &stacks); err != nil {
		return nil, err
	}
	return stacks, nil
}

func (c *PortainerClient) GetStackByName(name string) (*Stack, error) {
	stacks, err := c.GetAllStacks()
	if err != nil {
		return nil, err
	}
	for _, s := range stacks {
		if s.Name == name {
			return &s, nil
		}
	}
	return nil, nil
}

func (c *PortainerClient) StartStack(stackId int) error {
	url := fmt.Sprintf("api/stacks/%d/start", stackId)
	b, err := c.post(url, nil)
	fmt.Println(string(b))
	return err
}
func (c *PortainerClient) post(path string, payload interface{}) ([]byte, error) {
	jsonBytes, err := json.Marshal(payload)
	if err != nil {
		return nil, err
	}
	url := fmt.Sprintf("%s/%s", c.baseUrl, path)
	// Create a Bearer string by appending string access token
	var bearer = "Bearer " + c.authToken
	// Create a new request using http
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonBytes))

	// add authorization header to the req
	req.Header.Add("Authorization", bearer)

	// Send req using http Client
	client := &http.Client{}
	resp, err := client.Do(req)
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

func (c *PortainerClient) get(path string) ([]byte, error) {
	url := fmt.Sprintf("%s/api/%s", c.baseUrl, path)

	// Create a Bearer string by appending string access token
	var bearer = "Bearer " + c.authToken
	// Create a new request using http
	req, err := http.NewRequest("GET", url, nil)

	// add authorization header to the req
	req.Header.Add("Authorization", bearer)

	// Send req using http Client
	client := &http.Client{}
	resp, err := client.Do(req)
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
