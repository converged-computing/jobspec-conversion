#!/bin/bash
#FLUX: --job-name=h3po4_BHaH
#FLUX: -n=12
#FLUX: --queue=compute
#FLUX: -t=295200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/milias/bin/openmpi-4.0.1_suites/openmpi-4.0.1_Intel14_GNU6.3g++/lib:$LD_LIBRARY_PATH'
export PATH='/home/milias/bin/openmpi-4.0.1_suites/openmpi-4.0.1_Intel14_GNU6.3g++/bin:$PATH'
export PMIX_MCA_gds='hash'
export OMP_NUM_THREADS='1'
export MKL_DYNAMIC='FALSE'
export OMP_DYNAMIC='FALSE'
export MKL_NUM_THREADS='1'
export NWCHEM_EXECUTABLE='/home/milias/Work/qch/software/nwchem_suite/nwchem_master/bin/LINUX64/nwchem'
export TMPDIR='/mnt/local/$USER/SLURMjob-${SLURM_JOBID}'

echo -e "\nRunning on host `hostname -f`"
echo -e "Time is `date` \n"
source /mnt/apps/intel/bin/compilervars.sh intel64
source /mnt/apps/intel/composer_xe_2013_sp1.1.106/mkl/bin/mklvars.sh intel64
echo -e "\n Intel Fortran/C/C++ commercial compilers 2013 with MKL library 2013 activated, PROD_DIR=$PROD_DIR, MKLROOT=$MKLROOT.\n"
source /mnt/apps/pgi/environment.sh
export LD_LIBRARY_PATH=/home/milias/bin/lib64_libnuma:$LD_LIBRARY_PATH  # libnumma for PGI
export PATH=/home/milias/bin/openmpi-4.0.1_suites/openmpi-4.0.1_Intel14_GNU6.3g++/bin:$PATH
export LD_LIBRARY_PATH=/home/milias/bin/openmpi-4.0.1_suites/openmpi-4.0.1_Intel14_GNU6.3g++/lib:$LD_LIBRARY_PATH
export PMIX_MCA_gds=hash
echo -e "PATH, LD_LIBRARY_PATH and PMIX_MCA_gds adjusted for /home/milias/bin/openmpi-4.0.1_suites/openmpi-4.0.1_Intel14_GNU6.3g++"
echo -e "\npython -V \c"; python -V
echo -e "mpif90 ? \c"; which mpif90; mpif90 --version
echo -e "mpicc ? \c"; which mpicc; mpicc --version
echo -e "mpirun ? \c"; which mpirun; mpirun --version
echo Job user is $SLURM_JOB_USER and his job $SLURM_JOB_NAME has assigned ID $SLURM_JOBID
echo This job was submitted from the computer $SLURM_SUBMIT_HOST
echo and from the home directory:
echo $SLURM_SUBMIT_DIR
echo
echo It is running on the cluster compute node:
echo $SLURM_CLUSTER_NAME
echo and is employing $SLURM_JOB_NUM_NODES node/nodes:
echo $SLURM_JOB_NODELIST
echo -e "  Job partition is $SLURM_JOB_PARTITION \n"
echo -e "The node's CPU \c"; cat /proc/cpuinfo | grep 'model name' | uniq
NPROCS=`cat /proc/cpuinfo | grep processor | wc -l`
echo "This node has total $NPROCS CPUs available for an EXCLUSIVE job on this node."
echo "This node has $SLURM_CPUS_ON_NODE CPUs allocated for this SLURM job."
echo -e "\n The job requests SLURM_MEM_PER_NODE=$SLURM_MEM_PER_NODE memory."
echo -e "\n The total memory at the node (in GB)"
free -t -g
echo -e "\n"
echo -e "\nMy PATH=$PATH"
echo -e "My LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
export OMP_NUM_THREADS=1
export MKL_DYNAMIC="FALSE"
export OMP_DYNAMIC="FALSE"
unset MKL_NUM_THREADS
export MKL_NUM_THREADS=1
echo -e "\nUpdated MKL_NUM_THREADS=$MKL_NUM_THREADS"
echo -e "MKL_DYNAMIC=$MKL_DYNAMIC"
echo -e "OMP_NUM_THREADS=$OMP_NUM_THREADS"
echo -e "OMP_DYNAMIC=$OMP_DYNAMIC"
export NWCHEM_EXECUTABLE=/home/milias/Work/qch/software/nwchem_suite/nwchem_master/bin/LINUX64/nwchem
echo -e "\nNWCHEM executable linked libraries, ldd $NWCHEM_EXECUTABLE"
ldd $NWCHEM_EXECUTABLE
export TMPDIR=/mnt/local/$USER/SLURMjob-${SLURM_JOBID}
echo -e "\n Noide's local scratch directory, TMPDIR=$TMPDIR";
echo -e "Size of this local scratch dir, df -h /mnt/local/$USER/:";df -h /mnt/local/$USER
mkdir $TMPDIR
cd $TMPDIR
echo -e "\nI am in working dir, TMPDIR=$TMPDIR"
echo -e "For control pwd=\c";pwd
echo -e "The local home directory with NWChem input file, SLURM_SUBMIT_DIR=${SLURM_SUBMIT_DIR}"
cp ${SLURM_SUBMIT_DIR}/phosporic_acid.geopt_freq_nmrshield_pbe0_tz2p_good_cosmo-chcl3_converged_geometry.xyz   $TMPDIR/.
project=h3po4.nmrshield_beckehandh_nmr-dkh-tz2p-decontr-expl_cosmo-chcl3
echo -e "\n Launching NWChem run of project=$project"
mpirun -np  $SLURM_CPUS_ON_NODE $NWCHEM_EXECUTABLE  ${SLURM_SUBMIT_DIR}/$project.nw  > ${SLURM_SUBMIT_DIR}/$project.${SLURM_JOBID}.out
echo -e "\n Working files remained in scratch dir $TMPDIR:"
ls -lt $TMPDIR 
du -h -s $TMPDIR
cd .. ; echo -e "just for control -  pwd=\c";pwd
echo -e "\nDeleting scratch directory $TMPDIR: "; /bin/rm -r $TMPDIR
echo -e "\n Afterwards, content of ls -lt /mnt/local/$USER :"; ls -lt /mnt/local/$USER
echo -e "\n Time of finishing job is `date` \n"
echo -e "\n returning to ${SLURM_SUBMIT_DIR}"
cd ${SLURM_SUBMIT_DIR}
ls -lt
exit 0
