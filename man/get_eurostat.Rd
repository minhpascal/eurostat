% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_eurostat.R
\name{get_eurostat}
\alias{get_eurostat}
\title{Generic wrapper to read data from Eurostat}
\usage{
get_eurostat(id, time_format = "date", filters = "none", type = "code",
  select_time = NULL, cache = TRUE, update_cache = FALSE,
  cache_dir = NULL, compress_file = TRUE,
  stringsAsFactors = default.stringsAsFactors(), keepFlags = FALSE, ...)
}
\arguments{
\item{id}{A code name for the dataset of interest.
See \code{\link{search_eurostat}} or details for how to get code.}

\item{time_format}{a string giving a type of the conversion of the time
column from the eurostat format. A "date" (default) convers to
a \code{\link{Date}} with a first date of the period.
A "date_last" convers to a \code{\link{Date}} with
 a last date of the period. A "num" convers to a numeric and "raw"
 does not do conversion. See \code{\link{eurotime2date}} and
 \code{\link{eurotime2num}}.}

\item{filters}{a "none" (default) to get a whole dataset or a named list of 
filters to get just part of the table. Names of list objects are 
Eurostat variable codes and values are vectors of observation codes. 
If \code{NULL} the whole 
dataset is returned via API. More on details. See more on filters and 
limitations per query via API from for 
\code{\link{get_eurostat_json}}.}

\item{type}{A type of variables, "code" (default) or "label".}

\item{select_time}{a character symbol for a time frequence or NULL,
which is used by default as most datasets have just one time
frequency. For datasets with multiple time
frequencies, select the desired time format with:
  Y = annual, S = semi-annual, Q = quarterly, M = monthly.
For all frequencies in same data.frame \code{time_format = "raw"}
should be used.}

\item{cache}{a logical whether to do caching. Default is \code{TRUE}. Affects 
only queries from the bulk download facility.}

\item{update_cache}{a locigal whether to update cache. Can be set also with
options(eurostat_update = TRUE)}

\item{cache_dir}{a path to a cache directory. The directory have to exist.
The \code{NULL} (default) uses and creates
'eurostat' directory in the temporary directory from
\code{\link{tempdir}}. Directory can also be set with
\code{option} eurostat_cache_dir.}

\item{compress_file}{a logical whether to compress the
RDS-file in caching. Default is \code{TRUE}.}

\item{stringsAsFactors}{if \code{TRUE} (the default) variables are
converted to factors in original Eurostat order. If \code{FALSE}
they are returned as a character.}

\item{keepFlags}{a logical whether the flags (e.g. "confidential",
"provisional") should be kept in a separate column or if they
can be removed. Default is \code{FALSE}.}

\item{...}{further argument for \code{\link{get_eurostat_json}}.}
}
\value{
a data.frame. One column for each dimension in the data and
        the values column for numerical values.
        The time column for a time dimension. Data from bulk download 
        facility do not include items whose all values are missing.
}
\description{
Download dataset from the Eurostat database
(\url{ec.europa.eu/eurostat}).
}
\details{
Datasets are downloaded from 
\href{http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing}{the Eurostat bulk download facility} or from The Eurostat Web Services 
\href{http://ec.europa.eu/eurostat/web/json-and-unicode-web-services}{JSON API}.
If only the table \code{id} is given, the whole table is downloaded from the
bulk download facility. If also \code{filters} are defined the JSON API is
used.

The bulk download facility is the fastest method to download whole datasets.
It is also often the only way as the JSON API has limitation of maximum 
50 sub-indicators at time and whole datasets usually exceeds that. Also, 
it seems that multi frequency datasets can only be retrived via 
bulk download facility and the \code{select_time} is not available for 
JSON API method.

By default datasets from the bulk download facility are cached as they are
often rather large. Caching is not (currently) possible for datasets from 
JSON API.
Cache files are stored in a temporary directory by default or in
a named directory if cache_dir or option eurostat_cache_dir is defined.
The cache can be emptied with \code{\link{clean_eurostat_cache}}.

The \code{id}, a code, for the dataset can be searched with
the \code{\link{search_eurostat}} or from the Eurostat database
\url{http://ec.europa.eu/eurostat/data/database}. The Eurostat
database gives codes in the Data Navigation Tree after every dataset
in parenthesis.
}
\examples{
\dontrun{
k <- get_eurostat("nama_10_lp_ulc")
k <- get_eurostat("nama_10_lp_ulc", time_format = "num")
k <- get_eurostat("nama_10_lp_ulc", update_cache = TRUE)
dir.create(file.path(tempdir(), "r_cache"))
k <- get_eurostat("nama_10_lp_ulc", 
                  cache_dir = file.path(tempdir(), "r_cache"))
options(eurostat_update = TRUE)
k <- get_eurostat("nama_10_lp_ulc")
options(eurostat_update = FALSE)
options(eurostat_cache_dir = "r_cache")
k <- get_eurostat("nama_10_lp_ulc")
k <- get_eurostat("nama_10_lp_ulc", cache = FALSE)
k <- get_eurostat("avia_gonc", select_time = "Y", cache = FALSE)

dd <- get_eurostat("namq_aux_lp", 
                     filters = list(geo = "FI", 
                                    indic_na = "RLPH", 
                                    unit = "EUR_HRS",
                                    s_adj = "NSA"))
}
}
\seealso{
\code{\link{search_eurostat}}, \code{\link{label_eurostat}}
}

