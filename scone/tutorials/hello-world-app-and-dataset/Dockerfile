FROM iexechub/sconecuratedimages-iexec:cli-alpine AS scone

FROM iexechub/sconecuratedimages-iexec:python-3.7.3-alpine-3.10

COPY --from=scone   /opt/scone/scone-cli    /opt/scone/scone-cli
COPY --from=scone   /usr/local/bin/scone    /usr/local/bin/scone
COPY --from=scone   /opt/scone/bin          /opt/scone/bin


################################

### install apk dependencies
RUN apk add --no-cache bash build-base gcc libgcc

### uncomment and add your pip dependencies
# RUN SCONE_MODE=sim pip install web3

### or use a requirements.txt file
# COPY ./requirements.txt /requirements.txt
# RUN SCONE_MODE=sim pip install -r /requirements.txt

### copy the code inside the image
COPY ./src /app

################################


### please don't change those 2 lines
COPY ./utils/signer.py      /signer/signer.py
COPY ./utils/protect-fs.sh  /iexec/protect-fs.sh

###  protect file system with scone
RUN bash /iexec/protect-fs.sh /app
RUN rm /iexec/protect-fs.sh

ENTRYPOINT python3 /app/app.py
