docker-sshd
===========

Dockerfile for SSH server with public key authentication enabled

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/sshd/)

```sh
$ docker pull dceoy/sshd
```

Usage
-----

1.  Check out the repository.

    ```sh
    $ git clone https://github.com/dceoy/docker-sshd.git
    $ cd docker-sshd
    ```

2.  Create public/private RSA key pair.

    ```sh
    $ docker-compose --rm --entrypoint=/usr/bin/ssh-keygen --volume=${PWD}/keys:/root/.ssh sshd -t rsa
    ```

    If you use an already-existing pair, copy the public key file into `keys/` instead of the above step.

3.  Create a symlink to the public key file with SSH username `root`.

    ```sh
    $ ln -s id_rsa.pub keys/root
    ```

4.  Run an SSH server

    ```sh
    $ docker-compose up
    ```

5.  Connect to the SSH server with the private key

    ```sh
    $ ssh -i keys/id_rsa -p 2222 root@127.0.0.1
    ```
