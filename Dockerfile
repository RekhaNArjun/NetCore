FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /NetCore
EXPOSE 90

FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /src
COPY ["NetCore/WebApi/WebApi.csproj", "WebApi/"]
RUN dotnet restore "WebApi/WebApi.csproj"
COPY . .
WORKDIR "/src/WebApi"
RUN dotnet build "WebApi.csproj" -c Release -o /WebApi

RUN dotnet publish "WebApi.csproj" -c Release -o /WebApi

WORKDIR /WebApi
ENTRYPOINT ["dotnet", "WebApi.dll"]
