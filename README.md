The basic script calling works like this:
  * The node container starts up, and at the very end, it checks for the environment variable MAPR_SCRIPT_URL
  * If found, the URL is downloaded. It MUST be a ZIP file
  * The file is unzipped, the container changes to the script direct directory, and executes './mapr-job.sh'


