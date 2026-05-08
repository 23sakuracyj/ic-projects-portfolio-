.title
.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" ff_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: D_flipflop1
* View Name:     schematic
* Netlisted on:  Apr 10 04:29:39 2026
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
* Cell Name:    inv_L
* View Name:    schematic
************************************************************************

.SUBCKT inv_L GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=400n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=700n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM1
* Cell Name:    nand2
* View Name:    schematic
************************************************************************

.SUBCKT nand2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MNM1 Vout A net17 GND nch_tn W=220n L=180n M=1.0
MNM0 net17 B GND GND nch_tn W=500n L=180n M=1.0
MPM1 Vout B VDD VDD pch_tn W=500n L=180n M=1.0
MPM0 Vout A VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM1
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
* Cell Name:    and2
* View Name:    schematic
************************************************************************

.SUBCKT and2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
XI0 A B GND VDD net2 / nand2
XI1 GND VDD net2 Vout / inv
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    inv_1
* View Name:    schematic
************************************************************************

.SUBCKT inv_1 GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=300n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    nand2_schematic
* View Name:    schematic
************************************************************************

.SUBCKT nand2_schematic A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MNM1 Vout A net17 GND nch_tn W=220n L=180n M=1.0
MNM0 net17 B GND GND nch_tn W=500n L=180n M=1.0
MPM1 Vout B VDD VDD pch_tn W=500n L=180n M=1.0
MPM0 Vout A VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    D_flipflop1
* View Name:    schematic
************************************************************************

.SUBCKT D_flipflop1 CLK D GND Q Q_B RST VDD
*.PININFO CLK:B D:B GND:B Q:B Q_B:B RST:B VDD:B
MPM4 net05 CLK_B net07 VDD pch_tn W=300n L=180n M=1.0
MPM2 net5 CLK_B net8 VDD pch_tn W=390n L=180n M=1.0
MPM0 D CLK net8 VDD pch_tn W=300n L=180n M=1.0
MPM5 net027 CLK net07 VDD pch_tn W=390n L=180n M=1.0
XI8 GND VDD net8 net05 / inv_L
XI10 GND VDD net07 net013 / inv_L
XI15 net013 RST GND VDD Q / and2
XI9 GND VDD net05 net5 / inv_1
XI11 GND VDD net013 net027 / inv_1
XI4 GND VDD CLK CLK_B / inv_1
XI13 net07 RST GND VDD Q_B / nand2_schematic
MNM4 net05 CLK net07 GND nch_tn W=300n L=180n M=1.0
MNM0 D CLK_B net8 GND nch_tn W=300n L=180n M=1.0
MNM5 net027 CLK_B net07 GND nch_tn W=390n L=180n M=1.0
MNM1 net5 CLK net8 GND nch_tn W=390n L=180n M=1.0
.ENDS
XD_flipflop1 CLK D GND Q Q_B RST VDD D_flipflop1
VVDD VDD 0 1.8
VGND GND 0 0
.vec 'D_flipflop1.vec'
.tran 0.1n 250n
.end
