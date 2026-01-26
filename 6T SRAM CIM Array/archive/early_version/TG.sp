.title
.option post
.temp 85
.lib "/home/IC/CYJ2025/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: TG
* View Name:     schematic
* Netlisted on:  May 22 10:21:04 2025
************************************************************************

*.BIPOLAR
*.RESI = 2000 
*.RESVAL
*.CAPVAL
*.DIOPERI
*.DIOAREA
*.EQUATION
*.SCALE METER
*.MEGA
.PARAM



************************************************************************
* Library Name: Test
* Cell Name:    inv
* View Name:    schematic
************************************************************************

.SUBCKT inv GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=220n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    TG
* View Name:    schematic
************************************************************************

.SUBCKT TG GND VDD data data_s data_shift sel sel_b
*.PININFO GND:B VDD:B data:B data_s:B data_shift:B sel:B sel_b:B
MNM1 data sel_b data_s GND nch_tn W=220n L=180n M=1.0
MNM0 data sel data_shift GND nch_tn W=220n L=180n M=1.0
MPM1 data_s sel data VDD pch_tn W=220n L=180n M=1.0
MPM0 data_shift sel_b data VDD pch_tn W=220n L=180n M=1.0
XI0 GND VDD sel sel_b / inv
.ENDS
VVDD VDD 0 1.8
VGND GND 0 
.vec 'TG.vec'
VDATA data vin[0]
VSEL  sel  vin[1]
.probe
.tran 1p 200ns
XTG GND VDD data data_s data_shift sel sel_b TG
.end
