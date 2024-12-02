FROM gradle:jdk17

LABEL org.opencontainers.image.authors="leapkh@yahoo.com"

ENV ANDROID_SDK=35
ENV ANDROID_BUILD_TOOLS=35.0.0
ENV ANDROID_CMDLINE_TOOLS=9477386_latest

RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDLINE_TOOLS}.zip -O commandlinetools.zip
RUN mkdir -p /sdk/cmdline-tools
RUN unzip -q commandlinetools.zip -d /sdk/cmdline-tools
RUN mv /sdk/cmdline-tools/cmdline-tools /sdk/cmdline-tools/latest
RUN rm commandlinetools.zip
ENV PATH="/sdk/cmdline-tools/latest/bin:/sdk/platform-tools:$PATH"
ENV ANDROID_SDK_ROOT=/sdk
RUN echo y | sdkmanager "platforms;android-${ANDROID_SDK}" >/dev/null
RUN echo y | sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
