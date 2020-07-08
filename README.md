Dockerfile for building a Docker container of [eclipse/eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls), based on [Alpine Linux](https://hub.docker.com/_/openjdk)

[Built images are available here](https://hub.docker.com/r/kaylebor/eclipse.jdt.ls)

Built with OpenJDK 8, running on OpenJDK 14

Example run configuration:

        docker run -d --net=host -v /path/to/eclipse/workspace:/eclipse-workspace kaylebor/eclipse.jdt.ls