FROM node:16

ENV DEBIAN_FRONTEND=noninteractive

# Angular CLI
RUN npm install -g @angular/cli


CMD ["bash"]
