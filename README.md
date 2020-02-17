# osmandbuilddocker
Docker image for build Osmand (https://github.com/osmandapp/Osmand)

Install Docker daemon on your system
Clone this repository
Exec command: docker build -t osmandbuild/dev /path/to/FOLDER/with/dockerfile
Need RAM 4Gb and 19Gb HDD 
It will be creating image and run first build for Nightly version (last RIN command in Dockerfile, you can comment out a line with #)

Result .apk file will be moved in /osmand/output folder in IMAGE
