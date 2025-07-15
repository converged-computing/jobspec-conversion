#!/bin/bash
#FLUX: --job-name=complex
#FLUX: --queue=standard
#FLUX: -t=129600
#FLUX: --priority=16

LAMBDA=$SLURM_ARRAY_TASK_ID
nprocs=$SLURM_NTASKS
nnodes=$SLURM_JOB_NUM_NODES
slurm_startjob(){
. ~/.bashrc
dir=${SLURM_SUBMIT_DIR}
cd $SLURM_SUBMIT_DIR
module purge
module load gromacs/2021.2/gcc.8.4.0
echo "Submitting ${ID}"
echo "Job directory: ${SLURM_SUBMIT_DIR}"
cd EM
pwd
gmx grompp -f em.mdp -c ../complex.gro -p ../complex.top -o em.tpr -maxwarn 1
gmx mdrun -deffnm em -s em.tpr -ntomp 8 -ntmpi 1 
sleep 10
echo "Starting constant volume equilibration..."
cd ../
cd NVT_equi
gmx grompp -f nvt.mdp -c ../EM/em.gro -p ../complex.top -o nvt.tpr -maxwarn 1
gmx mdrun -deffnm nvt -s nvt.tpr -ntomp 8 -ntmpi 1 
cd ../
cd NPT
gmx grompp -f npt.mdp -c ../NVT_equi/nvt.gro -p ../complex.top -o npt.tpr -maxwarn 1
echo Job Done
}
slurm_info_out(){
echo "=================================== SLURM JOB ==================================="
date
echo
echo "The job will be started on the following node(s):"
echo $SLURM_JOB_NODELIST
echo
echo "Slurm User:         $SLURM_JOB_USER"
echo "Run Directory:      $(pwd)"
echo "Job ID:             ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
echo "Job Name:           $SLURM_JOB_NAME"
echo "Partition:          $SLURM_JOB_PARTITION"
echo "Number of nodes:    $SLURM_JOB_NUM_NODES"
echo "Number of tasks:    $SLURM_NTASKS"
echo "Submitted From:     $SLURM_SUBMIT_HOST:$SLURM_SUBMIT_DIR"
echo "=================================== SLURM JOB ==================================="
echo
echo "--- SLURM job-script output ---"
}
slurm_info_out
slurm_startjob
