#!/bin/bash
#FLUX: --job-name=Si
#FLUX: --queue=short
#FLUX: -t=1200
#FLUX: --priority=16

export QE='/lustre/home/ilias/work/qch/software/quantum-espresso/qe-7.0/build_intelmpi/bin'

echo -e "Job user is SLURM_JOB_USER=$SLURM_JOB_USER"
echo -e "User's job is SLURM_JOB_NAME=$SLURM_JOB_NAME has assigned ID SLURM_JOBID=$SLURM_JOBID"
echo -e "This job was submitted from the computer SLURM_SUBMIT_HOST=$SLURM_SUBMIT_HOST"
echo -e "and from the home directory: SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo -e "It is running on the cluster compute node: SLURM_CLUSTER_NAME=$SLURM_CLUSTER_NAME"
echo -e "Job  is employing SLURM_JOB_NUM_NODES=$SLURM_JOB_NUM_NODES node/nodes:"
echo -e "SLURM_JOB_NODELIST=$SLURM_JOB_NODELIST"
echo -e "The job requests SLURM_CPUS_ON_NODE=$SLURM_CPUS_ON_NODE CPU per task."
module use /lustre/home/utils/easybuild_old/modules/all
module load impi/2021.2.0-intel-compilers-2021.2.0
echo -e "List of loaded modules:"
module list
echo -e "\nRunning on host `hostname`"
echo -e "Time is `date` \n"
echo -e "\nMy PATH=$PATH\n"
echo -e "My LD_LIBRARY_PATH=$LD_LIBRARY_PATH\n"
echo -e "The node's CPU \c"; cat /proc/cpuinfo | grep 'model name' | uniq
NPROCS=`cat /proc/cpuinfo | grep processor | wc -l`
echo "This node has $NPROCS CPUs available."
echo "(i) This node has SLURM_CPUS_ON_NODE=$SLURM_CPUS_ON_NODE CPUs allocated for SLURM calculations."
echo -e "\n The TOTAL memory at the node (in GB); free -t -g"
free -t -g
echo
export QE=/lustre/home/ilias/work/qch/software/quantum-espresso/qe-7.0/build_intelmpi/bin
echo -e "\n Dependencies of QE main executable, ldd $QE/pw.x:"
ldd $QE/pw.x
echo
echo -e "Python -v :\c"; python -V
echo -e "mpirun ? which mpirun  = \c"; which mpirun
echo -e "mpirun --version \c"; mpirun --version
cd $SLURM_SUBMIT_DIR
echo -e "\n Current directory where this SLURM job is running `pwd`"
echo " It has the disk space of (df -h) :"
df -h .
echo
 #project=Si.scf
 project=Si.scf_k10x10x10
 inp=$project.in
 out=$project.$SLURM_CLUSTER_NAME.$SLURM_JOBID.out$SLURM_CPUS_ON_NODE
 mpirun -np $SLURM_CPUS_ON_NODE  $QE/pw.x < $inp > $out
exit
