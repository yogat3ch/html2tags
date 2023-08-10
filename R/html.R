#' Convert arbitrary HTML to htmltools tags
#'
#' @param html \code{chr} HTML or path to html file
#'
#' @return \code{shiny.tag.list}
#' @export
#' @importFrom htmltools tags
#' @examples
#' parse_html('<div id = "test"></div>')
parse_html <- function(html) {
  if (file.exists(html))
    html <- paste0(readLines(html), collapse = "\n")
  ctx <- V8::v8()
  ctx$source("https://raw.githubusercontent.com/stla/html2R/master/inst/www/himalaya.js")
  ctx$assign("html", html)
  ctx$eval("const json = himalaya.parse(html)")
  json <- ctx$get("json", simplifyVector = FALSE)
  out <- html2R:::parse_html(json)
  out <- paste("htmltools::tagList(\n\t", out,"\n)\n")
  cat(out)
  out <- rlang::parse_expr(out)
  out <- eval(out)
  return(out)
}

