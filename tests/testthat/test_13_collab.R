context("Managing collaborations")

test_that("creating a collaboration works", {
  
  skip_if_no_token()
  
  writeLines("collab test file", file.path("test_dir", "collab.txt"))
 
  # upload them
  file <- box_ul(0, "test_dir/collab.txt")
  folder <- box_dir_create("collab")
  
  # create collabs with the boxr tester account
  boxr_tester_acct <- 9459307839
  collab_file <- box_create_collab_file(file$id, boxr_tester_acct)
  collab_folder <- box_create_collab_dir(folder$id, boxr_tester_acct)
  
  test_that("Collaborations are created", {
    some_bigish_int <- 1e10 # Box IDs are (so far) always integers
    expect_gt(as.numeric(collab_file$id), some_bigish_int)
    expect_gt(as.numeric(collab_folder$id), some_bigish_int)
  })
  
  test_that("Collaborations can be detected", {
    
    expect_message(
      folder_collab <- box_get_collab_dir(folder$id),
      "1 collaborator"
    )
    expect_message(
      file_collab <- box_get_collab_file(file$id),
      "1 collaborator"
    )
  })
  
  box_delete_collab(collab_file$id)
  box_delete_collab(collab_folder$id)
  
  test_that("Collaborations can be deleted", {
    
    expect_error(box_get_collab_file(file$id), NULL)
    expect_error(box_get_collab_dir(folder$id), NULL)
    
  })
})