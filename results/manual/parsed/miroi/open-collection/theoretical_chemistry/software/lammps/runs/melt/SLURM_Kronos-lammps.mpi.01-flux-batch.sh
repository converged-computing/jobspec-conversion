#!/bin/bash
#FLUX: --job-name=quirky-hope-7143
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MKL_DYNAMIC='FALSE'
export OMP_DYNAMIC='FALSE'
export LAMMPS_EXE='/lustre/nyx/ukt/milias/work/software/lammps/lammps_stable/src/lmp_icc_openmpi'

echo -e "Kronos cluster - running on host `hostname`"
echo -e "Time is `date` \n"
echo -e "\nJob user is $SLURM_JOB_USER and his job $SLURM_JOB_NAME has assigned ID $SLURM_JOBID"
echo -e "This job was submitted from the computer $SLURM_SUBMIT_HOST"
echo -e "and from the home directory:\c" 
echo $SLURM_SUBMIT_DIR
echo -e "\nIt is running on the cluster compute node SLURM_CLUSTER_NAME=$SLURM_CLUSTER_NAME "
echo -e "Job is employing $SLURM_JOB_NUM_NODES node/nodes: $SLURM_JOB_NODELIST"
echo -e "\nJob partition is $SLURM_JOB_PARTITION \n"
echo -e "The job requests $SLURM_CPUS_ON_NODE CPU per task."
module use /cvmfs/it.gsi.de/modulefiles/
echo -e "All modules at disposal:"
module avail
echo -e "\n Loading openmpi/intel/4.0_intel17.4:"
module load openmpi/intel/4.0_intel17.4
echo -e ".... loaded modules:"
module list
echo -e "The node's CPU \c"; cat /proc/cpuinfo | grep 'model name' | uniq
NPROCS=`cat /proc/cpuinfo | grep processor | wc -l`
echo "This node has $SLURM_CPUS_ON_NODE CPUs allocated for SLURM calculations."
echo -e "\n The total memory at the given node (in GB)"
free -t -g
export OMP_NUM_THREADS=1
export MKL_DYNAMIC="FALSE"
export OMP_DYNAMIC="FALSE"
export LAMMPS_EXE=/lustre/nyx/ukt/milias/work/software/lammps/lammps_stable/src/lmp_icc_openmpi
echo -e "\nldd $LAMMPS_EXE:"
ldd $LAMMPS_EXE
echo -e "\n ifort -V: \c"; ifort -V
echo -e "\nMy PATH=$PATH\n"
echo -e "Python -v :\c"; python -V
echo -e "\n mpirun ? \c"; which mpirun; mpirun --version
cd $SLURM_SUBMIT_DIR
echo -e "\n I am in SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo -e "...for control, pwd=\c";pwd
echo -e "\nLaunching mpirun -np $SLURM_CPUS_ON_NODE $LAMMPS_EXE -in in.melt :"
mpirun -np $SLURM_CPUS_ON_NODE $LAMMPS_EXE -in in.melt
exit
