#!/bin/bash
#FLUX: --job-name=Extract driving data from summer 2021 drives
#FLUX: --queue=main
#FLUX: -t=72000
#FLUX: --urgency=16

BAGS=(
    '2021-05-20-12-36-10_e2e_sulaoja_20_30.bag' \
    '2021-05-20-12-43-17_e2e_sulaoja_20_30.bag' \
    '2021-05-20-12-51-29_e2e_sulaoja_20_30.bag' \
    '2021-05-20-13-44-06_e2e_sulaoja_10_10.bag' \
    '2021-05-20-13-51-21_e2e_sulaoja_10_10.bag' \
    '2021-05-20-13-59-00_e2e_sulaoja_10_10.bag' \
    '2021-05-28-15-07-56_e2e_sulaoja_20_30.bag' \
    '2021-05-28-15-17-19_e2e_sulaoja_20_30.bag' \
    '2021-06-09-13-14-51_e2e_rec_ss2.bag' \
    '2021-06-09-13-55-03_e2e_rec_ss2_backwards.bag' \
    '2021-06-09-14-58-11_e2e_rec_ss3.bag' \
    '2021-06-09-15-42-05_e2e_rec_ss3_backwards.bag' \
    '2021-06-09-16-24-59_e2e_rec_ss13.bag' \
    '2021-06-09-16-50-22_e2e_rec_ss13_backwards.bag' \
    '2021-06-10-12-59-59_e2e_ss4.bag' \
    '2021-06-10-13-19-22_e2e_ss4_backwards.bag' \
    '2021-06-10-13-51-34_e2e_ss12.bag' \
    '2021-06-10-14-02-24_e2e_ss12_backwards.bag' \
    '2021-06-10-14-44-24_e2e_ss3_backwards.bag' \
    '2021-06-10-15-03-16_e2e_ss3_backwards.bag' \
    '2021-06-14-11-08-19_e2e_rec_ss14.bag' \
    '2021-06-14-11-22-05_e2e_rec_ss14.bag' \
    '2021-06-14-11-43-48_e2e_rec_ss14_backwards.bag' \
    '2021-09-24-11-19-25_e2e_rec_ss10.bag' \
    '2021-09-24-11-40-24_e2e_rec_ss10_2.bag' \
    '2021-09-24-12-02-32_e2e_rec_ss10_3.bag' \
    '2021-09-24-12-21-20_e2e_rec_ss10_backwards.bag' \
    '2021-09-24-13-39-38_e2e_rec_ss11.bag' \
    '2021-09-30-13-57-00_e2e_rec_ss14.bag' \
    '2021-09-30-15-03-37_e2e_ss14_from_half_way.bag' \
    '2021-09-30-15-20-14_e2e_ss14_backwards.bag' \
    '2021-09-30-15-56-59_e2e_ss14_attempt_2.bag' \
    '2021-10-07-11-05-13_e2e_rec_ss3.bag' \
    '2021-10-07-11-44-52_e2e_rec_ss3_backwards.bag' \
    '2021-10-07-12-54-17_e2e_rec_ss4.bag' \
    '2021-10-07-13-22-35_e2e_rec_ss4_backwards.bag' \
    '2021-10-11-16-06-44_e2e_rec_ss2.bag' \
    '2021-10-11-17-10-23_e2e_rec_last_part.bag' \
    '2021-10-11-17-14-40_e2e_rec_backwards.bag' \
    '2021-10-11-17-20-12_e2e_rec_backwards.bag' \
    '2021-10-20-14-55-47_e2e_rec_vastse_ss13_17.bag' \
    '2021-10-20-13-57-51_e2e_rec_neeruti_ss19_22.bag' \
    '2021-10-20-14-15-07_e2e_rec_neeruti_ss19_22_back.bag' \
    '2021-10-25-17-31-48_e2e_rec_ss2_arula.bag' \
    '2021-10-25-17-06-34_e2e_rec_ss2_arula_back.bag' \
    '2021-11-08-11-24-44_e2e_rec_ss12_raanitsa.bag' \
    '2021-11-08-12-08-40_e2e_rec_ss12_raanitsa_backward.bag' \
    '2021-05-28-15-19-48_e2e_sulaoja_20_30.bag' \
    '2021-06-07-14-20-07_e2e_rec_ss6.bag' \
    '2021-06-07-14-06-31_e2e_rec_ss6.bag' \
    '2021-06-07-14-09-18_e2e_rec_ss6.bag' \
    '2021-06-07-14-36-16_e2e_rec_ss6.bag' \
    '2021-09-24-14-03-45_e2e_rec_ss11_backwards.bag' \
    '2021-10-26-10-49-06_e2e_rec_ss20_elva.bag' \
    '2021-10-26-11-08-59_e2e_rec_ss20_elva_back.bag' \
    '2021-10-20-15-11-29_e2e_rec_vastse_ss13_17_back.bag' \
    '2021-10-11-14-50-59_e2e_rec_vahi.bag' \
    '2021-10-14-13-08-51_e2e_rec_vahi_backwards.bag' \
    '2022-06-10-13-03-20_e2e_elva_backward.bag' \
    '2022-06-10-13-23-01_e2e_elva_forward.bag'
    )
module load any/python/3.8.3-conda
source activate ros
cd /gpfs/space/home/rometaid/nvidia-e2e/data_extract
srun ./extract_rocket_wide.sh ${BAGS[$SLURM_ARRAY_TASK_ID]}  /gpfs/space/projects/Bolt/dataset-new-wide/summer2021
