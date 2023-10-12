
# .NET Framework Web API Docker Sample

This sample demonstrates how to use .NET Framework as a Web API and Docker together.

This sample requires the [Docker client](https://www.docker.com/products/docker-desktop/) and [.NET Framework](https://dotnet.microsoft.com/en-us/download).

## Build and run the sample with dotnet

Use the dotnet run command to start the app.

```console
cd src
dotnet run
```

## Build and run the sample with Docker

You can build and run the sample in Docker using the following commands. The instructions assume that you are in the root of the repository.

```console
docker image build -t dotnet-docker-webapi:latest .
docker run -dp 8000:80 --name dotnet-docker-webapi-container dotnet-docker-webapi:latest
```

## Build and run the sample with Divio

You can build and run the sample in Divio on your computer using the following commands. The instructions assume that you are in the root of the repository and that you have installed [Divio CLI](https://docs.divio.com/introduction/01-installation/).

```console
divio app up
```