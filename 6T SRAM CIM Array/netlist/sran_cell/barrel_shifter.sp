.title
.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: barrel_shifter
* View Name:     schematic
* Netlisted on:  Mar 24 07:45:58 2026
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
* Cell Name:    mux2_1
* View Name:    schematic
************************************************************************

.SUBCKT mux2_1 A B GND S VDD Y
*.PININFO A:B B:B GND:B S:B VDD:B Y:B
XI0 GND VDD S net8 / inv_1
XI4 net10 net11 GND VDD Y / nand_2
XI3 B S GND VDD net11 / nand_2
XI2 net8 A GND VDD net10 / nand_2
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    barrel_shifter
* View Name:    schematic
************************************************************************

.SUBCKT barrel_shifter D0 D1 D2 D3 D4 D5 D6 D7 GND S0 S1 S2 VDD Y0 Y1 Y2 Y3 Y4 
+ Y5 Y6 Y7
*.PININFO D0:B D1:B D2:B D3:B D4:B D5:B D6:B D7:B GND:B S0:B S1:B S2:B VDD:B 
*.PININFO Y0:B Y1:B Y2:B Y3:B Y4:B Y5:B Y6:B Y7:B
XI30 D4 D3 GND S0 VDD net120 / mux2_1
XI36 net76 net120 GND S1 VDD net75 / mux2_1
XI35 net69 net47 GND S2 VDD Y7 / mux2_1
XI34 net70 net71 GND S1 VDD net69 / mux2_1
XI33 D7 D6 GND S0 VDD net70 / mux2_1
XI32 D6 D5 GND S0 VDD net76 / mux2_1
XI31 D5 D4 GND S0 VDD net71 / mux2_1
XI29 D3 D2 GND S0 VDD net83 / mux2_1
XI45 net53 GND GND S2 VDD Y2 / mux2_1
XI38 net35 net59 GND S2 VDD Y5 / mux2_1
XI39 net71 net83 GND S1 VDD net35 / mux2_1
XI40 net120 net128 GND S1 VDD net87 / mux2_1
XI41 net87 net42 GND S2 VDD Y4 / mux2_1
XI42 net47 GND GND S2 VDD Y3 / mux2_1
XI43 net83 net8 GND S1 VDD net47 / mux2_1
XI44 net128 net99 GND S1 VDD net53 / mux2_1
XI37 net75 net53 GND S2 VDD Y6 / mux2_1
XI46 net59 GND GND S2 VDD Y1 / mux2_1
XI47 net8 GND GND S1 VDD net59 / mux2_1
XI48 net99 GND GND S1 VDD net42 / mux2_1
XI49 net42 GND GND S2 VDD Y0 / mux2_1
XI7 D2 D1 GND S0 VDD net128 / mux2_1
XI6 D1 D0 GND S0 VDD net8 / mux2_1
XI0 D0 GND GND S0 VDD net99 / mux2_1
.ENDS
Xbarrel_shifter D0 D1 D2 D3 D4 D5 D6 D7 GND S0 S1 S2 VDD Y0 Y1 Y2 Y3 Y4 
+ Y5 Y6 Y7 barrel_shifter
VVDD VDD 0 0.54
VGND GND 0 0
VD0 D0 D[0]
VD1 D1 D[1]
VD2 D2 D[2]
VD3 D3 D[3]
VD4 D4 D[4]
VD5 D5 D[5]
VD6 D6 D[6]
VD7 D7 D[7]

VS0 S0 S[0]
VS1 S1 S[1]
VS2 S2 S[2]


.vec 'barrel_shifter.vec'
.tran 0.1n 250n
.end
