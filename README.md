# lighthouseR
A simple Package to start and retrive Data from Lighthouse in R
You can find out more about Lighthouse here:https://developers.google.com/web/tools/lighthouse/

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
Getting data for a specific URL
```
page<-"https://www.r-project.org/"
lighthouse(page)
```
