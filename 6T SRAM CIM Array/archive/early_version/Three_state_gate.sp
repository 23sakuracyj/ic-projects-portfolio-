.title
.option post
.temp 85
.lib "/home/IC/CYJ2025/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: three_state_gate
* View Name:     schematic
* Netlisted on:  Mar 30 23:40:47 2025
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
* Cell Name:    nor_2
* View Name:    schematic
************************************************************************

.SUBCKT nor_2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MPM1 Vout B net12 VDD pch_tn W=1u L=180n M=1.0
MPM0 net12 A VDD VDD pch_tn W=1u L=180n M=1.0
MNM1 Vout B GND GND nch_tn W=250n L=180n M=1.0
MNM0 Vout A GND GND nch_tn W=250n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    nand_2
* View Name:    schematic
************************************************************************

.SUBCKT nand_2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MNM1 Vout A net17 GND nch_tn W=220n L=180n M=1.0
MNM0 net17 B GND GND nch_tn W=500n L=180n M=1.0
MPM1 Vout B VDD VDD pch_tn W=500n L=180n M=1.0
MPM0 Vout A VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    three_state_gate
* View Name:    schematic
************************************************************************

.SUBCKT three_state_gate A EN GND VDD Y
*.PININFO A:B EN:B GND:B VDD:B Y:B
XI2 GND VDD EN net11 / inv_1
XI1 GND VDD A net3 / inv_1
XI3 net11 net3 GND VDD net17 / nor_2
XI4 EN net3 GND VDD net16 / nand_2
MNM0 Y net17 GND GND nch_tn W=300n L=180n M=1.0
MPM0 Y net16 VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

VVDD VDD 0 1.8
VGND GND 0 0
VEN EN 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)
VA A 0 PULSE(0 1.8 2n 0.1n 0.1n 15n 30n)
Xthree_state_gate A EN GND VDD Y three_state_gate
.TRAN 0.1n 50n
.probe V(EN) V(A) V(Y)
.END
