FROM mcr.microsoft.com/dotnet/core/runtime:3.0 
WORKDIR /NetCore

# copy csproj and restore as distinct layers
COPY AspNetCore.sln .
COPY aspnetapp/WebApp.csproj ./aspnetapp/
RUN dotnet restore

# copy everything else and build app
COPY aspnetapp/. ./aspnetapp/
WORKDIR /app/aspnetapp
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY /app/aspnetapp/out ./
ENTRYPOINT ["dotnet", "WebApp.dll"]
