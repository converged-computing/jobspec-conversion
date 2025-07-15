#!/bin/bash
#FLUX: --job-name=delicious-toaster-8851
#FLUX: --urgency=16

INBASE="/mnt/home/usteinwandel/ceph/dm_sims/doug/run_4096_G4/output/"
OUTBASE="$HOME/ceph/rockstar_out"
STARTING_SNAP=2
NUM_SNAPS=5
NUM_BLOCKS=1024  # number of files per snapshot
NUM_READERS_PER_NODE=32
NUM_READERS=$((NUM_READERS_PER_NODE * SLURM_NNODES))
ml hdf5
rockstar=/mnt/home/drennehan/local/bin/rockstar_dm_only_gadget4
mkdir -p $OUTBASE
rm -f $OUTBASE/auto-rockstar.cfg
sed \
    -e "s,RUSTY_NUM_WRITERS,$SLURM_NTASKS,g" \
    -e "s,RUSTY_NUM_READERS,$NUM_READERS,g" \
    -e "s,RUSTY_INBASE,$INBASE,g" \
    -e "s,RUSTY_OUTBASE,$OUTBASE,g" \
    -e "s,RUSTY_NUM_SNAPS,$NUM_SNAPS,g" \
    -e "s,RUSTY_STARTING_SNAP,$STARTING_SNAP,g" \
    -e "s,RUSTY_NUM_BLOCKS,$NUM_BLOCKS,g" \
    rockstar.template.cfg > $OUTBASE/rockstar_input.cfg
$rockstar -c $OUTBASE/rockstar_input.cfg &
while [ ! -f $OUTBASE/auto-rockstar.cfg ]; do sleep 1; done
srun -n $NUM_READERS --ntasks-per-node=$NUM_READERS_PER_NODE --mpi=none --overlap $rockstar -c $OUTBASE/auto-rockstar.cfg  &  # start readers
sleep 5
srun --mpi=none --overlap $rockstar -c $OUTBASE/auto-rockstar.cfg &  # start writers
wait
