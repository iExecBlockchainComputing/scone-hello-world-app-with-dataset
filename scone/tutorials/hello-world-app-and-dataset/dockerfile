FROM iexechub/sconecuratedimages-iexec:cli-alpine   AS scone
FROM nexus.iex.ec/scone-utils:0.0.1                 AS utils
FROM iexechub/sconecuratedimages-iexec:python-3.7.3-alpine-3.10

COPY --from=scone   /opt/scone/scone-cli    /opt/scone/scone-cli
COPY --from=scone   /usr/local/bin/scone    /usr/local/bin/scone
COPY --from=scone   /opt/scone/bin          /opt/scone/bin
COPY --from=utils   /iexec/signer.py        /signer/signer.py
COPY --from=utils   /iexec/protect-fs.sh  /iexec/protect-fs.sh

### start editing from here


# install apk dependencies
RUN apk add --no-cache bash build-base gcc libgcc

### uncomment and add your pip dependencies
# RUN SCONE_MODE=sim pip install web3

### or use a requirements.txt file
# COPY ./requirements.txt /requirements.txt
# RUN SCONE_MODE=sim pip install -r /requirements.txt

### copy code folder and protect it with scone
COPY ./src /app
RUN bash /iexec/protect-fs.sh /app


ENTRYPOINT python3 /app/app.py
