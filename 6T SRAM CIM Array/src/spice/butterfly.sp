.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
VVDD VDD 0 1.8
VGND GND 0 0 
VVDD C 0 
VA0 A0 0 DC 0
.dc VD C 1.8 0
.dc F  E 1.8 0
.dc VA0 0 1.8 0.01
.print DC V(C) V(F)
************************************************************************
* Library Name: SRAM
* Cell Name:    inv1
* View Name:    schematic
************************************************************************

*.SUBCKT inv1 A GND VDD Y
*.PININFO A:B GND:B VDD:B Y:B
MNM0 Y A GND GND nch_tn W=1.485u L=180n M=1.0
MPM0 Y A VDD VDD pch_tn W=450n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM
* Cell Name:    6T_SRAM-DC1
* View Name:    schematic
************************************************************************

.SUBCKT 6T_SRAM-DC1 A0 B Bbar C D E F GND VDD
*.PININFO A0:B B:B Bbar:B C:B D:B E:B F:B GND:B VDD:B
XI1 E GND VDD C / inv1
XI0 D GND VDD F / inv1
MNM3 C A0 Bbar Bbar nch_tn W=675n L=180n M=1.0
MNM2 F A0 B B nch_tn W=675n L=180n M=1.0
.END

