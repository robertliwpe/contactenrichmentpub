#!/bin/bash

printf "\r\n\r\n"
printf '\e[1;34m%-6s\e[m' "WP Engine Lusha Contact Enrichment Script"
printf "\r\n\r\n=====================================================================================\r\n\r\n"
printf "This requires node.js (minimum version 10) to be installed locally \r\n\r\ncurl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
\r\n"
printf "If you do not already have it installed copy and run the above command.\r\n\r\n"
printf "This script will use the Lusha Contacts API to pull contacts to be enriched \r\nfrom an input CSV file.\r\n\r\n" 
printf '\e[1;31m%-6s\e[m' "You will REQUIRE a Lusha API Key. "
printf '\e[1;31m%-6s\e[m' "First Name, Last Name and Company MUST be created & filled."
printf "\r\n\r\nFind the github repo here: https://github.com/robertliwpe/wpecontactenrich.git"

printf "\r\n"

printf "\r\n=====================================================================================\r\n"

printf "\r\nProvide your Lusha API key (Contact your Admin if you do not see it in the dashboard):\r\n"
read -r api

printf "\r\nProvide the full path to the input file:\r\n"
read -r input

printf "\r\nName the output file (this will always be saved to your desktop in CSV format):\r\n"
read -r output

printf "\r\nTASK STARTING:"
printf "\r\n=====================================================================================\r\n"
npm install json2csv
printf "\r\n====================================================================================="
echo '"firstName","lastName","fullName","emailAddresses","phoneNumbers","company","location"' >> ~/desktop/$output.csv
printf "\r\nFILE CREATED: ~/desktop/$output.csv"
printf "\r\n=====================================================================================\r\n"

while IFS="," read -r fname lname co

do 
    firstname=$(printf $fname | cut -d'"' -f2-)
    company=$(printf $co | cut -d'"' -f1)
    url="https://api.lusha.com/person?firstName=$firstname&lastName=$lname&company=$company"
    printf "\n==============================\r\nTarget: $firstname $lname ($company)\n==============================\n"
    #echo $firstname
    #echo $lname
    #echo $company
    curl $url -H "api_key:$api" | jq -r '.[]' | json2csv | tail -n +2 >> ~/desktop/$output.csv
    echo "\n" >> ~/desktop/$output.csv
done < <(tail -n +2 $input)

printf "\r\n=====================================================================================\r\n"
printf "\r\nTASK COMPLETE!\r\n\r\n"