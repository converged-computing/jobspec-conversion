#!/bin/bash
#FLUX: --job-name=crunchy-spoon-8094
#FLUX: --urgency=16

export NODES='$(unslurm.py)'
export SECS='2'
export MAX_SIZE='15'
export SING_OPTS='--bind /etc/ssh/ssh_known_hosts --bind /etc/hosts --bind /etc/hostname'

export NODES=$(unslurm.py)
if [ "$NODES" = "" ]
then
    echo "NO NODES" >&2
    exit 2
fi
for k in $(env | cut -d= -f1 |grep SLURM)
do
   unset $k
done
export SECS=2
export MAX_SIZE=15
export SING_OPTS="--bind $HOME/libmpich:/usr/lib64/mpich/lib --bind /etc/ssh/ssh_known_hosts --bind /etc/hosts --bind /etc/hostname"
singularity exec $SING_OPTS /work/sbrandt/sing-mpi.simg bash ./launch.sh
mv pingpong.txt pingpong-native.txt
export SING_OPTS="--bind /etc/ssh/ssh_known_hosts --bind /etc/hosts --bind /etc/hostname"
singularity exec $SING_OPTS /work/sbrandt/sing-mpi.simg bash ./launch.sh
mv pingpong.txt pingpong-image.txt
