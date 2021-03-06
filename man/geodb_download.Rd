% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geodb_download.R
\name{geodb_download}
\alias{geodb_download}
\title{downloads General Geographic Databases for entire voivodeships}
\usage{
geodb_download(voivodeships, ...)
}
\arguments{
\item{voivodeships}{selected voivodeships in Polish or English, or TERC
(function 'voivodeship_names' can by helpful)}

\item{...}{additional argument for \code{\link[utils:download.file]{utils::download.file()}}}
}
\value{
a database in Geography Markup Language format (.GML),
the content and detail level corresponds to the general
geographic map in the scale of 1:250000
}
\description{
downloads General Geographic Databases for entire voivodeships
}
\examples{
\donttest{
geodb_download(c("mazowieckie", "wielkopolskie"))
geodb_download(c("Subcarpathian", "Silesian"))
geodb_download(c("02", "16"))
}
}
\references{
description of topographical and general geographical databases,
and technical standards for making maps
http://www.gugik.gov.pl/__data/assets/pdf_file/0005/208661/rozp_BDOT10k_BDOO.pdf
}
