#' returns a list with metadata and coordinates for a given type of input
#' (geocoding addresses and objects)
#'
#' @param address place with or without street and house number
#' @param road road number with or without mileage
#' @param rail_crossing rail crossing identifier 
#' (11 characters including 2 spaces, format: "XXX XXX XXX")
#' @param geoname name of the geographical object from State Register 
#' of Geographical Names (function geonames_download)
#'
#' @return a list(s) with metadata and coordinates (EPSG: 2180)
#' 
#' @export
#'
#' @examples
#' geocode(address = "Marki") # place
#' geocode(address = "Marki, Andersa") # place and street
#' geocode(address = "Marki, Andersa 1") # place, street and house number
#' geocode(address = "Królewskie Brzeziny 13") # place and house number
#' 
#' geocode(road = "632") # road number
#' geocode(road = "632 55") # road number and mileage
#' 
#' geocode(rail_crossing = "001 018 478")
#' 
#' geocode(geoname = "Las Mierzei") # physiographic object
geocode = function(address = NULL, road = NULL, rail_crossing = NULL, geoname = NULL) {
  
  # geocode address
  if (!is.null(address)) {
    
    base_URL = "https://services.gugik.gov.pl/uug/?request=GetAddress&address="
    prepared_URL = paste0(base_URL, address)
    prepared_URL = gsub(" ", "%20", prepared_URL)
    output = jsonlite::fromJSON(prepared_URL)[["results"]]
    
    if (length(output) == 1) {
      output = output[[1]]
    }
    
  # geocode road
  } else if (!is.null(road)) {
    
    base_URL = "https://services.gugik.gov.pl/uug?request=GetRoadMarker&location="
    prepared_URL = utils::URLencode(paste0(base_URL, road))
    output = jsonlite::fromJSON(prepared_URL)[["results"]]
    
    # remove unnecessary attributes
    sel = c("road", "marker", "number", "x", "y")
    output = output[[1]][sel]
  
  # geocode rail crossing  
  } else if (!is.null(rail_crossing)) {
    
    if (!nchar(rail_crossing) == 11) {
      stop("rail crossing ID must be 11 characters long")
    } else {
      
      base_URL = "https://services.gugik.gov.pl/uug/?request=GetLevelCrossing&location="
      prepared_URL = utils::URLencode(paste0(base_URL, rail_crossing))
      output = jsonlite::fromJSON(prepared_URL)[["results"]]
      
      # remove unnecessary attributes
      sel = c("operator", "category", "phone", "mobile phone", "x", "y")
      output = output[[1]][sel]
      
      }
    
  # geocode geographical name
  } else if (!is.null(geoname)) {
    
    base_URL = "https://services.gugik.gov.pl/uug/?request=GetLocation&location="
    prepared_URL = paste0(base_URL, geoname)
    prepared_URL = gsub(" ", "%20", prepared_URL)
    output = jsonlite::fromJSON(prepared_URL)[["results"]]
    
    if (length(output) == 1) {
      output = output[[1]]
    }
    
  } else {
    stop("all inputs ale empty")
  }
  
  return(output)
  
}
