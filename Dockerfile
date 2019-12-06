  
FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /NetCore

FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /src
COPY ["WebApp/WebApp.csproj", "WebApp/"]
RUN dotnet restore "WebApp/WebApp.csproj"
COPY . .
WORKDIR "/src/WebApp"
RUN dotnet build "WebApp.csproj" -c Release -o /WebApp

RUN dotnet publish "WebApp.csproj" -c Release -o /WebApp

WORKDIR /WebApp
ENTRYPOINT ["dotnet", "WebApp.dll"]
