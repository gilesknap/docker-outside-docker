Containers in Containers Demo
=============================

This repo is a minimal example of how to create a (vscode) developer container that is able to create and manage other containers.

This simple approach installs a minimal docker cli binary only and mounts the socket of the host's docker daemon into the container. Thus the containers you manage from inside this developer container are actually running on the host itself.

This is the lightest touch approach to launching containers from inside containers, But do be aware of the security risks, as a compromised developer container would be able to launch any container on the host.

This approach can work with docker or podman on the host.


rootless podman support
-----------------------

Podman does not by default run a daemon. However, it does support creating a user daemon which presents the same API as docker. This is really useful for making it compatible with clients to the docker API.

To create a user podman daemon you can run the following command:

```bash
systemctl --user enable podman --now
```

This will create a user podman daemon with docker API compatible socket.

This command need only be run once - the user podman daemon will start automatically when you log in.

The socket location must be published so that clients know where to find it. The following command will do this. You would need to run this before launching vscode, it is recommended that you place this command in `.bashrc` or `.zshrc` so that you can use it in any terminal.

```bash
export DOCKER_HOST=/run/user/$(id -u)/podman/podman.sock
```

rootless docker support
-----------------------

To use this devcontainer with docker you need to switch to rootless docker.

With a standard docker installation you can add rootless support with this command (follow the instructions that it prints):

```bash
dockerd-rootless-setuptool.sh -f install
```

The -f means that you can keep rootless and rootful docker both available, configure for rootless docker with the following command:

```bash
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
```

You may place this command in `.bashrc` or `.zshrc` so that you can use it in any terminal. But note that you should unset this variable to use rootful docker.


rootful combinations
--------------------

Using rootful docker or podman on the host with this approach is not recommended as you would need to be root inside the container to access the socket.

Modern docker has great rootless support and it is a better choice for devcontainers in particular IMHO.
