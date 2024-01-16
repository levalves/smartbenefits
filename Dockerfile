FROM mcr.microsoft.com/dotnet/sdk:8.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY smartbenefits-front/smartbenefits-front.csproj smartbenefits-front/
RUN dotnet restore ./smartbenefits-front/smartbenefits-front.csproj
COPY . .
WORKDIR /src/smartbenefits-front

RUN dotnet build -c Release -o /app/build

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

EXPOSE 8080

ENTRYPOINT ["dotnet", "smartbenefits-front.dll"]