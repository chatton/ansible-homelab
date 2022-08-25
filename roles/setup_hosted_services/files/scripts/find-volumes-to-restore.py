#!/usr/bin/python
import os
import yaml

from pathlib import Path


def main():
    existing = eval(os.getenv("EXISTING_VOLUMES"))
    services = eval(os.getenv("SERVICES"))
    docker_compose_dir = os.getenv("DOCKER_COMPOSE_DIR")

    full_volume_names = []
    missing_volumes = []
    for service in services:
        service_name = service["name"]
        docker_file = f"{docker_compose_dir}/{service_name}/docker-compose.yml"
        docker_compose_dict = yaml.safe_load(Path(docker_file).read_text())

        # no volumes specified in the compose file
        if "volumes" not in docker_compose_dict:
            continue

        volumes = docker_compose_dict["volumes"]

        for v in volumes:
            full_volume_names.append(f"{service_name}_{v}")

    for volume_name in full_volume_names:
        if volume_name not in existing:
            missing_volumes.append(volume_name)

    for mv in missing_volumes:
        if mv:
            print(mv)


if __name__ == "__main__":
    main()
