import requests


def _query_params_to_string(params):
    s = "?"
    for k, v in params.items():
        s += f"&{k}={v}"
    return s


class PortainerClient:
    def __init__(self, base_url, endpoint):
        self.endpoint = endpoint
        self.base_url = base_url
        self.token = ""
        self.headers = {}

    def login(self, username, password):
        payload = {
            "Username": username,
            "Password": password,
        }
        auth_url = f"{self.base_url}/api/auth"
        resp = requests.post(auth_url, json=payload)
        resp.raise_for_status()
        self.token = resp.json()["jwt"]
        self.headers = {"Authorization": f"Bearer {self.token}"}

    def get(self, get_endpoint, query_params=None):
        url = f"{self.base_url}/api/{get_endpoint}"
        if query_params:
            url = url + _query_params_to_string(query_params)

        res = requests.get(url, headers=self.headers)
        res.raise_for_status()
        return res.json()

    def delete(self, endpoint):
        url = f"{self.base_url}/api/{endpoint}"
        try:
            # TODO: deletion works, but the request fails?
            res = requests.delete(url, headers=self.headers)
            res.raise_for_status()
        except Exception:
            pass
        return {}

    def put(self, endpoint, body):
        url = f"{self.base_url}/api/{endpoint}"
        res = requests.put(url, json=body, headers=self.headers)
        res.raise_for_status()
        return res.json()

    def post(self, endpoint, body, query_params=None):
        url = f"{self.base_url}/api/{endpoint}" + _query_params_to_string(query_params)

        res = requests.post(url, json=body, headers=self.headers)
        res.raise_for_status()
        return res.json()
