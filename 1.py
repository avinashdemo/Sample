import docker
import time

containers = ["app1", "app2", "app3"]  # Add your container names here

def stream_logs(container_name):
    client = docker.from_env()
    container = client.containers.get(container_name)
    for line in container.logs(stream=True, tail=0, follow=True):
        print(line.decode('utf-8'), end='')

def main():
    while True:
        for container in containers:
            try:
                stream_logs(container)
            except docker.errors.NotFound:
                # Container not found (stopped or removed)
                pass
            except docker.errors.APIError as e:
                print(f"Error streaming logs for {container}: {e}")

        time.sleep(5)  # Adjust the interval based on your needs

if __name__ == "__main__":
    main()
