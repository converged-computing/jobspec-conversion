#!/bin/bash
#FLUX: --job-name=persnickety-knife-3250
#FLUX: -N=9
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export COMMIT='$1'
export MFIX='/app/mfix/build/mfix/mfix'
export WD='/scratch/summit/holtat/tumbler_120k_large'
export IMAGE='/scratch/summit/holtat/singularity/mfix-exa_develop_${COMMIT}.sif'
export MPIRUN='/projects/holtat/spack/opt/spack/linux-rhel7-x86_64/gcc-6.1.0/openmpi-2.1.2-foemyxg2vl7b3l57e7vhgqtlwggubj3a/bin/mpirun'
export DATE='$(sed '1q;d' ${COMMIT}_info.txt | awk '{print $1;}')'
export HASH='$(sed '2q;d' ${COMMIT}_info.txt)'

export COMMIT=$1
echo 'COMMIT'
echo $COMMIT
source /etc/profile.d/lmod.sh
ml singularity/3.0.2 gcc/6.1.0
cd /scratch/summit/holtat/singularity
singularity pull library://aarontholt/default/mfix-exa:develop_${COMMIT}
chmod g+w mfix-exa_develop_${COMMIT}.sif
export MFIX=/app/mfix/build/mfix/mfix
export WD=/scratch/summit/holtat/tumbler_120k_large
export IMAGE=/scratch/summit/holtat/singularity/mfix-exa_develop_${COMMIT}.sif
export MPIRUN=/projects/holtat/spack/opt/spack/linux-rhel7-x86_64/gcc-6.1.0/openmpi-2.1.2-foemyxg2vl7b3l57e7vhgqtlwggubj3a/bin/mpirun
singularity exec $IMAGE bash -c "cd /app/mfix; git log -n 1 --pretty=format:'%ai'" > ${COMMIT}_info.txt
printf "\n" >> ${COMMIT}_info.txt
singularity exec $IMAGE bash -c "cd /app/mfix; git log -n 1 --pretty=format:'%h'" >> ${COMMIT}_info.txt
printf "\n" >> ${COMMIT}_info.txt
echo $SLURM_NODELIST >> ${COMMIT}_info.txt
printf "\n" >> ${COMMIT}_info.txt
ml 2>&1 | grep 1 >> ${COMMIT}_info.txt
export DATE=$(sed '1q;d' ${COMMIT}_info.txt | awk '{print $1;}')
export HASH=$(sed '2q;d' ${COMMIT}_info.txt)
echo $DATE
echo $HASH
echo $SLURM_NODELIST
mkdir -p /projects/holtat/CICD/results/tumbler_120k_large/metadata
cp ${COMMIT}_info.txt /projects/holtat/CICD/results/tumbler_120k_small/metadata/${DATE}_${HASH}.txt
for dir in {np_00001,np_00008,np_00027,np_00064,np_00125,np_00216}; do
    # Make dir if needed
    mkdir -p $WD/$dir
    cd $WD/$dir
    pwd
    # Get np from dir
    np=${dir:(-5)}
    np=$((10#$np))
    $MPIRUN -np $np singularity exec $IMAGE bash -c "$MFIX inputs >> ${DATE}_${HASH}_${dir}"
done
cd $WD
for dir in {np_00001,np_00008,np_00027,np_00064,np_00125,np_00216}; do
    mkdir -p /projects/holtat/CICD/results/tumbler_120k_large/${dir}
    cp ${dir}/${DATE}_${HASH}* /projects/holtat/CICD/results/tumbler_120k_large/${dir}/
done
