FROM mcr.microsoft.com/dotnet/core/runtime:2.2 
WORKDIR /NetCore

# Copy csproj and restore as distinct layers
COPY WebApp.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /NetCore

COPY --from= ./NetCore
/out .
ENTRYPOINT ["dotnet", "WebApp.dll"]
