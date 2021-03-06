FROM debian:stretch-slim
ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-c"]

RUN echo '' > /etc/apt/sources.list
RUN echo 'deb http://deb.debian.org/debian stretch main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb http://deb.debian.org/debian stretch-updates main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb http://security.debian.org/debian-security/ stretch/updates main contrib non-free' >> /etc/apt/sources.list

RUN apt-get update
RUN mkdir -p /usr/share/man/man1
RUN apt-get -y install openjdk-8-jdk
RUN apt-get -y install git wget curl unzip make repo

RUN apt-get -y upgrade
RUN wget https://services.gradle.org/distributions/gradle-5.6.2-bin.zip -P /tmp
RUN unzip -d /opt/gradle /tmp/gradle-*.zip
RUN ln -s /opt/gradle/gradle-5.6.2 /opt/gradle/latest
RUN echo 'export GRADLE_HOME=/opt/gradle/latest' >> /root/.bashrc
RUN echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' >> /root/.bashrc
RUN echo 'export ''GRADLE_OPTS=-Dorg.gradle.jvmargs="-Xmx4048m -Dfile.encoding=UTF-8 -Duser.country=US -Duser.language=en -Duser.variant"''' >> /root/.bashrc
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -P /tmp
RUN mkdir -p /opt/android_sdk
RUN unzip -d /opt/android_sdk /tmp/sdk-tools-linux-*.zip
RUN echo 'export ANDROID_HOME=/opt/android_sdk' >> /root/.bashrc
RUN echo 'export ANDROID_SDK=/opt/android_sdk' >> /root/.bashrc
RUN echo 'export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${PATH}' >> /root/.bashrc
RUN mkdir -p /root/.android
RUN touch /root/.android/repositories.cfg
RUN yes | /opt/android_sdk/tools/bin/sdkmanager --licenses
RUN /opt/android_sdk/tools/bin/sdkmanager "platform-tools" "build-tools;28.0.3" "platforms;android-28"
RUN wget https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip -P /tmp
RUN mkdir -p /opt/android_ndk
RUN unzip -d /opt/android_ndk /tmp/android-ndk-r21-linux-x86_64.zip
RUN ln -s /opt/android_ndk/android-ndk-r21 /opt/android_ndk/latest
RUN echo 'export ANDROID_NDK=/opt/android_ndk/latest' >> /root/.bashrc
RUN mkdir -p /osmand/build
RUN mkdir -p /osmand/output
RUN echo 'export TARGET_APP_NAME=OsmAnd Handmade' >> /root/.bashrc
RUN echo 'alias nightly_build="export APP_EDITION=`date +%Y-%m-%d-%H-%M` && cd /osmand/build/android/OsmAnd && ../gradlew --info cleanNoTranslate assembleFullLegacyFatDebug && find -iname '*.apk' -exec cp {} /osmand/output/ \;"' >> /root/.bashrc
RUN echo 'alias update_repos="cd /osmand/build && repo sync -d -c -q"' >> /root/.bashrc
RUN cd /osmand/build && repo init -u https://github.com/osmandapp/OsmAnd-manifest -m android_build.xml
RUN source /root/.bashrc  && cd /osmand/build && repo sync -d -c -q && export APP_EDITION=`date +%Y-%m-%d-%H-%M` && cd /osmand/build/android/OsmAnd && ../gradlew --info cleanNoTranslate assembleFullLegacyFatDebug && find -iname '*.apk' -exec cp {} /osmand/output/ \;

VOLUME ["/osmand/output"]
