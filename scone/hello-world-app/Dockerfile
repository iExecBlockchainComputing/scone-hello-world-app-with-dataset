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


### this file is a temporary work around and it will
### remove in the next releases but it is required
### by the iExec plateform for now.
COPY ./utils/signer.py /signer/signer.py

###  protect file system with scone
COPY ./utils/protect-fs.sh  /protect-fs.sh
RUN bash /protect-fs.sh /app
RUN rm /protect-fs.sh

ENTRYPOINT python3 /app/app.py
