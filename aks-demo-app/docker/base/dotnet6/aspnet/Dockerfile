# Dockerfile base image based on alpine
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://*:8080

# Disable Globalization Invariant Mode. See: https://github.com/dotnet/announcements/issues/20
ENV \
     DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
     LC_ALL=en_US.UTF-8 \
     LANG=en_US.UTF-8

RUN apk update && \
  apk add --no-cache openssl  \
      icu-data-full \
      icu-libs && \
  rm -rf /var/cache/apk/*
