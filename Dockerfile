# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/sdk:7.0 as build-env
# FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:7.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["dotnet-docker-webapi.csproj", "./"]
RUN dotnet restore "dotnet-docker-webapi.csproj"
COPY . .
WORKDIR "/src/."
# RUN dotnet build "dotnet-docker-webapi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "dotnet-docker-webapi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENV ASPNETCORE_URLS=http://+:80 
ENV DOTNET_HOSTBUILDER__RELOADCONFIGONCHANGE=false
# Divio
# --------------------
ENV PORT=80
ENV HOST=0.0.0.0
ENV BROWSER='none'

ENTRYPOINT ["dotnet", "dotnet-docker-webapi.dll"]
