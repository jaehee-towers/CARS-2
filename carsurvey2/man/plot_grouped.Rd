% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_grouped.R
\name{plot_grouped}
\alias{plot_grouped}
\title{Plot grouped frequency graph}
\usage{
plot_grouped(table, xlab, ylab, font_size = 12, orientation = "v")
}
\arguments{
\item{table}{Frequency table (data frame). 3 columns - cateogry names, groups and frequencies.}

\item{xlab}{X axis title}

\item{ylab}{Y axis title}

\item{font_size}{minimum font size for the plot (numeric).}

\item{orientation}{plot orientation ("h" = horizontal, "v" = verical). Vertical by default.}
}
\value{
bar chart
}
\description{
Produce bar chart (plotly) for frequency data with grouping variable.
}
