# Dockerfile
FROM node:14
WORKDIR /app
COPY . /app

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
RUN npm set registry https://registry.npm.taobao.org
RUN npm install && npm run build

FROM nginx
RUN mkdir /app
COPY --from=0 /app/dist /app    
# COPY ./dist /app    
# 获取上一步打包生成的dist文件
COPY nginx.conf /etc/nginx/nginx.conf