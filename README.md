# FakeCron

## Extending cronjob starting from a single o few cronjobs

When cronjobs are limited on certain hosting, like adding only 5 cronjob commands thrhough a web panel, you probably have a pain in the neck; like us! :)
Anyway if you are in an unix environement and you can use your cronjobs to execute files in a directory you owns, than there are a number of workaround. This is an exemple, written in BASH. It is soooo simple, but here are the basics:

* go to your cronjob panel and set up a few of them like
    */15 * * * * /bin/bash /path/to/script/fakecron.sh -f fifteen
    0 0 * * * /bin/bash /path/to/script/fakecron.sh -f daily
    5 0 1 * * /bin/bash /path/to/script/fakecron.sh -f monthly

* put your scripts inside the right directory; the where is self explanatory due to dir names :). We have a daily example script *HelloWorld.sh* inside *./daily/*. The name of the script is not important at all, **but, please, put the .sh extension in fron of them!**

* while the *-f fifteen* cronjob is invoked, our script will search for *.sh in the *fifteen* dir, will execute them in order, will avoid to run them twice at the same time thanks to pidfile; pidfiles are removed when their script will be ended by a cathcable SIG*. If a pidfile remains orphan of its process, something went wrong, so we won't execute the script and we'll log the error in ./fakecron.log file.

At the moment errors are not mailed out.

####### keywords
*bash cron cronjob fake handler script manager cli linux cron.d*