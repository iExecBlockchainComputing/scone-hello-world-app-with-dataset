FROM iexechub/sconecuratedimages-iexec:cli-alpine AS scone

FROM iexechub/sconecuratedimages-iexec:python-3.7.3-alpine-3.10

COPY --from=scone   /opt/scone/scone-cli    /opt/scone/scone-cli
COPY --from=scone   /usr/local/bin/scone    /usr/local/bin/scone
COPY --from=scone   /opt/scone/bin          /opt/scone/bin


################################

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories \
    && apk update \
    && apk add --update-cache --no-cache libgcc bash \
    && apk --no-cache --update-cache add gcc gfortran python python-dev py-pip build-base wget freetype-dev libpng-dev \
    && apk add --no-cache --virtual .build-deps gcc musl-dev

RUN SCONE_MODE=sim pip install attrdict python-gnupg web3

COPY src /app

################################

### this file is a temporary work around and it will
### be removed in the next releases but it is required
### by the iExec plateform for now.
COPY ./utils/signer.py /signer/signer.py

###  protect file system with scone
RUN SCONE_MODE=sim SCONE_HASH=1 SCONE_HEAP=1G SCONE_ALPINE=1		    \
	&& mkdir conf							    \
	&& scone fspf create fspf.pb 					    \
	&& scone fspf addr fspf.pb /  --not-protected --kernel /            \
	&& scone fspf addr fspf.pb /usr --authenticated --kernel /usr       \
	&& scone fspf addf fspf.pb /usr /usr 			            \
	&& scone fspf addr fspf.pb /bin --authenticated --kernel /bin       \
	&& scone fspf addf fspf.pb /bin /bin 			            \
	&& scone fspf addr fspf.pb /lib --authenticated --kernel /lib       \
	&& scone fspf addf fspf.pb /lib /lib 			            \
	&& scone fspf addr fspf.pb /etc --authenticated --kernel /etc       \
	&& scone fspf addf fspf.pb /etc /etc 			            \
	&& scone fspf addr fspf.pb /sbin --authenticated --kernel /sbin     \
	&& scone fspf addf fspf.pb /sbin /sbin 			            \
	&& scone fspf addr fspf.pb /signer --authenticated --kernel /signer \
	&& scone fspf addf fspf.pb /signer /signer 			    \
	&& scone fspf addr fspf.pb /app --authenticated --kernel /app 	    \
	&& scone fspf addf fspf.pb /app /app 				    \
	&& scone fspf encrypt ./fspf.pb > /conf/keytag 			    \
	&& MRENCLAVE="$(SCONE_HASH=1 python)"			            \
	&& FSPF_TAG=$(cat conf/keytag | awk '{print $9}') 	            \
	&& FSPF_KEY=$(cat conf/keytag | awk '{print $11}')		    \
	&& FINGERPRINT="$FSPF_KEY|$FSPF_TAG|$MRENCLAVE"			    \
	&& echo $FINGERPRINT > conf/fingerprint.txt			    \
	&& printf "\n########################################################\nMREnclave: $FINGERPRINT\n########################################################\n\n"

