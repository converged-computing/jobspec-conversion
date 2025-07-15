#!/bin/bash
#FLUX: --job-name=crunchy-dog-3434
#FLUX: -c=2
#FLUX: --queue=sbel
#FLUX: -t=259200
#FLUX: --priority=16

module load gcc/9.2.0
module load cmake/3.18.1
module load cuda/11.1
module load glfw/3.3.2
module load intel/mkl/2019_U2
module load openmpi/2.1.1
mpirun -np 2 ./demo_VEH_Cosim_WheelRig \
--terrain_specfile="../data/vehicle/cosim/granular_gpu.json" \
--tire_specfile="../data/vehicle/hmmwv/tire/RigidMeshCylinderWheel.json" \
--sim_time=20.0 \
--settling_time=1.0 \
--step_size=0.000025 \
--base_vel=0.3 \
--total_mass=13.25 \
--actuation_type=SET_ANG_VEL \
--output_fps=20 \
--render_fps=20 \
--threads_rig=1 \
--threads_terrain=1 \
--slip=0.7 \
--suffix="_slip=0.7_ANG_HCP1.01_Mu1.5555"
