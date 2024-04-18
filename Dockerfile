FROM arm64v8/node:20-bookworm-slim

ENV CHROME_BIN=/usr/bin/chromium
ENV CHROME_PATH=/usr/lib/chromium/
ENV MEMORY_CACHE=0

# install chromium, tini and clear cache
RUN apt update && apt upgrade -y && apt install chromium tini git -y

USER node
WORKDIR "/home/node"

COPY ./package.json .
COPY ./server.js .

# install npm packages
RUN npm install --no-package-lock

EXPOSE 3000

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "server.js"]
