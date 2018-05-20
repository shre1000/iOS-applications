This app loads top 25 movies from iTunes. This app uses networking. 

Application was downloading images from mzstatic site. One can't download from the mzstatic site because you are downloading unsecure via http not via https. So images were not loading in image view. 
Normally, switch http to https would solve this; however, the mzstatic site does not have a valid SSL certificate for secure downloads.  Therefore, I had to either turn off ATS or white list the mzstatic website. I did whitelist the site.
To whitelist it, I added additional key info in .plist file. 
