#!/bin/bash
#FLUX: --job-name=KCARTA_DRIVER
#FLUX: --queue=high_mem
#FLUX: -t=7140
#FLUX: --urgency=16

if [ $# -gt 0 ]; then
  echo "Your command line contains $# arguments"
elif [ $# -eq 0 ]; then
  echo "Your command line contains no arguments"
fi
if [[ "$1" -eq "" ]]; then
  # this is individual clear/cld runs
  matlab -nodisplay -r "clust_do_kcarta_driver; exit"
elif [[ "$1" -eq "1" ]]; then
  # this is individual clear/cld runs
  matlab -nodisplay -r "clust_do_kcarta_driver; exit"
elif [[ "$1" -eq "2" ]]; then
  # this is for looped clear runs
  matlab -nodisplay -r "iaChunkSize = 30; clust_do_kcarta_driver_loop; exit"
elif [[ "$1" -eq "3" ]]; then
  # this is for looped allsky runs
  matlab -nodisplay -r "iaChunkSize = 15; clust_do_kcarta_driver_loop; exit"
elif [[ "$1" -eq "4" ]]; then
  # this is for clear/cloud filelist
  matlab -nodisplay -r "clust_do_kcarta_driver_filelist; exit"
elif [[ "$1" -eq "5" ]]; then
  # this is for clear/cloud looped filelist
  matlab -nodisplay -r "iaChunkSize = 15; clust_do_kcarta_driver_filelist_loop; exit"
elif [[ "$1" -eq "6" ]]; then
  # this is for all bands
  matlab -nodisplay -r "cluster_loop_allkcartabands; exit"
elif [[ "$1" -eq "7" ]]; then
  # this is for all profiles inside a rtp file, but can do many rtp files eg
  # use_this_rtp = '/asl/s1/sergio/MakeAvgProfs2002_2020_startSept2002/16dayAvgLatBin32/all12monthavg_T_WV_grid_latbin_32_lonbin_12.rtp'; %% 25 T x WV grids
  matlab -nodisplay -r "cluster_loop_allprofiles_onefile; exit"
elif [[ "$1" -eq "8" ]]; then
  # this loops over H2008,H2012,H2016
  matlab -nodisplay -r "clust_do_kcarta_driver_allHITRAN; exit"
elif [[ "$1" -eq "9" ]]; then
  # this loops over 25 cm-1 chunks for DISORT, if you only have a handful of profiles this is fast since it breaks profiles/freqchunks for separate proceeors
  if [[ $# -eq 1 ]]; then
    matlab -nodisplay -r "clust_do_kcarta_driver_DISORT(1); exit"
  elif [[ $# -eq 2 ]]; then
    matlab -nodisplay -r "clust_do_kcarta_driver_DISORT($2); exit"
  fi
elif [[ "$1" -eq "10" ]]; then
  # this is individual entire spectrum DISORT runs, 90+ minutes each, this is slow but straightforward
  matlab -nodisplay -r "clust_do_kcarta_driver_DISORT_wholespectrum; exit"
elif [[ "$1" -eq "11" ]]; then
  # this loops over 25 cm-1 chunks for DISORT, this is complicated
  if [[ $# -eq 1 ]]; then
    matlab -nodisplay -r "iaChunkSize = 50; clust_do_kcarta_driver_DISORT_loop(1,iaChunkSize); exit"
  elif [[ $# -eq 2 ]]; then
    matlab -nodisplay -r "iaChunkSize = 50; clust_do_kcarta_driver_DISORT_loop($2,iaChunkSize); exit"
  fi
fi
