# IDE Image

## Docker Build
```bash
# Build idea-slim
docker build --target idea-slim \
             --build-arg INTELLIJ_VERSION=2021.1 \
             -t idea-slim:latest .

# Build with customized jdk
docker build --target idea-customize-jdk \
             --build-arg INTELLIJ_VERSION=2021.1 \
             --build-arg JDK_VERSION=zulu11.45.27-ca-jdk11.0.10 \
             -t idea-customize-jdk:latest .
```
## Install VcXsrv
1. Install [VcXsrv](https://sourceforge.net/projects/vcxsrv/) on the host
2. Execute the XLauncher and checked Disable access control.

## Docker run
```bash
# First run
docker run --name=idea-slim -e DISPLAY=192.168.1.101:0 -it idea-slim:latest

# Start existed container
docker container start idea-slim
```