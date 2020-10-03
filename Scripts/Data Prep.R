###### Data prep ####
# Pull data from database, do some minor data clean up and calculations, export to csv for visualization. 

library(dplyr)
library(RPostgreSQL)
library(rpostgis)
library(sf)
library(data.table)
library(ggplot2)
library(tidyr)
library(highcharter)
library(here)
options(scipen = 999)

#loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")


# create connection
con <- dbConnect("database connection information here")

conRDA <- dbConnect("database connection information here")


###### State level #####

# load data for test
state_list <- list(
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_education_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp  
          from all_county_area_education_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_fire_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp  
          from all_county_area_fire_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_parks_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_parks_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_hospital_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_hospital_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_transit_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_transit_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_housing_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_housing_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_libraries_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_libraries_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_natres_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_natres_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_health_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_health_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_watertrans_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_watertrans_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_protinsp_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_protinsp_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_corrections_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_corrections_pct_gdp_2007_2012 where state_abbr = 'CA'"),
  
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_police_pct_gdp_1972_2002 where state_abbr = 'CA'"),
  st_read(con, query = "select year4, expenditures, state_abbr, inflation_adjusted_exp, ia_gdp, pct_gdp 
          from all_county_area_police_pct_gdp_2007_2012 where state_abbr = 'CA'"))


head(state_list[[26]])


# collapse list to regular df
state_df <- do.call("rbind", state_list)

state_df$year <- as.numeric(state_df$year4)


## Create police+corrections (combine expenditures)
state_df <- 
  bind_rows(
    state_df, 
(state_df %>% 
  filter(expenditures %in% c("Police", "Corrections")) %>% 
  group_by(year4, year, state_abbr) %>% 
  summarize(inflation_adjusted_exp = sum(inflation_adjusted_exp),
            ia_gdp = min(ia_gdp),
            pct_gdp = (inflation_adjusted_exp/ia_gdp)*100) %>% 
  mutate(expenditures = "Police + Corrections")))

table(state_dffin$expenditures)

# export data for state, all years/expenditures
write.csv(state_df, "Data/State_Expenditures_1972_2012.csv", row.names = FALSE)


###### County level data #####
counties_list <- list(
st_read(con, query = "select * from alameda_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from alameda_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from contra_costa_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from contra_costa_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from kern_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from kern_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from los_angeles_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from los_angeles_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from orange_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from orange_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from san_bernardino_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from san_bernardino_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from san_diego_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from san_diego_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from santa_clara_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from santa_clara_county_area_pct_gdp_2007_2012"),
st_read(con, query = "select * from ventura_county_area_pct_gdp_1972_2002"),
st_read(con, query = "select * from ventura_county_area_pct_gdp_2007_2012"))


# make a numeric year col for all counties
counties_list <- lapply(counties_list, function(x) within(x, year <- as.numeric(x$year4)))

# collapse list to regular df
counties_df <- do.call("rbind", counties_list)

# export data for all counties, all years/expenditures
write.csv(counties_df, "Data/Counties_Expenditures_1972_2012.csv", row.names = FALSE)




