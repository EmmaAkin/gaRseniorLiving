Call the Google Analytics library
library(RGoogleAnalytics)
library(xlsx)

require(RGoogleAnalytics)

#Load the save token file from t
load("./token_file")

#Validate the Token
ValidateToken(token)
query.init <- Init(start.date = "2013-01-01",
                   end.date = "2017-09-09",
                   dimensions = c("ga:source",
                                  "ga:fullReferrer",
                                  "ga:medium",
                                  "ga:date",
                                  "ga:pagePath",
                                  "ga:deviceCategory"),
                   metrics = c("ga:sessions",
                               "ga:bounces",
                               "ga:pageviews",
                               "ga:uniquePageviews",
                               "ga:newUsers",
                               "ga:timeOnPage",
                               "ga:exits",
                               "ga:pageLoadTime"),
                   
                   max.results = 10000,
                   sort = "-ga:date",
                   table.id = "ga:55284715")

query <- QueryBuilder(query.init)

seniorLivingdata <- GetReportData(query, token, paginate_query = TRUE)

View(seniorLivingdata)



#fileXls <- paste(Sport_data,"newFile.xlsx",sep='/')
#unlink(fileXls, recursive = FALSE, force = FALSE)
#exc <- loadWorkbook(fileXls,createWorkbook())
#createSheet(exc,'Input')
#saveWorkbook(exc)

#write.xlsx(seniorLiving, "c:seniorLiving.xlsx")




ggplot(seniorLivingdata,aes(x=date,y=pageviews,group=1)) +
  geom_line() +
  geom_smooth() +
  theme(axis.text.x = element_text(angle = 90, hjust = ),
        panel.background = element_blank())
