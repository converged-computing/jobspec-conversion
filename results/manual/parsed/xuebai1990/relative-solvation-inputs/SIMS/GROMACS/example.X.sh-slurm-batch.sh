#!/bin/bash
#FLUX: --job-name=relative_X
#FLUX: -c=2
#FLUX: --queue=mf_nes2.8,mf_ilg2.3
#FLUX: -t=381600
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1" #Disable backups'
export GMXRC='/modfac/apps/gromacs-4.6.7_gcc-generic/bin/GMXRC'
export GMXLIB='/modfac/apps/gromacs-4.6.7_gcc-generic/share/gromacs/top'
export GROMPP='/modfac/apps/gromacs-4.6.7_gcc-generic/bin/grompp_d'
export MDRUN='/modfac/apps/gromacs-4.6.7_gcc-generic/bin/mdrun_d'
export LAMBDANR='X'

copy_local="no"
nprocs=$SLURM_NTASKS
nnodes=$SLURM_JOB_NUM_NODES
slurm_startjob(){
module unload gnu
module load intel
unset OMP_NUM_THREADS
export GMX_MAXBACKUP="-1" #Disable backups
export GMXRC=/modfac/apps/gromacs-4.6.7_gcc-generic/bin/GMXRC
export GMXLIB=/modfac/apps/gromacs-4.6.7_gcc-generic/share/gromacs/top
export GROMPP=/modfac/apps/gromacs-4.6.7_gcc-generic/bin/grompp_d
export MDRUN=/modfac/apps/gromacs-4.6.7_gcc-generic/bin/mdrun_d
export LAMBDANR=X
$GROMPP -f minimize.${LAMBDANR}.mdp -c morph.gro -n index.ndx -o minimize.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm minimize.${LAMBDANR}
$GROMPP -f equil_nvt.${LAMBDANR}.mdp -c minimize.${LAMBDANR}.gro -n index.ndx -o equil_nvt.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm equil_nvt.${LAMBDANR}
$GROMPP -f equil_npt.${LAMBDANR}.mdp -c equil_nvt.${LAMBDANR}.gro -n index.ndx -o equil_npt.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm equil_npt.${LAMBDANR}
$GROMPP -f equil_npt2.${LAMBDANR}.mdp -c equil_npt.${LAMBDANR}.gro -n index.ndx -o equil_npt2.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm equil_npt2.${LAMBDANR}
$GROMPP -f prod.${LAMBDANR}.mdp -c equil_npt2.${LAMBDANR}.gro -n index.ndx -o prod.${LAMBDANR}.tpr -p morph.top 
srun $MDRUN -deffnm prod.${LAMBDANR}
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
echo "Job ID:             $SLURM_JOB_ID"
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
