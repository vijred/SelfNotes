
# Sample to use OpenAI API, refer to documenation for more details t https://beta.openai.com/docs/introduction 
# Replace API key, API key can be found once oyu login to the portal.
$env:OAIKEY = "..."

$RequestBody = @{
    prompt = "Tell me the number of employees in Paychex."
    model = "text-davinci-003"
    temperature=1
    stop="."
}
$Header =@{ Authorization = "Bearer $($env:OAIKEY) " }
$RequestBody=$RequestBody | ConvertTo-Json

$RestMethodParameter=@{
    Method='Post'
    Uri ='https://api.openai.com/v1/completions'
    body=$RequestBody
    Headers=$Header
    ContentType='application/json'
}


$result = (Invoke-RestMethod @RestMethodParameter)
$result.choices[0].text
