Dockerfile for building a Docker container of [eclipse/eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls)

[Built images are available here](https://hub.docker.com/r/kaylebor/eclipse.jdt.ls)

Running on OpenJDK 11

Example run configuration:

        docker run -d --net=host -v /path/to/eclipse/workspace:/eclipse-workspace kaylebor/eclipse.jdt.ls
