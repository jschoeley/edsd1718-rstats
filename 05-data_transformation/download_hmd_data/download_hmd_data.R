# Download HMD life-tables

# Init --------------------------------------------------------------------

library(tidyverse)
library(HMDHFDplus)

# HMD credentials
hmd_username <- "jona.s@gmx.de"
hmd_password <- "1457615511"

# Download HMD Period Lifetables ------------------------------------------

# codes of HMD countries
hmd_cntry <- getHMDcountries()
# remove countries we're not interested in
hmd_cntry <- hmd_cntry[!hmd_cntry %in% c('GBRTENW', 'GBRCENW', 'GBR_SCO',
                                         'GBR_NIR', 'DEUTE', 'DEUTW', 'FRACNP',
                                         'NZL_MA', 'NZL_MA', 'NZL_NM')]

# download female and male HMD lifetables and save in long format
hmd_lt <-
  data_frame(cntry = hmd_cntry) %>%
  # for each country...
  group_by(cntry) %>%
  do(
    {
      # ...download female lifetables
      female_lt <- readHMDweb(CNTRY = .$cntry,
                              username = hmd_username,
                              password = hmd_password,
                              item = "fltper_1x1")
      # ...download male lifetables
      male_lt <- readHMDweb(CNTRY = .$cntry,
                            username = hmd_username,
                            password = hmd_password,
                            item = "mltper_1x1")
      # ...combine female and male lifetables into long format data frame
      bind_rows(mutate(female_lt, sex = "female"),
                mutate(male_lt, sex = "male"))
    }
  )

save(hmd_lt, file = "./04-data_transformation/download_hmd_data/hmd_lt.RData")
