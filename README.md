# lighthouseR
[![Build Status](https://travis-ci.org/dschmeh/lighthouseR.svg?branch=master)](https://travis-ci.org/dschmeh/lighthouseR)

A simple Package to start and retrieve Data from Lighthouse in R
You can find out more about Lighthouse here:https://developers.google.com/web/tools/lighthouse/

lighthouseR requires Node 6 or later.

# Installation 
To get the current development version from github:

```
# install.packages("devtools")
devtools::install_github("dschmeh/lighthouseR")
```

# Installing Lighthouse on a local machine
Install Lighthouse on your machine
```
lighthouse_install()
```

# Starting Lighthouse and retriving data of a specific page
Getting data for a specific URL. The Function will start a Lighthouse-Test for the given URL. This can take up to a minute. If View is TRUE the full report will automaticly open in the Browser. Default for this is FALSE.
```
page<-"https://www.r-project.org/"
lighthouse(page, view = FALSE))
```
