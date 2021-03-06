FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build-env
WORKDIR /app

# Copy everything else and build
COPY . ./
RUN dotnet build
RUN dotnet publish -c Release -o out

# Build runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim 
WORKDIR /app
COPY --from=build-env /app/src/SampleDotNetCore2RestStub/out .
ENTRYPOINT ["dotnet", "SampleDotNetCore2RestStub.dll"]
