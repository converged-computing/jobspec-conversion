#!/bin/bash
#FLUX: --job-name=salted-latke-3896
#FLUX: --queue=interact
#FLUX: -t=28800
#FLUX: --urgency=16

export TMPDIR='${PWD}'
export RSTUDIO_AUTH='${TMPDIR}/.config/auth'
export SINGULARITYENV_XDG_DATA_HOME='${TMPDIR}/.local/share'
export SINGULARITYENV_XDG_CONFIG_HOME='${TMPDIR}/.config/rstudio'
export DBCONF='${TMPDIR}/.config/database.conf'
export PASSWORD='$(openssl rand -base64 8)'

copy_prefs=false
module purge
module load singularity
export TMPDIR="${PWD}"
mkdir -p "$TMPDIR/tmp/${SLURM_JOB_ID}/rstudio-server"
uuidgen > "$TMPDIR/tmp/${SLURM_JOB_ID}/rstudio-server/secure-cookie-key"
chmod 0600 "$TMPDIR/tmp/${SLURM_JOB_ID}/rstudio-server/secure-cookie-key"
mkdir -p "$TMPDIR/var/lib"
mkdir -p "$TMPDIR/var/run"
mkdir -p "$TMPDIR/.config"
mkdir -p "$TMPDIR/.local/share"
if $copy_prefs; then
  cp $TMPDIR/rstudio-singularity/conf/rstudio-prefs.json $TMPDIR/.config/rstudio/.
fi
cp $TMPDIR/rstudio-singularity/conf/auth $TMPDIR/.config/.
if [ ! -d "$TMPDIR"/var/logs ];then
	mkdir -p "$TMPDIR"/var/logs
fi
export RSTUDIO_AUTH="${TMPDIR}/.config/auth"
export SINGULARITYENV_XDG_DATA_HOME=${TMPDIR}/.local/share
export SINGULARITYENV_XDG_CONFIG_HOME=${TMPDIR}/.config/rstudio
cat > "$TMPDIR/.config/rsession.conf" << EOF 
session-save-action-default=no
session-default-working-dir=${TMPDIR} 
EOF
export DBCONF="${TMPDIR}/.config/database.conf"
(
umask 077
sed 's/^ \{2\}//' > "${DBCONF}" << EOL
  # set database location
  provider=sqlite
  directory=${TMPDIR}/tmp/${SLURM_JOB_ID}/rstudio-server/db
EOL
)
chmod 700 "${DBCONF}"
sifFile=$1
export PASSWORD=$(openssl rand -base64 8)
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat > rstudio-login.txt <<END
Rstudio server started with working directory: ${TMPDIR}
1. SSH tunnel from your workstation using the following command:
ssh -N -L 8989:${HOSTNAME}:${PORT} ${USER}@longleaf.unc.edu
and point your web browser to http://localhost:8989
2. log in to RStudio Server using the following credentials:
username: <YOUR LL USERNAME>
pass: ${PASSWORD}
To end the session:
Press red power button in the RStudio Server web interface to log out.
*I believe this is important to properly close any lingering processes.*
Then:
scancel -f ${SLURM_JOB_ID}
END
RSTUDIO_PASSWORD=${PASSWORD} singularity exec \
  --bind="$TMPDIR/var/lib:/var/lib/rs${SLURM_JOB_ID}tudio-server" \
  --bind="$TMPDIR/var/run:/var/run/rstudio-server" \
  --bind="$TMPDIR/tmp/${SLURM_JOB_ID}:/tmp" \
  --bind="$TMPDIR/.config/rsession.conf:/etc/rstudio/rsession.conf" \
  --bind="$TMPDIR:$TMPDIR" \
  $sifFile \
  rserver --server-user ${USER} \
    --www-port ${PORT} \
    --auth-none=0 \
    --auth-pam-helper-path "$TMPDIR/.config/auth" \
    --database-config-file "${DBCONF}" \
    --auth-timeout-minutes=0 --auth-stay-signed-in-days=2 
printf 'rserver exited' 1>&2
