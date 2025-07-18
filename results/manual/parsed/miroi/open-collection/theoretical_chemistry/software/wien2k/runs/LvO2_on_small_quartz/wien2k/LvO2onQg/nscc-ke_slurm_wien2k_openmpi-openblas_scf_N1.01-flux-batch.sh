#!/bin/bash
#FLUX: --job-name=LvO2@Qgp
#FLUX: -n=8
#FLUX: --queue=short
#FLUX: -t=18000
#FLUX: --urgency=16

export WIEN2k='/lustre/home/ilias/work/qch/software/wien2k/WIEN2k_23.2_gnu_openmpi_openblas'
export WIENROOT='$WIEN2k'
export PATH='$WIENROOT:$PATH'
export SCRATCH='/lustre/home/ilias/scratch/$SCR/$case'

echo -e "Job user is $SLURM_JOB_USER and his job $SLURM_JOB_NAME has assigned ID $SLURM_JOBID"
echo -e "This job was submitted from the computer $SLURM_SUBMIT_HOST"
echo -e "and from the home directory:"
echo $SLURM_SUBMIT_DIR
echo
echo -e "It is running on the cluster compute node:"
echo $SLURM_CLUSTER_NAME
echo -e "and is employing $SLURM_JOB_NUM_NODES node/nodes:"
echo $SLURM_JOB_NODELIST
echo -e "\nJob partition is $SLURM_JOB_PARTITION \n"
echo -e "The job requests SLURM_NTASKS=$SLURM_NTASKS."
echo -e "\nModules loading:"
module use /lustre/home/utils/easybuild_old/modules/all
module purge
module load FFTW.MPI/3.3.10-gompi-2022a
module load ScaLAPACK/2.2.0-gompi-2022a-fb
module load ELPA/2021.11.001-foss-2022a
echo -e "\n All loaded modules, module list:";module list
echo -e "\n Check of compilers and libraries:"
echo -e "\n tcsh:"
which tcsh; tcsh --version
echo -e "\n GNU OpenMPI:"
which mpif90; mpif90 --version
which mpirun; mpirun --version
echo -e "\n OpenBLAS library:"; ls /lustre/home/utils/easybuild_old/software/OpenBLAS/0.3.20-GCC-11.3.0/lib
echo -e "\n FFTW3 library:";ls /lustre/home/utils/easybuild_old/software/FFTW.MPI/3.3.10-gompi-2022a/lib
echo -e "\n SCALAPACK library:"; ls /lustre/home/utils/easybuild_old/software/ScaLAPACK/2.2.0-gompi-2022a-fb/lib
echo -e "\n ELPA library:"; ls /lustre/home/utils/easybuild_old/software/ELPA/2021.11.001-foss-2022a/lib
echo -e "\n Running on host `hostname`"
echo -e "Time is `date` \n"
echo -e "The node's CPU \c"; cat /proc/cpuinfo | grep 'model name' | uniq
NPROCS=`cat /proc/cpuinfo | grep processor | wc -l`
echo "This node has total $NPROCS CPUs available for an EXCLUSIVE job."
echo "SLURM_CPUS_ON_NODE=$SLURM_CPUS_ON_NODE"
echo "SLURM_NTASKS_PER_SOCKET=$SLURM_NTASKS_PER_SOCKET"
echo "SLURM_NTASKS_PER_NODE=$SLURM_NTASKS_PER_NODE"
echo "SLURM_NTASKS_PER_CORE=$SLURM_NTASKS_PER_CORE"
echo "SLURM_PARTITION=$SLURM_PARTITION"
echo "SLURM_MEM_PER_NODE=$SLURM_MEM_PER_NODE"
echo -e "\n The total memory at the node (in GB)"
free -t -g
echo -e "\n"
export WIEN2k=/lustre/home/ilias/work/qch/software/wien2k/WIEN2k_23.2_gnu_openmpi_openblas
export WIENROOT=$WIEN2k
export PATH=$WIENROOT:$PATH
echo -e "\n WIENROOT=$WIENROOT added to the PATH variable, PATH=$PATH"
       case=LvO2onQg
SCR=Wien2k_23.2_job.$SLURM_JOB_PARTITION.N$SLURM_JOB_NUM_NODES.n$SLURM_NTASKS.jid$SLURM_JOBID
export SCRATCH=/lustre/home/ilias/scratch/$SCR/$case
echo -e "\nCreating scratch directory, SCRATCH=$SCRATCH"
mkdir -p $SCRATCH
cd $SCRATCH
echo -e "\n I am in  the \$SCRATCH directrory, pwd="; pwd
echo -e "\n ldd $WIEN2k/dstart_mpi :"
ldd $WIEN2k/dstart_mpi
echo -e "\n ldd $WIEN2k/lapw0_mpi :"
ldd $WIEN2k/lapw0_mpi
echo -e "\n ldd $WIEN2k/lapw1c_mpi :"
ldd $WIEN2k/lapw1c_mpi
echo -e "\n ldd $WIEN2k/lapw2c_mpi :"
ldd $WIEN2k/lapw2c_mpi
 cp  $SLURM_SUBMIT_DIR/$case.struct_SAVED    $PWD/$case.struct
 cp  $SLURM_SUBMIT_DIR/$case.in0_SAVED       $PWD/$case.in0
 cp  $SLURM_SUBMIT_DIR/$case.inc_SAVED       $PWD/$case.inc
 cp  $SLURM_SUBMIT_DIR/$case.in1c_SAVED      $PWD/$case.in1c
 cp  $SLURM_SUBMIT_DIR/$case.in2c_SAVED      $PWD/$case.in2c
 cp  $SLURM_SUBMIT_DIR/$case.inm_SAVED       $PWD/$case.inm
 cp  $SLURM_SUBMIT_DIR/$case.rsp_SAVED       $PWD/$case.rsp
 cp  $SLURM_SUBMIT_DIR/$case.vsp_SAVED       $PWD/$case.vsp
 cp  $SLURM_SUBMIT_DIR/$case.klist_SAVED     $PWD/$case.klist
 cp  $SLURM_SUBMIT_DIR/$case.kgen_SAVED      $PWD/$case.kgen
echo '# nodes for parallel job ' > $PWD/.machines
echo 'omp_global:1 ' >> $PWD/.machines
echo "1:localhost:$SLURM_NTASKS" >>  $PWD/.machines
echo -e "\n number of hosts in .machines, SLURM_NTASKS=$SLURM_NTASKS"
echo -e "\n content of file $PWD/.machines:"; cat $PWD/.machines
echo -e "\n running 'x -p dstart' :"
x -p dstart
echo -e "\n running 'run_lapw -p -ec 0.00001 -i 1000 -NI'"
 #run_lapw  -ec 0.0001 -NI
run_lapw -p -ec 0.00001 -i 100 -NI
 # now SO step
 #echo -e "\n Now SO step:"
 #init_so_lapw
 #run_lapw -so
 cat ":log"
 echo -e "\n Finished; check for ':ENE' in outputs. \n"
 echo -e "\n List of files in $SCRATCH :"; ls -lt $SCRATCH/*
 #echo -e "\n Copying output* files to home directory:"
 #cp $PWD/$case.output*  $SLURM_SUBMIT_DIR/.
exit
