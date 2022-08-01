package client

type Stack struct {
	ID              int           `json:"Id"`
	Name            string        `json:"Name"`
	Type            int           `json:"Type"`
	EndpointID      int           `json:"EndpointId"`
	SwarmID         string        `json:"SwarmId"`
	EntryPoint      string        `json:"EntryPoint"`
	Env             []interface{} `json:"Env"`
	ResourceControl struct {
		ID                 int           `json:"Id"`
		ResourceID         string        `json:"ResourceId"`
		SubResourceIds     []interface{} `json:"SubResourceIds"`
		Type               int           `json:"Type"`
		UserAccesses       []interface{} `json:"UserAccesses"`
		TeamAccesses       []interface{} `json:"TeamAccesses"`
		Public             bool          `json:"Public"`
		AdministratorsOnly bool          `json:"AdministratorsOnly"`
		System             bool          `json:"System"`
	} `json:"ResourceControl"`
	Status          int         `json:"Status"`
	ProjectPath     string      `json:"ProjectPath"`
	CreationDate    int         `json:"CreationDate"`
	CreatedBy       string      `json:"CreatedBy"`
	UpdateDate      int         `json:"UpdateDate"`
	UpdatedBy       string      `json:"UpdatedBy"`
	AdditionalFiles interface{} `json:"AdditionalFiles"`
	AutoUpdate      interface{} `json:"AutoUpdate"`
	GitConfig       interface{} `json:"GitConfig"`
	FromAppTemplate bool        `json:"FromAppTemplate"`
	Namespace       string      `json:"Namespace"`
	IsComposeFormat bool        `json:"IsComposeFormat"`
}
