<!--[metadata]>
+++
title = "Work with a development container"
description = "How to use Docker's development environment"
keywords = ["development, inception, container, image Dockerfile, dependencies, Go,  artifacts"]
[menu.main]
parent = "smn_engine_contrib"
weight=5
+++
<![end-metadata]-->

# Work with a development container

In this section, you learn to develop like the Docker Engine core team.
The `docker` repository includes a `Dockerfile` at its root. This file defines
Docker's development environment. The `Dockerfile` lists the environment's
dependencies: system libraries and binaries, Go environment, Go dependencies,
etc.

Docker's development environment is itself, ultimately a Docker container.
You use the `docker` repository and its `Dockerfile` to create a Docker image,
run a Docker container, and develop code in the container. Docker itself builds,
tests, and releases new Docker versions using this container.

If you followed the procedures that <a href="/opensource/project/set-up-git/" target="_blank">
set up Git for contributing</a>, you should have a fork of the `docker/docker`
repository. You also created a branch called `dry-run-test`. In this section,
you continue working with your fork on this branch.

##  Task 1. Remove images and containers

Docker developers run the latest stable release of the Docker software (with
Docker Machine if their machine is Mac OS X). They clean their local hosts of
unnecessary Docker artifacts such as stopped containers or unused images.
Cleaning unnecessary artifacts isn't strictly necessary, but it is good
practice, so it is included here.

To remove unnecessary artifacts:

1. Verify that you have no unnecessary containers running on your host.

    ```bash
    $ docker ps -a
    ```

    You should see something similar to the following:

    ```bash
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    ```

    There are no running or stopped containers on this host. A fast way to
    remove old containers is the following:

    ```bash
    $ docker rm $(docker ps -a -q)
    ```

    This command uses `docker ps` to list all containers (`-a` flag) by numeric
    IDs (`-q` flag). Then, the `docker rm` command removes the resulting list.
    If you have running but unused containers, stop and then remove them with
    the `docker stop` and `docker rm` commands.

2. Verify that your host has no dangling images.

    ```bash
    $ docker images
    ```

    You should see something similar to the following:

    ```bash
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    ```

    This host has no images. You may have one or more _dangling_ images. A
    dangling image is not used by a running container and is not an ancestor of
    another image on your system. A fast way to remove dangling image is
    the following:

    ```bash
    $ docker rmi -f $(docker images -q -a -f dangling=true)
    ```

    This command uses `docker images` to list all images (`-a` flag) by numeric
    IDs (`-q` flag) and filter them to find dangling images (`-f dangling=true`).
    Then, the `docker rmi` command forcibly (`-f` flag) removes
    the resulting list. If you get a "docker: "rmi" requires a minimum of 1 argument."
    message, that means there were no dangling images. To remove just one image, use the
    `docker rmi ID` command.

## Task 2. Start a development container

If you followed the last procedure, your host is clean of unnecessary images and
containers. In this section, you build an image from the Engine development
environment and run it in the container. Both steps are automated for you by the
Makefile in the Engine code repository. The first time you build an image, it
can take over 15 minutes to complete.

1. Open a terminal.

    Mac users, use `docker-machine status your_vm_name` to make sure your VM is running. You
    may need to run `eval "$(docker-machine env your_vm_name)"` to initialize your
    shell environment.

2. Change into the root of the `docker-fork` repository.

    ```bash
    $ cd ~/repos/docker-fork
    ```

  	If you are following along with this guide, you created a `dry-run-test`
  	branch when you <a href="/opensource/project/set-up-git/" target="_blank"> set up Git for
  	contributing</a>.

3. Ensure you are on your `dry-run-test` branch.

    ```bash
    $ git checkout dry-run-test
    ```

    If you get a message that the branch doesn't exist, add the `-b` flag (`git checkout -b dry-run-test`) so the
    command both creates the branch and checks it out.

4. Use `make` to build a development environment image and run it in a container.

    ```bash
    $ make BIND_DIR=. shell
    ```

    The command returns informational messages as it runs. The first build may
    take a few minutes to create an image. Using the instructions in the
    `Dockerfile`, the build may need to download source and other images. A
    successful build returns a final message and opens a Bash shell into the
    container.

    ```bash
    Successfully built 3d872560918e
    docker run --rm -i --privileged -e BUILDFLAGS -e KEEPBUNDLE -e DOCKER_BUILD_GOGC -e DOCKER_BUILD_PKGS -e DOCKER_CLIENTONLY -e DOCKER_DEBUG -e DOCKER_EXPERIMENTAL -e DOCKER_GITCOMMIT -e DOCKER_GRAPHDRIVER=devicemapper -e DOCKER_INCREMENTAL_BINARY -e DOCKER_REMAP_ROOT -e DOCKER_STORAGE_OPTS -e DOCKER_USERLANDPROXY -e TESTDIRS -e TESTFLAGS -e TIMEOUT -v "home/ubuntu/repos/docker/bundles:/go/src/github.com/docker/docker/bundles" -t "docker-dev:dry-run-test" bash
    root@f31fa223770f:/go/src/github.com/docker/docker#
    ```

    At this point, your prompt reflects the container's BASH shell.

5. List the contents of the current directory (`/go/src/github.com/docker/docker`).

    You should see the image's source from the  `/go/src/github.com/docker/docker`
    directory.

      ![List example](images/list_example.png)

6. Make a `docker` binary.

    ```bash
    root@a8b2885ab900:/go/src/github.com/docker/docker# hack/make.sh binary
    ...output snipped...
    bundles/1.12.0-dev already exists. Removing.

    ---> Making bundle: binary (in bundles/1.12.0-dev/binary)
    Building: bundles/1.12.0-dev/binary/docker-1.12.0-dev
    Created binary: bundles/1.12.0-dev/binary/docker-1.12.0-dev
    Copying nested executables into bundles/1.12.0-dev/binary
  ```

7. Copy the binary to the container's `/usr/bin` directory.

    ```bash
    root@a8b2885ab900:/go/src/github.com/docker/docker# cp bundles/1.12.0-dev/binary-client/docker* /usr/bin
    root@a8b2885ab900:/go/src/github.com/docker/docker# cp bundles/1.12.0-dev/binary-daemon/docker* /usr/bin
    ```

8. Start the Engine daemon running in the background.

    ```bash
    root@a8b2885ab900:/go/src/github.com/docker/docker# docker daemon -D&
    ...output snipped...
    DEBU[0001] Registering POST, /networks/{id:.*}/connect
    DEBU[0001] Registering POST, /networks/{id:.*}/disconnect
    DEBU[0001] Registering DELETE, /networks/{id:.*}
    INFO[0001] API listen on /var/run/docker.sock
    DEBU[0003] containerd connection state change: READY
    ```

    The `-D` flag starts the daemon in debug mode. The `&` starts it as a
    background process. You'll find these options useful when debugging code
    development.

9. Inside your container, check your Docker version.

    ```bash
    root@5f8630b873fe:/go/src/github.com/docker/docker# docker --version
    Docker version 1.12.0-dev, build 6e728fb
    ```

    Inside the container you are running a development version. This is the version
    on the current branch. It reflects the value of the `VERSION` file at the
    root of your `docker-fork` repository.

10. Run the `hello-world` image.

    ```bash
    root@5f8630b873fe:/go/src/github.com/docker/docker# docker run hello-world
    ```

11. List the image you just downloaded.

    ```bash
    root@5f8630b873fe:/go/src/github.com/docker/docker# docker images
    ```

12. Open another terminal on your local host.

13. List the container running your development container.

    ```bash
    ubuntu@ubuntu1404:~$ docker ps
    CONTAINER ID        IMAGE                     COMMAND             CREATED             STATUS              PORTS               NAMES
    a8b2885ab900        docker-dev:dry-run-test   "hack/dind bash"    43 minutes ago      Up 43 minutes                           hungry_payne
    ```

    Notice that the tag on the container is marked with the `dry-run-branch` name.


## Task 3. Make a code change

At this point, you have experienced the "Docker inception" technique. That is,
you have:

* forked and cloned the Docker Engine code repository
* created a feature branch for development
* created and started a Engine development container from your branch
* built a Docker binary inside of your Docker development container
* launched a `docker` daemon using your newly compiled binary
* called the `docker` client to run a `hello-world` container inside
  your development container

Running the `make shell` command mounted your local Docker repository source into
your Docker container. When you start to developing code though, you'll
want to iterate code changes and builds inside the container. If you have
followed this guide exactly, you have a BASH shell running a development
container.

Try a simple code change and see it reflected in your container. For this
example, you'll edit the help for the `attach` subcommand.

1. If you don't have one, open a terminal in your local host.

2. Make sure you are in your `docker-fork` repository.

    ```bash
    $ pwd
    /Users/mary/go/src/github.com/moxiegirl/docker-fork
    ```

    Your location should be different because, at least, your username is
    different.

3. Open the `api/client/attach.go` file.

4. Edit the command's help message.

    For example, you can edit this line:

    ```go
    noStdin := cmd.Bool([]string{"-no-stdin"}, false, "Do not attach STDIN")
    ```

    And change it to this:

    ```go
    noStdin := cmd.Bool([]string{"-no-stdin"}, false, "Do not attach STDIN (standard in)")
    ```

5. Save and close the `api/client/attach.go` file.

6. Go to your running development container.

7. Remake the binary and copy it to `usr/bin`

8. Restart the Docker daemon with the new binary.

9. View your change by display the `attach` help.

    ```bash
    root@b0cb4f22715d:/go/src/github.com/docker/docker# docker attach --help

    Usage:	docker attach [OPTIONS] CONTAINER

    Attach to a running container

    --detach-keys       Override the key sequence for detaching a container
    --help              Print usage
    --no-stdin          Do not attach to STDIN (standard in)
    --sig-proxy=true    Proxy all received signals to the process
    ```

You've just done the basic workflow for changing the Engine code base. You made
your code changes in your feature branch. Then, you updated the binary in your
development container and tried your change out. If you were making a bigger
change, you might repeat or iterate through this flow several times.

## Where to go next

Congratulations, you have successfully achieved Docker inception. You've had a
small experience of the develpment process. You've set up your development
environment and verified almost all the essential processes you need to
contribute. Of course, before you start contributing, [you'll need to learn one
more piece of the development process, the test framework](test-and-docs.md).
