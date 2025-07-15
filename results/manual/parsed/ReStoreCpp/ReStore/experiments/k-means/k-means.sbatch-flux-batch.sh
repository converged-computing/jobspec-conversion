#!/bin/bash
#FLUX: --job-name=hanky-kitty-7303
#FLUX: -N=4
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --priority=16

export PMIX_MCA_gds='hash'

REPEATS=(0)
REPLICATION_LEVEL=4
NUM_ITERATIONS=500
NUM_DIMENSIONS=32
NUM_DATA_POINTS=65536
NUM_CENTERS=20
BLOCKS_PER_PERMUTATION_RANGE=4096
SIMULATION_ID="${SIMULATION_ID:-unspecified}"
SEED=0
FAILURE_RATE=0.01
DATA_DIR="$SCRATCH/restore/data/k-means/$SLURM_NTASKS" # Without trailing '/'
OUT_DIR="measurements" # Without trailing '/'
DATA_PREFIX="p-$SLURM_NTASKS.k-$REPLICATION_LEVEL.dp-$NUM_DATA_POINTS" 
export PMIX_MCA_gds=hash
module restore gnu > /dev/null
module list
echo "number of ranks: $SLURM_NTASKS"
echo "replication level: $REPLICATION_LEVEL"
echo "number of iterations: $NUM_ITERATIONS"
echo "number of dimensions: $NUM_DIMENSIONS"
echo "number of clusters (k): $NUM_CENTERS"
echo "number of data points: $NUM_DATA_POINTS"
echo "simultion id: $SIMULATION_ID"
echo "seed: $SEED"
echo "failure rate: $FAILURE_RATE"
echo "blocks per permutation range: $BLOCKS_PER_PERMUTATION_RANGE"
echo "prefix: $DATA_PREFIX"
mkdir -p "$DATA_DIR"
echo -n "Generating data ... "
if [[ ! -f "$DATA_DIR/$DATA_PREFIX.0.data" ]]; then
    mpiexec -n $SLURM_NTASKS \
        ./k-means generate-data                       \
        --num-data-points-per-rank "$NUM_DATA_POINTS" \
        --num-dimensions "$NUM_DIMENSIONS"            \
        --seed "$SEED"                                \
        --output="$DATA_DIR/$DATA_PREFIX"
    echo "done."
else
    echo "using existing data."
fi
for REPEAT_ID in "${REPEATS[@]}"; do
    OUT_PREFIX="$DATA_PREFIX.r-$REPEAT_ID" 
    FAILURE_SIMULATOR_SEED="$((SEED + REPEAT_ID))"
    #  Run k-means with fault-tolerance enabled and simulated failures
    echo -n "Clustering data (fault-tolerance: ON)... "
    mpiexec -n $SLURM_NTASKS \
        ./k-means cluster-data                        \
        --input="$DATA_DIR/$DATA_PREFIX"              \
        --output="$OUT_DIR/ft-on.$OUT_PREFIX"         \
        --num-centers "$NUM_CENTERS"                  \
        --num-iterations "$NUM_ITERATIONS"            \
        --replication-level "$REPLICATION_LEVEL"      \
        --fault-tolerance=true                        \
        --expected-failure-rate "$FAILURE_RATE"       \
        --simulation-id "$SIMULATION_ID"              \
        --repeat-id "$REPEAT_ID"                      \
        --seed "$SEED"                                \
        --blocks-per-permutation-range="$BLOCKS_PER_PERMUTATION_RANGE" \
        --failure-simulator-seed="$FAILURE_SIMULATOR_SEED" \
        --write-assignment=false
    echo "done"
    #  Run k-means with fault-tolerance disabled
    echo -n "Clustering data (fault-tolerance: OFF)... "
    mpiexec -n $SLURM_NTASKS \
        ./k-means cluster-data                        \
        --input="$DATA_DIR/$DATA_PREFIX"              \
        --output="$OUT_DIR/ft-off.$OUT_PREFIX"        \
        --num-centers "$NUM_CENTERS"                  \
        --num-iterations "$NUM_ITERATIONS"            \
        --fault-tolerance=false                       \
        --simulation-id "$SIMULATION_ID"              \
        --repeat-id "$REPEAT_ID"                      \
        --seed "$SEED"                                \
        --blocks-per-permutation-range="$BLOCKS_PER_PERMUTATION_RANGE" \
        --write-assignment=false
    echo "done"
done
