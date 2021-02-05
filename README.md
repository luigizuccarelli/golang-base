# Golang base docker image

* This is a base docker image that will be used for all our golang microservices builds (cicd openshift/tekton pipelines)
* Redhat UBI image
* Version 1.15.6 for golang
* Includes gcc and binutils (for c and c++) compiling

## Create base image

Example build
```bash

podman build -t quay.io/luigizuccarelli/golang-base:1.15.6 .

```




