#!/bin/bash
#FLUX: --job-name=Snudda
#FLUX: -N=2
#FLUX: -n=256
#FLUX: -c=2
#FLUX: --queue=main
#FLUX: -t=3540
#FLUX: --urgency=16

export IPNWORKERS='$NWORKERS'
export IPYTHONDIR='/cfs/klemming/scratch/${USER:0:1}/$USER/.ipython'
export IPYTHON_PROFILE='default'
export FI_CXI_DEFAULT_VNI='$(od -vAn -N4 -tu < /dev/urandom)'

module load snic-env
ulimit -s unlimited
let NWORKERS="100"
export IPNWORKERS=$NWORKERS
export IPYTHONDIR="/cfs/klemming/scratch/${USER:0:1}/$USER/.ipython"
rm -r $IPYTHONDIR
export IPYTHON_PROFILE=default
source $HOME/Snudda/snudda_env/bin/activate
export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
srun -n 1 -N 1 -c 2 --exact --overlap --mem=0 ./ipcontroller_new.sh &
echo ">>> waiting 60s for controller to start"
sleep 60 
CONTROLLERIP=$(<controller_ip.txt)
echo ">>> starting ${IPNWORKERS} engines "
export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
srun -n ${IPNWORKERS} -c 2 -N ${SLURM_JOB_NUM_NODES} --exact --overlap --mem=0 ipengine \
--location=${CONTROLLERIP} --profile=${IPYTHON_PROFILE} --mpi \
--ipython-dir=${IPYTHONDIR}  --timeout=30.0 c.EngineFactory.max_heartbeat_misses=10  c.MPI.use='mpi4py' \
1> ipe_${SLURM_JOBID}.out 2> ipe_${SLURM_JOBID}.err &
echo ">>> waiting 60s for engines to start"
sleep 30
export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
srun -n 1 -N 1 --exact --overlap --mem=0 ./Dardel_runSnudda_inside.sh
echo " "
echo "JOB END "`date` start_time_network_connect.txt
wait
