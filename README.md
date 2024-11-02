# Portfolio Analysis using R

## Overview

This project demonstrates how to perform portfolio analysis using R, focusing on extracting stock price data from Yahoo Finance, cleaning and processing the data, calculating stock returns, and constructing an optimal portfolio. The analysis includes both individual loading and bulk loading of stock data, creating a portfolio of ten stocks, calculating portfolio returns, and plotting the efficient frontier to visualize different risk-return profiles.

## Objective

The objective of this project is to provide a comprehensive guide for performing portfolio analysis using R, focusing on the following key aspects:
- **Data Extraction and Processing**: Demonstrate how to extract and prepare stock price data for analysis.
- **Return and Risk Calculation**: Showcase methods for calculating stock returns and key risk metrics.
- **Portfolio Construction**: Construct and analyze both equally weighted and optimized portfolios to understand risk-return trade-offs.
- **Efficient Frontier Visualization**: Plot the efficient frontier to help investors visualize potential portfolios and make strategic investment decisions.
- **Optimization Techniques**: Identify and calculate optimal portfolio weights for the Tangency Portfolio (maximizing risk-adjusted return) and the Minimum Variance Portfolio (minimizing overall risk).
- **Empower Investors**: Equip financial analysts and investors with the tools to make data-driven portfolio management decisions.


## Libraries Used

The following R packages are used in this project:
- **fPortfolio**: For calculating efficient frontier and constructing portfolios.
- **timeSeries**: For handling time series data.
- **quantmod**: For importing stock data from Yahoo Finance.
- **dplyr**: For data manipulation.
- **ggplot2**: For data visualization.
- **zoo**: For working with time-indexed data.
- **PerformanceAnalytics**: For calculating portfolio returns and risk metrics.
- **tidyverse**: For data wrangling and visualization.

## Project Structure

### 1. Individual Loading of Securities

- **Stock Data Extraction**: Uses `getSymbols` to extract stock data for 10 stocks from Yahoo Finance from 2021-08-02 to 2024-07-30.
- **Data Cleaning**: Keeps only the adjusted price column and fills missing prices with the previous day's price.
- **Data Merging**: Merges the adjusted prices of 10 stocks into a single time series object.
- **Return Calculation**: Computes daily returns for each stock and removes any `NA` values.
- **Portfolio Return Calculation**: Calculates returns for an equally weighted portfolio of the 10 stocks.
- **Risk and Return Metrics**: Computes the mean return, variance-covariance matrix, and standard deviation of the portfolio.
- **Efficient Frontier Calculation**: Calculates the efficient frontier using a risk-free rate of 0.07 and plots it.

### 2. Bulk Loading of Securities

- **Bulk Data Extraction**: Uses a list of symbols to bulk load data for the same 10 stocks.
- **Data Conversion**: Converts the list of stock data into a data frame and retains adjusted prices.
- **Data Cleaning**: Converts the data frame into a time series and calculates daily returns.
- **Portfolio Return Calculation**: Computes returns for an equally weighted portfolio of the stocks.
- **Risk and Return Metrics**: Similar to individual loading, calculates mean return, variance-covariance matrix, and standard deviation.
- **Efficient Frontier Calculation**: Generates and plots the efficient frontier for the portfolio.

## Optimum Portfolio Weights and Minimum Variance Portfolio Weights

### Optimum Portfolio Weights (Tangency Portfolio)

The **Tangency Portfolio** aims to maximize the Sharpe ratio by combining the risk-free asset with a risky portfolio that has the highest risk-adjusted return. In this project, the tangency portfolio is calculated using the `fPortfolio` library. It involves setting a risk-free rate and solving for the portfolio weights that offer the highest ratio of excess return to risk.

### Minimum Variance Portfolio Weights

The **Minimum Variance Portfolio** is designed to achieve the lowest possible portfolio risk (variance) without considering returns. It minimizes the portfolio’s overall risk by optimizing the weights of the included assets while respecting the constraints of being fully invested (weights sum to 1) and long-only (no short selling). This portfolio is also calculated using the `fPortfolio` library.

## Key Analysis

### Portfolio Construction

- Both methods involve creating an equally weighted portfolio of 10 stocks.
- Returns are calculated using `Return.calculate` with discrete returns, and the portfolio returns are computed using `Return.portfolio`.

### Efficient Frontier

- The efficient frontier provides a visualization of the possible portfolios that minimize risk for a given level of return.
- The analysis uses `portfolioFrontier` from the `fPortfolio` package to derive and plot the efficient frontier.

## Results

- The analysis calculated the risk-return trade-offs for a portfolio composed of 10 selected stocks, enabling the creation of both equally weighted and optimized portfolios.
- The daily returns, portfolio returns, and key risk metrics such as mean return, standard deviation, and variance-covariance matrix were calculated.
- The **Efficient Frontier** was plotted, showing the potential portfolios that optimize the return for a given level of risk, allowing for informed decision-making.
- The **Tangency Portfolio** was identified, representing the portfolio with the highest Sharpe ratio, maximizing the risk-adjusted return.
- The **Minimum Variance Portfolio** was also calculated, providing the portfolio with the lowest possible risk for the given set of assets.

## Conclusion

- This project demonstrates the process of extracting, cleaning, and analyzing stock price data, as well as constructing optimized portfolios using R.
- The visualization of the efficient frontier is a valuable tool for understanding the balance between risk and return, enabling investors to make strategic portfolio decisions.
- The calculation of the tangency and minimum variance portfolios offers insights into achieving the best possible returns while managing risk.
- Overall, this analysis underscores the importance of proper data handling and portfolio optimization techniques in the field of finance.

