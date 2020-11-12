FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["MvcMovie.csproj", "MvcMovie/"]
RUN dotnet restore "MvcMovie.csproj"
COPY . .
WORKDIR "/src/MvcMovie"
RUN dotnet build "MvcMovie.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "MvcMovie.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MvcMovie.dll"]
