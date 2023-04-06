# Lusha Contact Enrichment Script
This requires node.js (minimum version 10) to be installed locally

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash`

As well as Homebrew

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

If you do not already have it installed copy and run the above command.

This script will use the Lusha Contacts API to pull contacts to be enriched
from an input CSV file.

***First Name, Last Name and Company columns MUST be created and filled.***

A sample CSV file has been uploaded to give an idea of structure (the last line of the file MUST be included):

```
"First Name,Last Name,Domain"
"Karen,Peacock,intercom.com"
"Yoni,Tserruya,lusha.com"
"BLANK FINAL LINE REQUIRED"
```

Simply download this script, run `chmod +x enrichmentprocessv3.sh` on it and execute by
invoking it.

Clone as: 
`git clone https://github.com/robertliwpe/wpecontactenrich.git`
