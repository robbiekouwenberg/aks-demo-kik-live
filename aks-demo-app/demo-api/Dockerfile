# Dockerfile image for api
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src
COPY ["demo-api/demo-api.csproj", "demo-api/"]
COPY ["demo-models/demo-models.csproj", "demo-models/"]
RUN dotnet restore "demo-api/demo-api.csproj"
COPY . .
WORKDIR "/src/demo-api"
RUN dotnet build "demo-api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "demo-api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM acrweuvecozodemo.azurecr.io/base/dotnet6/aspnet AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "demo-api.dll"]