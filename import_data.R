library(foreign)

#Both files are EU28 only and one year
EQLS_raw <- read.spss("data/EQLS UKDS EU28 2016.sav", to.data.frame=T)
EWCS_raw <- read.spss("data/Step 2 - after_recodes_incl_JQI_EU28_2015_2703.sav", to.data.frame=T)

save(EQLS_raw,file="EQLS_raw.Rda")
save(EWCS_raw,file="EWCS_raw.Rda")