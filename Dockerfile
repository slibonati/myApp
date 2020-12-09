# Use Microsoft's official build .NET image.
#FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
FROM registry.access.redhat.com/ubi8/dotnet-31 AS build-env
USER root
WORKDIR /app
 
# Install production dependencies.
# Copy csproj and restore as distinct layers.
COPY *.csproj ./
RUN dotnet restore

# Copy local code to the container image.
COPY . ./
WORKDIR /app

# Build a release artifact.
FROM build-env AS publish
RUN dotnet publish -c Release -o /app

# Use Microsoft's official runtime .NET image.
#FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
FROM registry.access.redhat.com/ubi8/dotnet-31 AS runtime 

WORKDIR /app
COPY --from=publish /app/ .

# Run the web service on container startup.
ENTRYPOINT ["dotnet", "myApp.dll"]
