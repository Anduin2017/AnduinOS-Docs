# ============================
# Prepare Build Environment
FROM hub.aiursoft.cn/aiursoft/internalimages/ubuntu:latest as python-env

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 设置非交互式模式
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# 安装基础依赖
RUN apt-get update && \
    apt-get install -y \
    tzdata weasyprint fonts-noto-cjk wget unzip python3 python3-venv sudo python3-pip

# 创建一个非root用户
RUN useradd -m builder && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 切换到新用户环境
USER builder

# 设置工作目录（确保权限）
WORKDIR /home/builder/app

# 复制项目文件（再次确保新用户能访问）
COPY . .

# 安装依赖
RUN PIP_BREAK_SYSTEM_PACKAGES=1 pip install --upgrade setuptools
RUN PIP_BREAK_SYSTEM_PACKAGES=1 pip install -r requirements.txt

# 构建文档
RUN /home/builder/.local/bin/mkdocs build

# ============================
# Prepare Runtime Environment
FROM hub.aiursoft.cn/aiursoft/static

# 从构建阶段复制生成的网站
COPY --from=python-env /home/builder/app/site /data
