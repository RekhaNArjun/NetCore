FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1803 
WORKDIR /NetCore
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk-nanoserver-1803 AS build
WORKDIR /src
COPY ["NetCore/WebApp/WebApp.csproj", "WebApp/"]
RUN dotnet restore "NetCore/WebApp/WebApp.csproj"
COPY . .
WORKDIR "/src/WebApp"
RUN dotnet build "WebApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "WebApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /NetCore
COPY publish /NetCore .
ENTRYPOINT ["dotnet", "WebApp.dll"]
