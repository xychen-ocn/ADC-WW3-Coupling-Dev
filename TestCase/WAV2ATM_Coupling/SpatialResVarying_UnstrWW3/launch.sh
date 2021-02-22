#!/bin/bash --login

#SBATCH --constraint=hatteras
#SBATCH --job-name=test_wav2atm
#SBATCH -p batch
#SBATCH --time=72:00:00
#SBATCH -n 51
#SBATCH --mem-per-cpu=5GB
#SBATCH --mail-user=xychen@uri.edu
#SBATCH --mail-type=ALL
#SBATCH --output=wav2atm_testSSD.out
#SBATCH --error=wav2atm_testSSD.err


NEMSROOT=/projects/ees/dhs-crc/xychen/ADC-WW3-HBL-NEMS
NEMSexe=${NEMSROOT}/NEMS/exe
adcexe=${NEMSROOT}/ADCIRC/work
ww3exe=${NEMSROOT}/WW3/model/exe
# modify work directory accordingly
runtype=atm2wav2ocn
workdir=`pwd`
np_adc=0
np_ww3=50
np_atm=1

# complete the following model run info:
totpets=$(( ${np_adc} + ${np_ww3} + ${np_atm} ))
echo totpets=$totpets
styear=2017
stmon=11
stday=24
sthr=1
stmin=0
stsec=0
nhr=120.0

if [[ ! -d $workdir ]]; then
   mkdir -p $workdir
fi
# enter work directory:
cd ${workdir}
rm -f PET*.*LogFile
rm -f wmesmf*.nc
rm -f field_*.nc
rm -f weightmatrix*.nc

${ww3exe}/ww3_grid >grid.out
ln -s mod_def.ww3 mod_def.ADCIRC
ln -s mod_def.ww3 mod_def.points


# adcprep:
#${adcexe}/adcprep --np ${np_adc} --partmesh
#${adcexe}/adcprep --np ${np_adc} --prepall 

#

## ================ launch NEMS.x ============== ##
ln -s ${NEMSexe}/NEMS.x .
mpirun -np 51 NEMS.x


## =============== Retrieve information from WW3 ==================== ##
if [[ 1 -eq 0 ]]; then
  ln -s out_grd.ADCIRC out_grd.ww3
  ${ww3exe}/ww3_ounf >ounf.out
fi
