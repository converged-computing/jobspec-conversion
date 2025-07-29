#!/bin/bash
#SBATCH --job-name=mmu_chn2
#SBATCH --account=bd17
#SBATCH --output=/projects/bd17/mziemann/dee2/MyJob-%j.out
#SBATCH --error=/projects/bd17/mziemann/dee2/MyJob-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4000
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

set -x
clear_shared_mem(){
for SHMEM_ID in $(ipcs | awk '$5>1000 && $3~/mziemann/ {print $2}') ; do
 ipcrm --shmem-id $SHMEM_ID
done
}
export -f clear_shared_mem
clear_shared_mem
module add singularity/2.4.2
cd /scratch/bd17/mziemann/singularity/working
touch a
for i in * ; do
  CONTAINER_AGE=$(expr $(date +%s) - $(stat -c %Y $i) )
  echo $i modified $CONTAINER_AGE seconds ago 
  if [ $CONTAINER_AGE -gt 14400 ] ; then
    rm -rf $i
    echo deleted $i
  fi
done
TIMESTAMP="$(date +'%s')_$(echo {a..z}{0..9} | tr ' ' '\n'  | shuf -n1)"
CWD=dee2_container_${TIMESTAMP}
mkdir $CWD
cd $CWD
cp -r /projects/bd17/mziemann/dee2/sing/singularity_mmusculus/* .
pwd
while true ; do
 clear_shared_mem
 singularity run -w -B tmp:/tmp mziemann_tallyup-2018-01-23-3a04c7fd01c6.img mmusculus
 sleep 10
done &
sleep 110m
killall -9 udocker
clear_shared_mem
sbatch /projects/bd17/mziemann/dee2/dee2_scratch_mmu_sing.sbatch
