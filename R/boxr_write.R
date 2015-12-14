#' Write R Objects to Files Remotely Hosted on box.com
#' 
#' @description {
#    A fast and lazy way to upload R objects to box.com in a commonly readable
#'   file format. \code{read_fun} is used to convert R objects to files, which
#'   by default is the \code{\link{export}} function from the \code{rio} 
#'   package.
#'   
#'   Note: \code{box_write} is for writing files in standard formats to box.com.
#'   To upload R objects as \code{.RData} files, see \code{\link{box_save}}.
#'}
#'
#' @inheritParams box_ul
#' @param x An R object
#' @param filename The name for the file to be uploaded
#' @param write_fun The function used to write the R object to a file
#' @param ... Additional arguments passed to \code{read_fun}
#'   
#' @return A refernce to to the file uploaded
#' @export
box_write <- function(x, filename, dir_id = box_getwd(), 
                      write_fun = rio::export, ...) {
  temp_file <- paste0(tempdir(), "/", filename)
  write_fun(x, temp_file)
  box_ul(dir_id = dir_id, file = temp_file)
}