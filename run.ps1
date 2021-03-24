$SNYK_TOKEN="" #TYPE-YOUR-TOKEN
$SNYK_ORG="" #TYPE-YOUR-ORG

$path=$(get-item Services).FullName

docker run `
    -it `
    -v "$($path):/src" `
    mcr.microsoft.com/dotnet/sdk:5.0 `
    dotnet build "/src/Services.sln"


docker run -it --rm `
    -e SNYK_TOKEN=$SNYK_TOKEN `
    -v "$($path):/project" `
    snyk/snyk-cli:nuget `
    test `
    --org=$SNYK_ORG `
    --file=Service.A/obj/project.assets.json
