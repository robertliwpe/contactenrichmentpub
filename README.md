# WP Engine Lusha Contact Enrichment Script
This requires node.js (minimum version 10) to be installed locally

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash`

If you do not already have it installed copy and run the above command.

This script will use the Lusha Contacts API to pull contacts to be enriched
from an input CSV file.

***You will require a Lusha API key, contact your admin if you do not see it in your dashboard***

***First Name, Last Name and Company URL/Domain columns MUST be created and filled.***

A sample CSV file has been uploaded to give an idea of structure (the last line of the file MUST be included):

```
"First Name,Last Name,Domain"
"Karen,Peacock,intercom.com"
"Yoni,Tserruya,lusha.com"
"BLANK FINAL LINE REQUIRED"
```

Simply download this script, run `chmod +x enrichmentprocesspublic.sh` on it and execute by
invoking it.

Download by right-click and saving as: 
https://raw.githubusercontent.com/robertliwpe/wpecontactenrichmentpub/main/enrichmentprocesspublicv2.sh
