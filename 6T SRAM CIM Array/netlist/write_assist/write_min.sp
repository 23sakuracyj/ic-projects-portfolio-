.title
.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: write_min
* View Name:     schematic
* Netlisted on:  May  3 00:21:58 2026
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
* Cell Name:    write_min
* View Name:    schematic
************************************************************************

.SUBCKT write_min B Bbar GND Q_B VDD W0
*.PININFO B:B Bbar:B GND:B Q_B:B VDD:B W0:B
MNM3 B W0 Q GND nch_tn W=700n L=180n M=1.0
MNM2 Bbar W0 Q_B GND nch_tn W=700n L=180n M=1.0
MNM1 Q_B Q GND GND nch_tn W=1.5u L=180n M=1.0
MNM0 Q Q_B GND GND nch_tn W=1.5u L=180n M=1.0
MPM1 Q_B Q VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 Q Q_B VDD VDD pch_tn W=450n L=180n M=1.0
.ENDS

