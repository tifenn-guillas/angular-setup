FROM node:18

ENV NG_CLI_ANALYTICS ci
ENV NG_FORCE_TTY false

WORKDIR /src

# Angular CLI
RUN yarn global add @angular/cli -y
RUN ng analytics disable --global

CMD ["bash"]