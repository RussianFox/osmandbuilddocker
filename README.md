# osmandbuilddocker
Docker image for build Osmand (https://github.com/osmandapp/Osmand)

Install Docker daemon on your system

Clone this repository

Exec command: `docker build -t russianfox/osmandbuild /path/to/FOLDER/with/dockerfile`

Need RAM 4Gb and 19Gb HDD

It will be creating image and run first build for Nightly version (last RUN command in Dockerfile, take too long time, you can comment out a line with #)

Result .apk file will be moved in /osmand/output folder in IMAGE

For run container use:

`docker run --name osmand_build -v /your/folder/for/apk/in/system/:/osmand/output/ -dit russianfox/osmandbuild`

For attach to container (for detach: Ctrl+P Ctrl+Q, for quit and close: Ctrl+D):

`docker attach osmand_build`

Commands in container. For update repositories: 

`update_repos`

For build:

`build_nightly`

Files .apk will be moved with replace in /your/folder/for/apk/in/system/