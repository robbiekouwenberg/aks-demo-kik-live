# Dockerfile for app
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src
COPY ["demo-app/demo-app.csproj", "demo-app/"]
COPY ["demo-models/demo-models.csproj", "demo-models/"]
RUN dotnet restore "demo-app/demo-app.csproj"
COPY . .
WORKDIR "/src/demo-app"
RUN dotnet build "demo-app.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "demo-app.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM acrweuvecozodemo.azurecr.io/base/dotnet6/aspnet AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "demo-app.dll"]