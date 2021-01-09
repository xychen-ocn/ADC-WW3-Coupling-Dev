# ADC-WW3-Coupling-Dev
This repository stores the ADC-WW3-HBL-NEMS code in active developement. This work is a collaborative effort between URI/GSO and our NOAA partners. 
The coupling between ADCIRC and WW3 is done by a flexible application based on the Earth System Modeling Framework (ESMF) with NUOPC layer. This coupling application is developed as part of the NOAA Coastal Act coupling project. 

## Structure of this repository:
### Source Code 
The source code comes from the [ADC-WW3-NWM-NEMS](https://github.com/noaa-ocs-modeling/ADC-WW3-NWM-NEMS) repository. 

### Benchmark Case
In this folder, I plan to provide a prototype case where ADCIRC and WW3 is coupled by the sea-state dependent wind stress in addition to the traditional wave radiation stress. (Not yet available..)


### Test Cases:
Located here are some simple test cases I have run (or will run) to identify issues in the couple system.  
#### 1. Check the 1dt coupling time lag between two model components 
   | Case Info |                                                          |
   |-----------|:--------------------------------------------------------:|
   |  Mesh:    | Shinnecock                                               |
   |  Wind:    | Uniform northeasterly onshore wind increases with time   |
   |  RunType: | atm2wav2ocn                                              |
   
   All the export and import fields from each model component are stored in a folder named `output_dumped_by_caps`. 
   Note that the assoicated [ATM cap](../blob/SrcCode/ATMESH/adc_cap.F90) and [ADCIRC cap](../blob/SrcCode/ADCIRC/cpl/nuopc/adc_cap.F90) are updated from the [source](https://github.com/noaa-ocs-modeling/ADC-WW3-NWM-NEMS) so the export variables are dumped correctly at current time (noted in the code as well). In the [WW3 cap ](../SrcCode/WW3/model/ftn)(`wmesmfmd.ftn`), minor updated is done to change how the two wind data arrays hold wind information. Time stamp has been added to the wmesmf_import_xxxx_timestamp.nc file to indicate the output time associated with the last data record in the netCDF file.  
   
   
   

   



 
 


