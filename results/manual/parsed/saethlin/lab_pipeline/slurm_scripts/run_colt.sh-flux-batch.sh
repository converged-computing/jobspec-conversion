#!/bin/bash
#FLUX: --job-name=colt-h113
#FLUX: -n=125
#FLUX: -c=8
#FLUX: --queue=hpg2-compute
#FLUX: -t=7200
#FLUX: --urgency=16

export OMPI_MCA_pml='^ucx'
export OMPI_MCA_btl='self,vader,openib'
export OMPI_MCA_oob_tcp_listen_mode='listen_thread'

export OMPI_MCA_pml="^ucx"
export OMPI_MCA_btl="self,vader,openib"
export OMPI_MCA_oob_tcp_listen_mode="listen_thread"
module purge
module load intel/2018 openmpi/3.1.2 hdf5
ID=$(printf "%03d" ${SLURM_ARRAY_TASK_ID})
WORKDIR=/ufrc/narayanan/kimockb/FIRE2/h113_HR_sn1dy300ro100ss/snapdir_${ID}/
INPUT=${WORKDIR}/converted_snapshot_${ID}.0.hdf5
srun --mpi=pmix_v2 /home/kimockb/colt-ben/bin/colt.exe ${INPUT} 1e7 --output_dir ${WORKDIR} --SB_pixels 512 --j_exp 0.25
