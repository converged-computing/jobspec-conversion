#!/bin/bash
#FLUX: --job-name=xmas_test
#FLUX: --queue=xmas
#FLUX: -t=3900
#FLUX: --urgency=16

STIME=300   # sleep time
JOBS=20  
JOBS_P=5
for N in $(seq 1 $JOBS); do
	srun -J 1sn${N} --partition=cf1 --account=scs --qos=cf_normal --time 00:07:00   sleep ${STIME} &
done
sleep 10
for N in $(seq 1 $JOBS_P); do
	srun -J 2snHP${N} --partition=cf1-hp --account=scs --qos=condo_mp --time 00:07:00   sleep ${STIME} &
done
sleep 10
for N in $(seq 1 24); do
	srun -J 3sn${N}   --partition=cf1 --account=scs --qos=cf_normal --time 00:07:00   sleep ${STIME} &
	srun -J 3snHP${N} --partition=cf1-hp --account=scs --qos=condo_mp --time 00:07:00   sleep ${STIME} &
done
exit 0
for N in $(seq 1 $JOBS); do
	##sbatch --partition=cf1 --account=lr_mp --qos=condo_mp --name J$N sleep $STIME  --time 00:10:00 
	#sbatch --partition=cf1 --account=lr_mp --qos=condo_mp  sleep $STIME  --time 00:10:00 
	#sbatch --partition=cf1 --account=scs --qos=condo_mp  $STIME  --time 00:10:00  /tmp/script
	srun -J sn${N} --partition=cf1 --account=scs --qos=cf_normal --time 00:15:00   sleep ${STIME} &
	#sbatch -w n0000.cf1 -n 64 /tmp/script
done
sleep 1000                           
exit 007
hostname
uptime
date
pwd
echo ---------------------------------------
cat /etc/os-release
echo ---------------------------------------
df -hl
echo ---------------------------------------
cat /proc/mounts
echo ---------------------------------------
echo "date before sleep"
date
sleep 60
echo "date after sleep"
date
