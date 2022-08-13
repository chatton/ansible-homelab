#!/usr/bin/python
import os


def main():
    existing = eval(os.getenv("EXISTING_VOLUMES"))
    services = eval(os.getenv("SERVICES"))

    missing_volumes = []
    for service in services:
        for volume_name in service.get("volumes", []):
            if volume_name not in existing:
                missing_volumes.append(volume_name)

    for mv in missing_volumes:
        print(mv)


if __name__ == "__main__":
    main()
