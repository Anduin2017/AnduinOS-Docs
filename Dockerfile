# ============================
# Prepare Build Environment
FROM hub.aiursoft.cn/aiursoft/internalimages/ubuntu:latest as python-env
WORKDIR /app
COPY . .

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install tzdata and set the timezone to UTC
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y tzdata && \
    echo "Etc/UTC" > /etc/timezone && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y weasyprint fonts-noto-cjk wget unzip python3-pip

# Allow pip to break system packages
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN pip install -r requirements.txt

# TODO: Add --strict to check all links
RUN mkdocs build

# ============================
# Prepare Runtime Environment
FROM hub.aiursoft.cn/aiursoft/static
COPY --from=python-env /app/site /data

