#!/bin/bash
#FLUX: --job-name=sticky-chip-2854
#FLUX: -c=2
#FLUX: --queue=research
#FLUX: -t=86400
#FLUX: --priority=16

module load nvidia/cuda/11.3.1
module load mpi/openmpi/4.1.1
mpirun -np 3 ./demo_VEH_Cosim_WheelRig \
--terrain_specfile="../data/vehicle/cosim/terrain/granular_gpu_10mm_grouser.json" \
--tire_specfile="../data/vehicle/hmmwv/tire/Curiosity_wheel_grouser.json" \
--sim_time=40.0 \
--settling_time=0.01 \
--step_size=0.000025 \
--base_vel=0.192 \
--total_mass=18.5 \
--actuation_type=SET_ANG_VEL \
--output_fps=20 \
--render_fps=20 \
--threads_tire=1 \
--threads_terrain=1 \
--slip=0.0 \
--suffix="_coh=2.0_slip=0.0"
