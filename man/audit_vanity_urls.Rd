% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/audits.R
\name{audit_vanity_urls}
\alias{audit_vanity_urls}
\title{Audit Vanity URLs}
\usage{
audit_vanity_urls(apps, server_url, vanity = NULL)
}
\arguments{
\item{apps}{App list, see \code{\link[=cache_apps]{cache_apps()}}}

\item{server_url}{Base url for the Connect server}

\item{vanity}{Optional, see details}
}
\description{
Audit Vanity URLs
}
\details{
If \code{vanity} is not provided, returns a list of all the vanity
urls in use. If \code{vanity} is provided, returns whether or not
\code{vanity} is eligible as a vanity url.
}
\seealso{
Other audit functions: 
\code{\link{audit_access_open}()},
\code{\link{audit_r_versions}()},
\code{\link{audit_runas}()},
\code{\link{cache_apps}()}
}
\concept{audit functions}
