## ASSEMBLE DATA IN DATA FRAMES
## PLACE AFTER EACH DISTRIBUTION CHUNK
## SHOULD BE FUNCTION  
## convert to data frame
df.dist <- data.frame(distribution=dname,
                      values=dist)

## if ditrib is already in df.dist.all and df.dist.all.cols need to remove
df.dist.all <- df.dist.all %>% filter(distribution!=dname)
## need to test if column name exists
if(any(grepl(dname, colnames(df.dist.all.cols)))){
  df.dist.all.cols <- df.dist.all.cols %>% select(-dname)
}

## add to existing distribution data
df.dist.all <- bind_rows(df.dist.all, df.dist)
## create columnar data with distribution name
df.dist.col <- df.dist %>% select(values) %>% rename(
  !!dname:=values
)
## add to existing columnar data -> must be same length as other data
if(nrow(df.dist.col)<nn){
  strtrow<- nrow(df.dist.col)+1
  df.dist.col[strtrow:nn,1] <- NA
} else if(nrow(df.dist.col)>nn){
  df.dist.col <- df.dist.col[1:nn,1]
}
df.dist.all.cols <- bind_cols(df.dist.all.cols, df.dist.col)