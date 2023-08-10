parse_html <- function(html) {
  ctx <- V8::v8()
  ctx$source("https://raw.githubusercontent.com/stla/html2R/master/inst/www/himalaya.js")
  ctx$assign("html", html)
  ctx$eval("const json = himalaya.parse(html)")
  json <- ctx$get("json", simplifyVector = FALSE)
  out <- html2R:::parse_html(json)
  cat(out)
  out <- rlang::parse_expr(out)
  out <- eval(out)
  return(out)
}

