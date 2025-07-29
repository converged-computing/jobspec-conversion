#!/bin/bash
#FLUX: --job-name=cs
#FLUX: -N=4
#FLUX: --queue=ccq
#FLUX: -t=604800
#FLUX: --urgency=16

echo "#########################################################" >  host.txt
echo "SLURM_JOB_NUM_NODES  =" $SLURM_JOB_NUM_NODES               >> host.txt
echo "SLURM_JOB_NODELIST   =" $SLURM_JOB_NODELIST                >> host.txt
echo "SLURM_NTASKS         =" $SLURM_NTASKS                      >> host.txt
echo "SLURM_TASKS_PER_NODE =" $SLURM_TASKS_PER_NODE              >> host.txt
echo "#########################################################" >> host.txt
module load slurm
module load julia
module load openmpi4
cd $SLURM_SUBMIT_DIR
/mnt/home/kunchen/.julia/bin/mpiexecjl julia /mnt/home/kunchen/project/EFT_UEG/green/greenMC.jl >> output.dat
