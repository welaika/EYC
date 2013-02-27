# EYC

## Extending cronjob starting from a single or few cronjobs

EYC is an acronym which stands for Enlarge Your Cron. It is a script manager that extends your cronjobs: you invoke a single script and it wraps and launch all the scripts you want.

___

It works like this:

    *|**A cronjob is called e.g. every 15 min
     |
     |___eyc.sh -f fifteen <-- wrapper is called to look for "15mins" scripts
        |
        |__fifteen/ <-- it looks in the right dir
          |__scriptA.sh <--\ 
          |__scriptB.sh <-- - all the script inside are executed
          |__scriptC.sh <--/

When cronjobs are limited on certain hosting, like adding only 5 cronjob commands thrhough a web panel, you probably have a pain in the neck; like us! :)
Anyway if you are in an unix environement and you can use your cronjobs to execute files in a directory you owns, than there are a number of workaround. This is an exemple, written in BASH. It is soooo simple, but here are the basics:

* go to your cronjob panel and set up a few of them like

    ```bash
    */15 * * * * /bin/bash /path/to/script/eyc.sh -f fifteen
    0 0 * * * /bin/bash /path/to/script/eyc.sh -f daily
    5 0 1 * * /bin/bash /path/to/script/eyc.sh -f monthly
    ```

* put your scripts inside the right directory; the where is self explanatory due to dir names :). We have a daily example script *HelloWorld.sh* inside *./daily/*. The name of the script is not important at all, **but, please, put the .sh extension in fron of them!**

* while the *-f fifteen* cronjob is invoked, our script will search for *.sh in the *fifteen* dir, will execute them in order, will avoid to run them twice at the same time thanks to pidfile; pidfiles are removed when their script will be ended by a cathcable SIG*. If a pidfile remains orphan of its process, something went wrong, so we won't execute the script and we'll log the error in ./eyc.log file.

At the moment errors are not mailed out.



####### keywords
*bash cron cronjob fake handler script manager cli linux cron.d*