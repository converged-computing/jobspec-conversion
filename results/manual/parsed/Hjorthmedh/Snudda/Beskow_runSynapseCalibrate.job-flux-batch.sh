#!/bin/bash
#FLUX: --job-name=snudda_simulate
#FLUX: -t=3540
#FLUX: --urgency=16

export CRAYPE_LINK_TYPE='dynamic'
export CRAY_ROOTFS='DSL'

HOME=/cfs/klemming/nobackup/"${USER:0:1}"/$USER/Snudda
module swap PrgEnv-cray PrgEnv-intel/6.0.5
module load craype-haswell
module unload cray-libsci atp
module load neuron/7.5-py37
export CRAYPE_LINK_TYPE=dynamic
export CRAY_ROOTFS=DSL
rm -r x86_64
nrnivmodl cellspecs/mechanisms
SIMNAME=networks/BeskowSynapseCalibration.${SLURM_JOBID}
python3 snudda_init_custom.py $simName
./snudda.py place $simName 
./snudda.py detect $simName
./snudda.py prune $simName
python3 snudda_cut.py $simName/network-pruned-synapses.hdf5 "abs(z)<100e-6"
srun -n $N_WORKERS /cfs/klemming/nobackup/"${USER:0:1}"/$USER/Snudda/x86_64/special -mpi -python snudda/utils/network_pair_recording_simulation.py run $simName/network-cut-slice.hdf5 dSPN iSPN
srun -n $N_WORKERS /cfs/klemming/nobackup/"${USER:0:1}"/$USER/Snudda/x86_64/special -mpi -python snudda/utils/network_pair_recording_simulation.py run $simName/network-cut-slice.hdf5 iSPN dSPN
srun -n $N_WORKERS /cfs/klemming/nobackup/"${USER:0:1}"/$USER/Snudda/x86_64/special -mpi -python snudda/utils/network_pair_recording_simulation.py run $simName/network-cut-slice.hdf5 FS dSPN
srun -n $N_WORKERS /cfs/klemming/nobackup/"${USER:0:1}"/$USER/Snudda/x86_64/special -mpi -python snudda/utils/network_pair_recording_simulation.py run $simName/network-cut-slice.hdf5 FS iSPN
