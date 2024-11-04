Containers in Containers Demo
=============================

This repo is a minimal example of how to create a (vscode) developer container that is able to create and manage other containers. This simple approach installs a minimal docker cli binary only and mounts the socket of the host's docker daemon into the container. Thus the containers you manage from inside this developer container are actually running on the host itself.

This is the lightest touch approach to launching containers from inside containers, But do be aware of the security risks, as a compromised developer container would be able to launch any container on the host.

This approach can work with docker or podman on the host.

Because devcontainer.json is not parameterized I have created two versions of the file. One for docker and one for podman. The podman version is in the main branch of this repo and the docker version is in the 'docker' branch.

(we can get most of the way to a generic devcontainer.json using environment variables. But the separate branches make for a cleaner implementation that is easy to read)

rootless podman support
-----------------------

Podman does not by default run a daemon. However, it does support creating a user daemon which presents the same API as docker. This is really useful for making int compatible with clients to the docker API, the docker cli included.

To create a user podman daemon you can run the following command:

```bash
systemctl --user enable podman --now
```

This will create a user podman daemon with docker API compatible socket. The socket location can be determined using either of the following commands:

```bash
echo /run/user/${id -u}/podman/podman.sock
echo $XDG_RUNTIME_DIR/podman/podman.sock
```

This command need only be run once - the user podman daemon will start automatically when you log in.

This is all you need to do before launching this devcontainer. You will be able to use any docker command from inside the container and it will be executed in the hosts rootless podman.

rootful docker support
----------------------

To use this devcontainer with docker you must checkout the docker branch of this repo. The devcontainer.json file in that branch is configured to use the docker socket in the host.

Docker will need to be installed on the host and the user must be a member of the docker group. This is the default configuration for docker on most systems.

No further configuration is required before launching this devcontainer.

other combinations
------------------

I have chosen rootless podman and rootful docker as the two examples because they are the default configurations for these tools. rootful podman and rootless docker would also be possible, you would just need to configure the hosts container runtime accordingly and pass the correct socket into the devcontainer.
