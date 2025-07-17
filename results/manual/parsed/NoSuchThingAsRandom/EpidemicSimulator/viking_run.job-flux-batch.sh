#!/bin/bash
#FLUX: --job-name=EpidemicSimulatorTesting
#FLUX: -c=32
#FLUX: -t=43200
#FLUX: --urgency=16

export RUST_LOG='warn,visualisation,osm_data=trace,sim=trace,run=debug,load_census_data=trace,voronoice=off'
export RUST_BACKTRACE='1'

echo My working directory is `pwd`
echo Running job on host:
echo -e '\t'`hostname` at `date`
echo $SLURM_CPUS_ON_NODE CPU cores available
echo
module load lang/Rust/1.54.0-GCCcore-11.2.0
export RUST_LOG="warn,visualisation,osm_data=trace,sim=trace,run=debug,load_census_data=trace,voronoice=off"
export RUST_BACKTRACE=1
echo "Log level: $RUST_LOG"
cargo run --release -- 1946157112TYPE299 --directory=data --grid-size=250000 --simulate  2>&1 | tee logs/viking_logs/v1.6/1946157112TYPE299.log
cargo run --release -- 2013265923TYPE299 --directory=data --grid-size=250000 --simulate  2>&1 | tee logs/viking_logs/v1.6/2013265923TYPE299.log
echo Job completed at `date`
