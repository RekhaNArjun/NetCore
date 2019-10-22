FROM mcr.microsoft.com/dotnet/core/runtime:3.0 
WORKDIR /NetCore

# copy csproj and restore as distinct layers
COPY AspNetCore.sln .
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "WebApp.dll"]
