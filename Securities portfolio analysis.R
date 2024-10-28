library(fPortfolio)
library(timeSeries)
library(quantmod)
library(dplyr)
library(ggplot2)
library(zoo)
library(PerformanceAnalytics)
library(tidyverse)

## INDIVIDUAL LOADING OF SECURITIES


# getting stock price data from yahoo finance portal
itc <- getSymbols("ITC.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
jswsteel <- getSymbols("JSWSTEEL.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
hindalco <- getSymbols("HINDALCO.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
kotakbank <- getSymbols("KOTAKBANK.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
lt <- getSymbols("LT.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
tatasteel <- getSymbols("TATASTEEL.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
reliance <- getSymbols("RELIANCE.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
bpcl <- getSymbols("BPCL.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
shriramfin <- getSymbols("SHRIRAMFIN.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)
bajajauto <- getSymbols("BAJAJ-AUTO.NS",from="2021-08-02",to="2024-07-30",auto.assign=FALSE)

# keeping only Adjusted price column in each of securities 
itc <- Ad(itc)
jswsteel <- Ad(jswsteel)
hindalco <- Ad(hindalco)
kotakbank <- Ad(kotakbank)
lt <- Ad(lt)
tatasteel <- Ad(tatasteel)
reliance <- Ad (reliance)
bpcl <- Ad(bpcl)
shriramfin <- Ad(shriramfin)
bajajauto <- Ad(bajajauto)

# now there is a possibility of prices being blank for some days. so filling those blanks with previous day's price
itc <- na.locf(itc)
jswsteel <- na.locf(jswsteel)
hindalco <- na.locf(hindalco)
kotakbank <- na.locf(kotakbank)
lt <- na.locf(lt)
tatasteel <- na.locf(tatasteel)
reliance <- na.locf (reliance)
bpcl <- na.locf(bpcl)
shriramfin <- na.locf(shriramfin)
bajajauto <- na.locf(bajajauto)

# now merging these 10 securities price 
ten_stocks <- merge.xts(itc,jswsteel,hindalco,kotakbank,lt,tatasteel,reliance,bpcl,shriramfin,bajajauto)
class(ten_stocks)
head(ten_stocks)

# now calculating return of ten_stocks
ten_stocks_return <- Return.calculate(ten_stocks,method='discrete')
head(ten_stocks_return)
class(ten_stocks_return)

# Clearing NA from ten_stocks_return
ten_stocks_return <- na.omit(ten_stocks_return)

# Now calculating return of portfolio
ten_stocks_pfreturn <- Return.portfolio(ten_stocks_return,weights=c(0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1),geometric=FALSE)
ten_stocks_pfreturn
mean(ten_stocks_pfreturn)
var_cov <- cov(ten_stocks_return)
sd(ten_stocks_pfreturn)

# now calculating efficient frontier
ten_stocks_return<- as.timeSeries(ten_stocks_return)
class(ten_stocks_return)
efficient_frontier <- portfolioFrontier(ten_stocks_return,`setRiskFreeRate<-`(portfolioSpec(),0.07/252),constraints="longonly")

# now plotting efficient frontier
plot(efficient_frontier,c(1,2,3,4))

# Specifying portfolio specifications for optimization
spec <- portfolioSpec()
setRiskFreeRate(spec) <- 0.07 / 252  # Risk-free rate annualized to daily

# Optimizing for the tangency portfolio (maximizing the Sharpe ratio)
tangency_portfolio <- tangencyPortfolio(data = ten_stocks_return, spec = spec, constraints = "longonly")

# Display the portfolio weights
optimum_weights <- getWeights(tangency_portfolio)
print("Optimum Portfolio Weights (Tangency Portfolio):")
print(optimum_weights)


# Optimizing for the minimum variance portfolio
min_variance_portfolio <- minvariancePortfolio(data = ten_stocks_return, spec = spec, constraints = "longonly")

# Display the portfolio weights
min_variance_weights <- getWeights(min_variance_portfolio)
print("Minimum Variance Portfolio Weights:")
print(min_variance_weights)



## BULK LOADING OF SECURITIES



symbols =c("ITC.NS","JSWSTEEL.NS","HINDALCO.NS","KOTAKBANK.NS","LT.NS","TATASTEEL.NS","RELIANCE.NS","BPCL.NS","SHRIRAMFIN.NS","BAJAJ-AUTO.NS")
symbols
portfolio_stocks <- lapply (symbols,function(x){getSymbols(x,from="2021-08-02",to="2024-07-30",auto.assign=FALSE)})
head(portfolio_stocks)
class (portfolio_stocks)

# the above codes extracted data from yahoo finance in the list format
# converting list to dataframe
portfolio_stocks_df <- as.data.frame(portfolio_stocks)
class(portfolio_stocks_df)
portfolio_stocks_df <- Ad(portfolio_stocks_df)
portfolio_stocks_df

# for further analysis we'll convert this dataframe to timeseries
portfolio_stocks_ts <- as.timeSeries(portfolio_stocks_df)

# calculating returns of individual securities
portfolio_stocks_return <- Return.calculate(portfolio_stocks_ts)
head(portfolio_stocks_return)

# removing NA values 
portfolio_stocks_return <- na.omit(portfolio_stocks_return)
head(portfolio_stocks_return)

# calculating portfolio returns of 10 securities
portfolio_stocks_pfreturn <- Return.portfolio(portfolio_stocks_return,c(0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1),geometric=FALSE)
head(portfolio_stocks_pfreturn)

mean(portfolio_stocks_pfreturn)
var_cov <-cov(portfolio_stocks_return)
sd(portfolio_stocks_pfreturn)

# calculaing efficient frontier
efficient_frontier <- portfolioFrontier(portfolio_stocks_return,`setRiskFreeRate<-`(portfolioSpec(),0.07/252),constraints="longonly")
efficient_frontier

# plotting efficient frontier
plot(efficient_frontier,c(1,2,3,4)) 

# Specifying portfolio specifications for optimization
spec <- portfolioSpec()
setRiskFreeRate(spec) <- 0.07 / 252  # Risk-free rate annualized to daily

# Optimizing for the tangency portfolio (maximizing the Sharpe ratio)
tangency_portfolio <- tangencyPortfolio(data = ten_stocks_return, spec = spec, constraints = "longonly")

# Display the portfolio weights
optimum_weights <- getWeights(tangency_portfolio)
print("Optimum Portfolio Weights (Tangency Portfolio):")
print(optimum_weights)


# Optimizing for the minimum variance portfolio
min_variance_portfolio <- minvariancePortfolio(data = ten_stocks_return, spec = spec, constraints = "longonly")

# Display the portfolio weights
min_variance_weights <- getWeights(min_variance_portfolio)
print("Minimum Variance Portfolio Weights:")
print(min_variance_weights)


