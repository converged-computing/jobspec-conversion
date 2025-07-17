#!/bin/bash
#FLUX: --job-name=SNAP_runh0064
#FLUX: -N=2
#FLUX: --queue=standard
#FLUX: -t=10800
#FLUX: --urgency=16

source $HOME/telegraf_run_chicoma.sh
date;hostname;pwd
echo $SLURM_JOBID
launch_telegraf
module purge
module load charliecloud
sleep 15 
date +%s
cp /etc/ssl/openssl.cnf $HOME/img/amd64_snap-daap:latest/etc/ssl/
SLURM_HOSTS=`/usr/bin/scontrol show hostname "$SLURM_JOB_NODELIST" | tr '\n' "," | sed -e 's/,$//'`
IFS=',' read -ra host_array <<< "$SLURM_HOSTS"
host_array_len=${#host_array[@]}
for h in "${host_array[@]}"
do
 ssh $h cp -r $HOME/img/amd64_snap-daap:latest /var/tmp/amd64_snap-daap
done
srun --mpi=pmi2 -n 8 -c 1 ch-run --set-env=DAAP_CERTS=/usr/local/src/daap_certs -w --join /var/tmp/amd64_snap-daap -- /usr/local/src/2018-xroads-trinity-snap/snap-src/gsnap /usr/local/src/2018-xroads-trinity-snap/inputs/inh0001t4 /root/output
date +%s
sleep 15
rm -rf ${TELEGRAF_TMP}
kill_telegraf
date
