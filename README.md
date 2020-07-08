Dockerfile for building a Docker container of [eclipse/eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls)

Built with OpenJDK 8, running on OpenJDK 14 (latest on Arch)

Example run configuration:

        docker run -d --net=host -v /path/to/eclipse/workspace:/eclipse-workspace kaylebor/eclipse.jdt.ls