The basic script calling works like this:
  * The node container starts up, and at the very end, it checks for the environment variable MAPR_SCRIPT_URL
  * If found, the URL is downloaded. It MUST be a ZIP file
  * The file is unzipped, the container changes to the script direct directory, and executes './mapr-job.sh'
  * In order to execute your script the MAPR_SCRIPT_URL must be set on your container in your deployment (See the "SE Demo Cluster - "Let's Build a Demo!" google doc)

## Demo Prep #

Put any additional prep instructions here for your demo.

### Demo Script ###

**Prep**

Put any recommendation here on how to run through the details demo walk through notes. Make sure you run through this script ahead of time to ensure everything works.

**Task 1**

Steps to do

**Task 2**

Steps to do

**Task 3**

Example of how to insert images in your .MD file (you need to upload any screenshots to your repo first)
Here is an example image:
![example_image.png](http://git.se.corp.maprtech.com/csmykay/basic-start-script/src/master/example_image.png)