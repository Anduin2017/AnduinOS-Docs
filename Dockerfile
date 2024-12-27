# ============================
# Prepare Build Environment
# ============================
FROM hub.aiursoft.cn/aiursoft/internalimages/ubuntu:latest as builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-venv \
    python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./

RUN PIP_BREAK_SYSTEM_PACKAGES=1 python3 -m pip install --no-cache-dir --upgrade setuptools && \
    PIP_BREAK_SYSTEM_PACKAGES=1 python3 -m pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python3 -m mkdocs build

# ============================
# Prepare Runtime Environment
# ============================
FROM hub.aiursoft.cn/aiursoft/static

COPY --from=builder /app/site /data
