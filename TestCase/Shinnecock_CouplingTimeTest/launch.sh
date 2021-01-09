#!/bin/bash --login

# Contributors: Andre van der Westhuysen
#
# ----------------------------------------------------------- 
# ------------- Program Description and Details ------------- 
# ----------------------------------------------------------- 
#
# Job Card to set the resources required for a NSEM run
#
# ----------------------------------------------------------- 

#SBATCH --constraint=hatteras
#SBATCH --job-name=shin_test_timeseq
#SBATCH -p batch
#SBATCH --time=12:00:00
#SBATCH --nodes=13
##SBATCH --ntasks-per-node=7
#SBATCH --mail-user=xychen@uri.edu
#SBATCH --mail-type=ALL
#SBATCH --output=test_timestepping.out
#SBATCH --error=test_timestepping.err

NEMSexe=/home/xychen/ADC-WW3-NWM-NEMS/NEMS/exe_ww3/new_tests
#NEMSexe=/home/xychen/ADC-WW3-Coupling-Dev/SrcCode/NEMS/exe/ww3_PDLIB
ADCexe=/home/xychen/ADC-WW3-Coupling-Dev/SrcCode/ADCIRC/work

rm -f field_*.nc
rm -f wmesmf*.nc
np_adc=11
${ADCexe}/adcprep --np ${np_adc} --partmesh
${ADCexe}/adcprep --np ${np_adc} --prepall 

#cp ${NEMSexe}/NEMS.x NEMS_PDLIB_updated_unstrucatmesh_ww3captest_v2.x 
#ln -s ${NEMSexe}/NEMS_PDLIB_index_corrected.x .
rm -f PET*.ESMF*
mpirun -np 13 NEMS.x 

