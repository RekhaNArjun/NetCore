FROM mcr.microsoft.com/dotnet/core/runtime:3.0 
WORKDIR /NetCore

# copy csproj and restore as distinct layers
COPY AspNetCore.sln .
RUN dotnet restore
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /NetCore
COPY /app/aspnetapp/out ./
ENTRYPOINT ["dotnet", "WebApp.dll"]
