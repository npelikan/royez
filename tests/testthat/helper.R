library(httptest)

## httptest sources
# httptest::capture_requests({
#     # multiple requests
#     httr::GET("https://api.oyez.org/cases/2014/13-1175")
#     httr::GET("https://api.oyez.org/cases/2014/13-1499")
#     # bad request
#     httr::GET("https://api.oyez.org/cases/2014/barf")
#     # per curiam decision
#     httr::GET("https://api.oyez.org/cases/2000/00-949")
#     # query
#     httr::GET("https://api.oyez.org/cases?per_page=0&filter=term:2014")
#     # transcript for 2014/13-1175
#     httr::GET("https://api.oyez.org/case_media/oral_argument_audio/23314")
#     # advocates for 2014/13-1175
#     httr::GET("https://api.oyez.org/people/e_joshua_rosenkranz/cases")
#     httr::GET("https://api.oyez.org/people/michael_r_dreeben/cases")
#     httr::GET("https://api.oyez.org/people/thomas_c_goldstein/cases")
# }, path = "tests/testthat")

