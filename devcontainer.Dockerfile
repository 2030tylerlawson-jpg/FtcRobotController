FROM mcr.microsoft.com/devcontainers/java:1-17-bookworm

ENV ANDROID_HOME=/opt/android-sdk \
    ANDROID_SDK_ROOT=/opt/android-sdk \
    PATH=/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:${PATH}

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates unzip wget \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p "${ANDROID_HOME}/cmdline-tools" \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/commandlinetools.zip \
    && unzip -q /tmp/commandlinetools.zip -d "${ANDROID_HOME}/cmdline-tools" \
    && mv "${ANDROID_HOME}/cmdline-tools/cmdline-tools" "${ANDROID_HOME}/cmdline-tools/latest" \
    && rm /tmp/commandlinetools.zip \
    && yes | sdkmanager --licenses >/dev/null || true \
    && sdkmanager --install \
       "platform-tools" \
       "platforms;android-30" \
       "build-tools;30.0.3" \
       "ndk;21.3.6528147" \
    && chown -R vscode:vscode "${ANDROID_HOME}"

USER vscode
