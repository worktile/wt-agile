############ build stage ###############
FROM node:10-stretch as WikiAgile

RUN npm install -g gitbook-cli 

COPY ./ /code

RUN cd /code && \
    gitbook install ./ && \
    gitbook build && \
    mv ./_book/ /prod 
    

######## production stage ############
FROM nginx:mainline-alpine

RUN rm /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/

COPY --from=WikiAgile /prod/ /etc/nginx/html/agile/








