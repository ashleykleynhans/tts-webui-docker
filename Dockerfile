ARG BASE_IMAGE
FROM ${BASE_IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=on \
    SHELL=/bin/bash

RUN apt-get update && apt-get install -y \
    libavformat-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavutil-dev \
    libavfilter-dev \
    libswscale-dev \
    libswresample-dev \
    ffmpeg \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install TTS WebUI
ARG INDEX_URL
ARG TORCH_VERSION
ARG XFORMERS_VERSION
ARG TTS_TAG
ENV INDEX_URL=${INDEX_URL}
ENV TORCH_VERSION=${TORCH_VERSION}
ENV XFORMERS_VERSION=${XFORMERS_VERSION}
ENV TTS_TAG=${TTS_TAG}
COPY --chmod=755 build/install.sh /install.sh
RUN /install.sh && rm /install.sh

# Copy configuration files
COPY config.json /TTS-WebUI/config.json
COPY .env /TTS-WebUI/.env

# Install Application Manager
ARG APP_MANAGER_VERSION
RUN /install_app_manager.sh
COPY app-manager/config.json /app-manager/public/config.json
COPY --chmod=755 app-manager/*.sh /app-manager/scripts/

# Remove existing SSH host keys
RUN rm -f /etc/ssh/ssh_host_*

# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Set template version
ARG RELEASE
ENV TEMPLATE_VERSION=${RELEASE}

# Copy the scripts
WORKDIR /
COPY --chmod=755 scripts/* ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]
