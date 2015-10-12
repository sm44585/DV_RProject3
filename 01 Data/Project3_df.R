require("jsonlite")
require("RCurl")

# Loads the data from Fast Food table into Fast Food dataframe
# Change the USER and PASS below to be your UTEid
fast_food <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from FASTFOODMAPS_LOCATIONS_2007"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_sm44585', PASS='orcl_sm44585', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

# Loads median, mean, and population data into Zip Code dataframe

zip_code <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from MedianZIP32"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_sm44585', PASS='orcl_sm44585', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
