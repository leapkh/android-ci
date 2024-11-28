FROM openjdk:17-jdk

LABEL org.opencontainers.image.authors="leapkh@yahoo.com"

WORKDIR /leapkh

ENV ANDROID_COMPILE_SDK=34
ENV ANDROID_BUILD_TOOLS=34.0.0
ENV ANDROID_CMDLINE_TOOLS=8512546_latest

# Utility packages
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6
RUN apt-get -qq install curl jq

# Android SDK
RUN wget --quiet --output-document=cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDLINE_TOOLS}.zip
RUN mkdir -p android-sdk/cmdline-tools
RUN unzip -d android-sdk/cmdline-tools cmdline-tools.zip
RUN mv android-sdk/cmdline-tools/cmdline-tools android-sdk/cmdline-tools/latest
ENV ANDROID_SDK_ROOT=/leapkh/android-sdk
RUN echo y | android-sdk/cmdline-tools/latest/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk/cmdline-tools/latest/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk/cmdline-tools/latest/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
ENV PATH=$PATH:/leapkh/android-sdk/platform-tools/
RUN yes | android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses
ENV GRADLE_USER_HOME=/leapkh/.gradle
