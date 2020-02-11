# #!/bin/bash

# # export SCONE_HASH=1
# export SCONE_MODE=sim
# export SCONE_HEAP=1G
# export SCONE_ALPINE=1

# APP_FOLDER=$1

# printf "\n### Starting file system protection ...\n\n"

# scone fspf create /tmp/fspf.pb

# scone fspf addr /tmp/fspf.pb /          --not-protected --kernel /
# scone fspf addr /tmp/fspf.pb /usr       --authenticated --kernel /usr
# scone fspf addf /tmp/fspf.pb /usr       /usr
# scone fspf addr /tmp/fspf.pb /bin       --authenticated --kernel /bin
# scone fspf addf /tmp/fspf.pb /bin       /bin
# scone fspf addr /tmp/fspf.pb /lib       --authenticated --kernel /lib
# scone fspf addf /tmp/fspf.pb /lib       /lib
# scone fspf addr /tmp/fspf.pb /etc/ssl   --authenticated --kernel /etc/ssl
# scone fspf addf /tmp/fspf.pb /etc/ssl   /etc/ssl
# scone fspf addr /tmp/fspf.pb /sbin      --authenticated --kernel /sbin
# scone fspf addf /tmp/fspf.pb /sbin      /sbin
# scone fspf addr /tmp/fspf.pb /signer    --authenticated --kernel /signer
# scone fspf addf /tmp/fspf.pb /signer    /signer

# printf "\n### Protecting code found in folder \"$APP_FOLDER\"\n\n"
# scone fspf addr /tmp/fspf.pb $APP_FOLDER --authenticated --kernel $APP_FOLDER
# scone fspf addf /tmp/fspf.pb $APP_FOLDER $APP_FOLDER

# scone fspf encrypt /tmp/fspf.pb > /tmp/keytag

# MRENCLAVE="$(SCONE_HASH=1 python)"
# FSPF_TAG=$(cat /tmp/keytag | awk '{print $9}')
# FSPF_KEY=$(cat /tmp/keytag | awk '{print $11}')
# FINGERPRINT="$FSPF_KEY|$FSPF_TAG|$MRENCLAVE"


# printf "\n\n"
# printf "#####################################################################\n"
# printf "Application's fingerprint (use this when deploying your app onchain):\n"
# printf "$FINGERPRINT\n"
# printf "#####################################################################\n"
# printf "\n\n"


###############################

SCONE_MODE=sim SCONE_HASH=1 SCONE_HEAP=1G SCONE_ALPINE=1		    \
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