#' Create 2 colour gradient palette
#'
#' Creates a list of  colour names (RGB). Generates a palate using two colour gradients and an optional grey neutral colour.
#' Each half of the palette contains different shades of the colour submitted to the function. These are useful where two colour
#' scales in the same palette are needed, e.g. likert type plots. By default, the main colours are shades of blue and yellow
#' used in ONS outputs.
#'
#' @param n the number of colours needed
#' @param colour1 the first colour in the scale - a numeric vector representing red, green and blue (max 255)
#' @param colour2 the last colour in the scale - numeric vector representing red, green and blue (max 255).
#' @param mid the middle value of the scale. If neutral_mid = TRUE this value will be represented in grey. Otherwise, this will be
#' the endpoint of the first colour gradient (e.g. if n=6 and mid=3, there will be three shades of each colour)
#' @param neutral_mid whether the middle of the scale should be represented in grey (logical, TRUE by default)
#'
#' @return RGB colours
#'
#' @export


get_2colour_gradients <- function(n, colour1 = c(32, 96, 149), colour2 = c(226, 188, 34), mid, neutral_mid = TRUE) {
  
  if (!is.numeric(n) | length(n) > 1) {
    stop("n is not a numeric value")
  } else if (!n >= 2) {
    stop("Unexpected input - n should be >=2")
  }
  
  # Find scale midpoint if not specified
  if (missing(mid)) {
    mid <- ceiling((n + 1) / 2)
  } else if (mid > n-1 | mid == 1) {
    stop("Unexpected input: mid should not be greater than n-1 or smaller than 2")
  }
  
  if (class(colour1) != "numeric" | class(colour2) != "numeric") {
    stop("colours are not a vector of three integers")
  } else if (length(colour1) != 3 | length(colour2) != 3) {
    stop("colours must contain three values")
  } else if (!missing(mid) & class(mid) != "numeric") {
    stop("mid is not a numeric value")
  } else if (typeof(neutral_mid) != "logical") {
    stop("neutral_mid is not a logical value")
  } 
  
  # Set number of shades per colour
  if (n == 2){
    c1_shades <- 1
    c2_shades <- 1
    neutral_mid <- FALSE
  } else {
    c1_shades <- ifelse(neutral_mid, mid - 1, mid)
    c2_shades <- floor(n - mid)
  }
  
  c1_gradient <- get_gradient(c1_shades, colour = colour1)
  c2_gradient <- rev(get_gradient(c2_shades, colour = colour2))
  
  # Calculate brightness for neutral middle
  if (neutral_mid) {
    c1_last <- utils::tail(c1_gradient, n = 1)
    c1_brightness <- (max(c1_last[[1]]) + min (c1_last[[1]])) / 2
    
    c2_first <- c2_gradient[1]
    c2_brightness <- (max(c2_first[[1]]) + min (c2_first[[1]])) / 2
    
    # Ensure sufficient contrast between the neutral colour and colours 1 and 2
    if (abs(c1_brightness - c2_brightness) >= 60) {
      mid_brightness <- mean(c(c1_brightness, c2_brightness))
    } else {
      mid_brightness <- 200
    }
    
    mid_colour <- c(mid_brightness, mid_brightness, mid_brightness)
    colours <- c(c1_gradient, list(mid_colour), c2_gradient)
  } else {
    colours <- c(c1_gradient, c2_gradient)
  }
  return(colours)
  
}
