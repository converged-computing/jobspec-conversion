#!/bin/bash
#FLUX: --job-name=sticky-nalgas-4840
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export COMMIT='$1'
export MFIX='/app/mfix/build/mfix/mfix'
export WD='/scratch/summit/holtat/hcs_200k_ws'
export IMAGE='/scratch/summit/holtat/singularity/mfix-exa_${BRANCH}_${COMMIT}.sif'
export MPIRUN='/pl/active/mfix/holtat/openmpi-2.1.6-install/bin/mpirun'
export DATE='$(sed '1q;d' ${BRANCH}_${COMMIT}_info.txt | awk '{print $1;}')'
export HASH='$(sed '2q;d' ${BRANCH}_${COMMIT}_info.txt)'

export COMMIT=$1
echo 'COMMIT'
echo $COMMIT
source /etc/profile.d/lmod.sh
ml use /pl/active/mfix/holtat/modules
ml singularity/3.6.4 gcc/8.2.0 openmpi_2.1.6
cd /scratch/summit/holtat/singularity
singularity pull --allow-unsigned --force library://aarontholt/default/mfix-exa:${BRANCH}_${COMMIT}
export MFIX=/app/mfix/build/mfix/mfix
export WD=/scratch/summit/holtat/hcs_200k_ws
export IMAGE=/scratch/summit/holtat/singularity/mfix-exa_${BRANCH}_${COMMIT}.sif
export MPIRUN=/pl/active/mfix/holtat/openmpi-2.1.6-install/bin/mpirun
cd $WD
singularity exec $IMAGE bash -c "cd /app/mfix; git log -n 1 --pretty=format:'%ai'" > ${BRANCH}_${COMMIT}_info.txt
printf "\n" >> ${BRANCH}_${COMMIT}_info.txt
singularity exec $IMAGE bash -c "cd /app/mfix; git log -n 1 --pretty=format:'%h'" >> ${BRANCH}_${COMMIT}_info.txt
printf "\n" >> ${BRANCH}_${COMMIT}_info.txt
echo $SLURM_NODELIST >> ${BRANCH}_${COMMIT}_info.txt
printf "\n" >> ${BRANCH}_${COMMIT}_info.txt
echo $SLURM_JOBID >>${BRANCH}_${COMMIT}_info.txt
printf "\n"
ml 2>&1 | grep 1 >> ${BRANCH}_${COMMIT}_info.txt
export DATE=$(sed '1q;d' ${BRANCH}_${COMMIT}_info.txt | awk '{print $1;}')
export HASH=$(sed '2q;d' ${BRANCH}_${COMMIT}_info.txt)
echo $DATE
echo $HASH
echo $SLURM_NODELIST
for dir in {np_0001,np_0008,np_0027}; do
    # Make directory if needed
    mkdir -p $WD/$dir
    cd $WD/$dir
    pwd
    # Get np from dir
    np=${dir:(-4)}
    np=$((10#$np))
    # Run default then timestepping
    $MPIRUN -np $np singularity exec $IMAGE bash -c "$MFIX inputs >> ${DATE}_${HASH}_${dir}"
    $MPIRUN -np $np singularity exec $IMAGE bash -c "$MFIX inputs_adapt >> ${DATE}_${HASH}_${dir}_adapt"
    #Consider mpirun -np $np --map-by node ...
done
ml python/3.5.1 intel/17.4 git
source /projects/holtat/CICD/elastic_env/bin/activate
cd /projects/holtat/CICD/exa_cicd/Elasticsearch
git pull
for dir in {np_0001,np_0008,np_0027}; do
    np=${dir:(-4)}
    python3 output_to_es.py --work-dir $WD --np $np --commit-date $DATE \
      --git-hash $HASH --git-branch $BRANCH --sing-image-path $IMAGE
    python3 output_to_es.py --work-dir $WD --np $np --commit-date $DATE \
      --git-hash $HASH --git-branch $BRANCH --sing-image-path $IMAGE \
      --type adapt
done
