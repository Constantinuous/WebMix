# WebMix

A project to test out some Web Deploy Features.

## Components

* AspMix: Our Web Site
* SubMix: A web application inside our site: WebMix/SubMix

## Files

* manifest.xml: This file tells the Web Deploy tool the different actions that are required to install the application. This includes things like copying files and setting up a database.
* parameters.xml: This is the "parameterization" file that Web Deploy uses to identify the parts of the application that need to be transformed at the time of installation based on user input.


## Links

* [An Introduction to Web Deploy Parameterization](https://www.iis.net/learn/publish/using-web-deploy/web-deploy-parameterization#CreateDBAndUser.sql)
* [Web Deploy Parameterization Scenarios](https://blogs.iis.net/elliotth/web-deploy-xml-file-parameterization)
* [Reference for the Web application package](https://www.iis.net/learn/develop/windows-web-application-gallery/reference-for-the-web-application-package)
* [Parameterization improvements in Web Deploy V3](https://www.iis.net/learn/publish/using-web-deploy/parameterization-improvements-in-web-deploy-v3)
* [Package an Application for the Windows Web Application Gallery](https://www.iis.net/learn/develop/windows-web-application-gallery/package-an-application-for-the-windows-web-application-gallery)
* [Web Deploy Command Line Reference](https://technet.microsoft.com/en-us/library/dd568991(v=ws.10).aspx)
* [Web Deploy Operation Settings](https://technet.microsoft.com/en-us/library/d860fa74-738a-4f09-87f6-66c6705145f9)
* [Web Deploy Parameterization in Action](http://vishaljoshi.blogspot.de/2010/07/web-deploy-parameterization-in-action.html)
* [HowTo:Create a Publish Profile/Parameters.xml](http://skysigal.com/it/ad/webdeploy/howto/create_a_publish_profile/parameters.xml)
* [Web Publish Samples](https://github.com/sayedihashimi/publish-samples)