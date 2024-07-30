# ============================
# Prepare Build Environment
FROM hub.aiursoft.cn/python:3.11 as python-env
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y weasyprint fonts-noto-cjk wget unzip
RUN rm node_modules -rf && pip install -r requirements.txt
RUN mkdocs build

# ============================
# Prepare Runtime Environment
FROM hub.aiursoft.cn/aiursoft/static
COPY --from=python-env /app/site /data

