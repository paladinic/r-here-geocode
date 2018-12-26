# HERE GEOCODE API HANDLER

# The following code simplifies the use of the HERE (https://developer.here.com/).
# HERE provides a set of GIS functionalities such as routing and geocoding, but for now only geocoding is included in this code.
# HERE provides 250K free transactions per month.


# Libraries
if(!require(httr)){
  cat("Intalling dependency 'httr'")
  install.packages("httr")
}

# API Identification
# id = "<YOUR HERE APP ID>"
# code = "<YOUR HERE APP CODE>"

# funciton
here_geocode = function(id,code,location){
  request = paste0("https://geocoder.api.here.com/6.2/geocode.json?app_id=",
                   id,
                   "&app_code=",
                   code,
                   "&searchtext=",gsub(pattern = " ","+",location))
  
  content = content(GET(request))
  coords = tryCatch(content$Response$View[[1]]$Result[[1]]$Location$NavigationPosition[[1]],error = function(e) NULL)
  if(is.null(coords)){
    cat("Could not geocode the input address.\nYou should check...
        \n ...if the input is a string\n ...if the input is an address, city or country (i.e. it can, but it does not have to be granular)\n ...if your HERE api credentials are correct\n ...if your transaction limits have not been surpassed")
  }
  if(!is.null(coords)){
    return(cbind(lat = coords$Latitude, lon = coords$Longitude))
  }
}