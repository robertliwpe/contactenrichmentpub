#!/bin/bash

printf '\e[1;34m%-6s\e[m' "WP Engine Lusha Contact Enrichment Script"
printf "\r\n\r\n=====================================================================================\r\n\r\n"
printf "This requires node.js (minimum version 10) to be installed locally \r\n\r\n          curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
\r\n\r\n"
printf "You also require Homebrew to be installed\r\n\r\n          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"\r\n\r\n"
printf "If you do not already have them installed copy and run the above commands.\r\n\r\n"
printf "This script will use the Lusha Contacts API to pull contacts to be enriched \r\nfrom an input CSV file.\r\n\r\n" 
printf '\e[1;31m%-6s\e[m' "You will REQUIRE a Lusha API Key. "
printf '\e[1;31m%-6s\e[m' "First Name, Last Name and Company Domain MUST be created & filled."
printf "\r\n\r\nFind the github repo here: https://github.com/robertliwpe/wpecontactenrich.git"
printf "\r\n\r\n=====================================================================================\r\n"

printf "\r\nProvide your Lusha API key (Contact your Admin if you do not see it in the dashboard):\r\n"
read -r api

printf "\r\nProvide the full path to the input file:\r\n"
read input

tilda="~"

if [[ $input == *"$tilda"* ]]
    then
        echo "Replacing $tilda with /Users/$USER..."
        inputfile=$(printf "/Users/$USER" && printf "$input" | tr -d "~")
        echo "Confirm Input file is $inputfile..."
    else
        inputfile=$input
        echo "Confirm Input file is $inputfile..."
fi;

printf "\r\nName the output file (this will always be saved to your desktop in CSV format):\r\n"
read -r output

printf "\r\nTASK STARTING:"
printf "\r\n=====================================================================================\r\n"
brew install jq dasel
npm install -g commander async rimraf winston colors
brew link --overwrite jq
printf "\r\n=====================================================================================\r\n"
echo "company,emailAddresses,firstName,fullName,lastName,location,phoneNumbers" >> ~/desktop/"$output".csv
printf '..%s..' "Target File $inputfile"
printf "\r\n"
printf '..%s..' "FILE CREATED: ~/desktop/$output.json"
printf "\r\n=====================================================================================\r\n\r\n"

#mv "$input" ./


while IFS="," read -r fname lname dom

do 
    firstname=$(printf "$fname" | cut -d'"' -f2-)
    domain=$(printf "$dom" | cut -d'"' -f1)
    lastname=${lname// /_}
    url="https://api.lusha.com/person?firstName=$firstname&lastName=$lastname&domain=$domain"
    printf "\n==============================\r\nTarget: $firstname $lastname ($domain)\n==============================\n"
    # echo $firstname
    # echo $lastname
    # echo $domain
    echo API REQUEST\: $url
    # cli no longer supported in winston3 json2csv no longer works
    # curl "$url" -H "api_key:$api" | jq -r '.[]' | json2csv | tail -n +2 >> ~/desktop/"$output".csv
    curl "$url" -H "api_key:$api" > ~/desktop/"$output".json
    dasel -f ~/desktop/"$output".json 'data' | dasel -r json -w csv | grep "map" >> ~/desktop/"$output".csv
done < <(tail -n +2 "$inputfile")

printf "\r\n=====================================================================================\r\n"
printf "\r\nCleaning up...\r\n"

rm ~/desktop/"$output".json

sleep 2;

printf "\r\nTASK COMPLETE!\r\n\r\n"
