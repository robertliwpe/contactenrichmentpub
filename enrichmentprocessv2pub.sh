#!/bin/bash

printf "\r\n\r\n"
printf '\e[1;34m%-6s\e[m' "WP Engine Lusha Contact Enrichment Script"
printf "\r\n\r\n=====================================================================================\r\n\r\n"
printf "This requires node.js (minimum version 10) to be installed locally \r\n\r\ncurl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
\r\n"
printf "If you do not already have it installed copy and run the above command.\r\n\r\n"
printf "This script will use the Lusha Contacts API to pull contacts to be enriched \r\nfrom an input CSV file.\r\n\r\n" 
printf '\e[1;31m%-6s\e[m' "You will REQUIRE a Lusha API Key. "
printf '\e[1;31m%-6s\e[m' "First Name, Last Name and Company Domain MUST be created & filled."
printf "\r\n\r\nFind the github repo here: https://github.com/robertliwpe/wpecontactenrich.git"

printf "\r\n"

printf "\r\n=====================================================================================\r\n"

printf "\r\nProvide your Lusha API key (Contact your Admin if you do not see it in the dashboard):\r\n"
read api

printf "\r\nProvide the full path to the input file:\r\n"
read input
inputfile=$(printf "/Users/$USER" && printf "$input" | tr -d "~")

printf "\r\nName the output file (this will always be saved to your desktop in CSV format):\r\n"
read -r output

printf "\r\nTASK STARTING:"
printf "\r\n=====================================================================================\r\n"
npm install json2csv
printf "\r\n=====================================================================================\r\n"
echo '"firstName","lastName","fullName","emailAddresses","phoneNumbers","company","location"' >> ~/desktop/"$output".csv
printf '..%s..' "Target File $inputfile"
printf "\r\n"
printf '..%s..' "FILE CREATED: ~/desktop/$output.csv"
printf "\r\n=====================================================================================\r\n\r\n"

#mv "$input" ./

while IFS="," read -r fname lname dom

do 
    firstname=$(printf "$fname" | cut -d'"' -f2-)
    domain=$(printf "$dom" | cut -d'"' -f1)
    lastname=${lname// /_}
    url="https://api.lusha.com/person?firstName=$firstname&lastName=$lastname&domain=$domain"
    printf "\n==============================\r\nTarget: $firstname $lastname ($domain)\n==============================\n"
    #echo $firstname
    #echo $lname
    #echo $company
    curl "$url" -H "api_key:$api" | jq -r '.[]' | json2csv | tail -n +2 >> ~/desktop/"$output".csv
    printf "\n" >> ~/desktop/"$output".csv
done < <(tail -n +2 "$inputfile")

printf "\r\n=====================================================================================\r\n"

printf "\r\nTASK COMPLETE!\r\n\r\n"