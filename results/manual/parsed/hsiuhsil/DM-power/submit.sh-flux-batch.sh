#!/bin/bash
#FLUX: --job-name=mpi_job
#FLUX: -N=4
#FLUX: -t=10800
#FLUX: --priority=16

cd /scratch/p/pen/hsiuhsil/DM_power
mpirun -np 100 python DM_power.py -bw 200 -f0 550 -nchan 2048 -dt 0.00032768 -dm_start -2 -dm_end 2 -dm_steps 51 -trials 100 -rescaled False  -intensity_bootstrap True -intensity_file "/scratch/p/pen/hsiuhsil/DM_power/noiseamp_files/burst_11_noiseamp_0.npy" -save_path "/scratch/p/pen/hsiuhsil/DM_power/noiseamp_files/burst_11_noiseamp_0_bootstrap_test.npz"
mpirun -np 100 python DM_power.py -bw 200 -f0 550 -nchan 2048 -dt 0.00008192 -dm_start -2 -dm_end 2 -dm_steps 51 -trials 100 -rescaled False  -intensity_bootstrap True -intensity_file "/scratch/p/pen/hsiuhsil/DM_power/noiseamp_files/burst_100_noiseamp_0.npy" -save_path "/scratch/p/pen/hsiuhsil/DM_power/noiseamp_files/burst_100_noiseamp_0_bootstrap_test.npz"
mpirun -np 100 python DM_power.py -bw 200 -f0 550 -nchan 2048 -dt 0.00032768 -dm_start -2 -dm_end 2 -dm_steps 51 -trials 100 -rescaled False  -intensity_sim True -sim_width 64 -sim_mu 0 -sim_sigma 0.25 -save_path "/scratch/p/pen/hsiuhsil/DM_power/sim_gau_pulses/sim1_individual_test.npz"
mpirun -np 100 python DM_power.py -bw 200 -f0 550 -nchan 2048 -dt 0.00032768 -dm_start -2 -dm_end 2 -dm_steps 51 -trials 100 -rescaled False  -intensity_bootstrap True -intensity_file "/scratch/p/pen/hsiuhsil/DM_power/sim_gau_pulses/sim1_single_profile.npy" -save_path "/scratch/p/pen/hsiuhsil/DM_power/sim_gau_pulses/sim1_bootstrap_test.npz"
mpirun -np 100 python  DM_phase_test.py -data_path '/scratch/p/pen/hsiuhsil/DM_power/sim_gau_pulses/sim3_individual_test.npz' -save_path '/scratch/p/pen/hsiuhsil/DM_power/sim_gau_pulses/DM_phase_sim3_individual.npz'
