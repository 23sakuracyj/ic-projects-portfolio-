.title
.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" SS_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: main
* View Name:     schematic
* Netlisted on:  Apr 11 03:45:35 2026
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
* Cell Name:    precharge
* View Name:    schematic
************************************************************************

.SUBCKT precharge B Bbar GND VDD charge_en
*.PININFO B:B Bbar:B GND:B VDD:B charge_en:B
MPM3 Bbar charge_en B VDD pch_tn W=1.4u L=180n M=1.0
MPM2 B charge_en Bbar VDD pch_tn W=1.4u L=180n M=1.0
MPM1 B charge_en VDD VDD pch_tn W=1.4u L=180n M=1.0
MPM0 Bbar charge_en VDD VDD pch_tn W=1.4u L=180n M=1.0
XI0 GND VDD charge_en charge_enb / inv_1
MNM1 Bbar charge_enb B GND nch_tn W=1.4u L=180n M=1.0
MNM0 B charge_enb Bbar GND nch_tn W=1.4u L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    nor3
* View Name:    schematic
************************************************************************

.SUBCKT nor3 A B C GND VDD Vout
*.PININFO A:B B:B C:B GND:B VDD:B Vout:B
MPM2 Vout C net012 VDD pch_tn W=1.5u L=180n M=1.0
MPM1 net012 B net12 VDD pch_tn W=1.5u L=180n M=1.0
MPM0 net12 A VDD VDD pch_tn W=1.5u L=180n M=1.0
MNM2 Vout C GND GND nch_tn W=250n L=180n M=1.0
MNM1 Vout B GND GND nch_tn W=250n L=180n M=1.0
MNM0 Vout A GND GND nch_tn W=250n L=180n M=1.0
.ENDS

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
* Cell Name:    guan
* View Name:    schematic
************************************************************************

.SUBCKT guan BL BLq GND VDD Vin
*.PININFO BL:B BLq:B GND:B VDD:B Vin:B
MNM75 BLq Vin BL GND nch_tn W=220n L=180n M=1.0
MNM76 BL net34 GND GND nch_tn W=220n L=180n M=1.0
XI78 GND VDD Vin net34 / inv
MPM5 BL net34 BLq VDD pch_tn W=220n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    MUX_Bbar
* View Name:    schematic
************************************************************************

.SUBCKT MUX_Bbar Bbar D7 GND VDD W_E
*.PININFO Bbar:B D7:B GND:B VDD:B W_E:B
MNM2 net11 W_E GND GND nch_tn W=12.15u L=180n M=1.0
MNM1 Bbar D7 net11 net11 nch_tn W=12.15u L=180n M=1.0
MNM0 net8 W_E GND GND nch_tn W=450n L=180n M=1.0
MPM2 Bbar D7 net13 net13 pch_tn W=2.115u L=180n M=1.0
MPM1 net13 net8 VDD VDD pch_tn W=2.115u L=180n M=1.0
MPM0 net8 W_E VDD VDD pch_tn W=1.35u L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    MUX_B
* View Name:    schematic
************************************************************************

.SUBCKT MUX_B B D7 GND VDD W_E
*.PININFO B:B D7:B GND:B VDD:B W_E:B
MNM3 net06 D7 GND GND nch_tn W=450n L=180n M=1.0
MNM0 net74 W_E GND GND nch_tn W=450n L=180n M=1.0
MNM2 net71 W_E GND GND nch_tn W=1.215u L=180n M=1.0
MNM1 B net06 net71 net71 nch_tn W=1.215u L=180n M=1.0
MPM3 net06 D7 VDD VDD pch_tn W=1.35u L=180n M=1.0
MPM2 B net06 net72 net72 pch_tn W=2.115u L=180n M=1.0
MPM1 net72 net74 VDD VDD pch_tn W=2.115u L=180n M=1.0
MPM0 net74 W_E VDD VDD pch_tn W=1.35u L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    replica_SRAM_6T
* View Name:    schematic
************************************************************************

.SUBCKT replica_SRAM_6T B Bbar GND Q_B VDD W0
*.PININFO B:B Bbar:B GND:B Q_B:B VDD:B W0:B
MNM3 B W0 Q GND nch_tn W=700n L=180n M=1.0
MNM2 Bbar W0 Q_B GND nch_tn W=700n L=180n M=1.0
MNM1 Q_B Q GND GND nch_tn W=1.5u L=180n M=1.0
MNM0 Q Q_B GND GND nch_tn W=1.5u L=180n M=1.0
MPM1 Q_B Q VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 Q Q_B VDD VDD pch_tn W=450n L=180n M=1.0
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
* Cell Name:    inv_schematic
* View Name:    schematic
************************************************************************

.SUBCKT inv_schematic GND VDD Vin Vout
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
XI1 GND VDD net2 Vout / inv_schematic
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    replica
* View Name:    schematic
************************************************************************

.SUBCKT replica A ASSIST_EN B BE BLq0 BLq1 BLq2 BLq3 BLq4 BLq5 BLq6 BLq7 C GND 
+ SAMP VDD VSS_AST data7
*.PININFO A:B ASSIST_EN:B B:B BE:B BLq0:B BLq1:B BLq2:B BLq3:B BLq4:B BLq5:B 
*.PININFO BLq6:B BLq7:B C:B GND:B SAMP:B VDD:B VSS_AST:B data7:B
MNM10 net030 BL0 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM9 net031 BL1 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM8 net028 BL2 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM7 Q_B BL3 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM6 net033 BL4 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM5 net029 BL5 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM4 net034 BL6 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM3 net042 BL7 Q_B_sel GND nch_tn W=600n L=180n M=1.0
MNM2 net010 net05 GND GND nch_tn W=220n L=180n M=2.0
MNM1 rep_fail net010 GND GND nch_tn W=400n L=180n M=1.0
MNM0 net05 Q_B_sel GND GND nch_tn W=220n L=180n M=1.0
XI18 A B C GND VDD net076 / nor3
XI17 A B _C GND VDD net071 / nor3
XI15 A _B C GND VDD net070 / nor3
XI4 A _B _C GND VDD net067 / nor3
XI8 _A B C GND VDD net068 / nor3
XI10 _A B _C GND VDD net065 / nor3
XI9 _A _B C GND VDD net069 / nor3
XI2 _A _B _C GND VDD net066 / nor3
XI83 BL0 BLq0 GND VDD net076 / guan
XI84 BL1 BLq1 GND VDD net071 / guan
XI85 BL2 BLq2 GND VDD net070 / guan
XI86 BL3 BLq3 GND VDD net067 / guan
XI14 BL4 BLq4 GND VDD net068 / guan
XI13 BL5 BLq5 GND VDD net065 / guan
XI12 BL6 BLq6 GND VDD net069 / guan
XI3 BL7 BLq7 GND VDD net066 / guan
XI113 Bbar7 data7 GND VDD BE / MUX_Bbar
XI114 B7 data7 GND VDD BE / MUX_B
XI42 B7 Bbar7 VSS_AST net030 VDD BL0 / replica_SRAM_6T
XI40 B7 Bbar7 VSS_AST net031 VDD BL1 / replica_SRAM_6T
XI39 B7 Bbar7 VSS_AST net033 VDD BL4 / replica_SRAM_6T
XI38 B7 Bbar7 VSS_AST net028 VDD BL2 / replica_SRAM_6T
XI37 B7 Bbar7 VSS_AST Q_B VDD BL3 / replica_SRAM_6T
XI36 B7 Bbar7 VSS_AST net029 VDD BL5 / replica_SRAM_6T
XI35 B7 Bbar7 VSS_AST net034 VDD BL6 / replica_SRAM_6T
XI0 B7 Bbar7 VSS_AST net042 VDD BL7 / replica_SRAM_6T
MPM10 net030 BL0B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM9 net031 BL1B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM8 net028 BL2B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM7 Q_B BL3B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM6 net033 BL4B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM5 net029 BL5B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM4 net034 BL6B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM3 net042 BL7B Q_B_sel VDD pch_tn W=600n L=180n M=1.0
MPM2 rep_fail net010 VDD VDD pch_tn W=1.2u L=180n M=1.0
MPM1 net010 net05 VDD VDD pch_tn W=700n L=180n M=1.0
MPM0 net05 Q_B_sel VDD VDD pch_tn W=220n L=180n M=2.0
XI1 rep_fail SAMP GND VDD ASSIST_EN / and2
XI16 GND VDD A _A / inv
XI7 GND VDD B _B / inv
XI5 GND VDD C _C / inv
XI50 GND VDD BL7 BL7B / inv_1
XI49 GND VDD BL6 BL6B / inv_1
XI48 GND VDD BL5 BL5B / inv_1
XI47 GND VDD BL4 BL4B / inv_1
XI46 GND VDD BL3 BL3B / inv_1
XI45 GND VDD BL2 BL2B / inv_1
XI44 GND VDD BL1 BL1B / inv_1
XI43 GND VDD BL0 BL0B / inv_1
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    Decoder3_8
* View Name:    schematic
************************************************************************

.SUBCKT Decoder3_8 A B BL0 BL1 BL2 BL3 BL4 BL5 BL6 BL7 BLq0 BLq1 BLq2 BLq3 
+ BLq4 BLq5 BLq6 BLq7 C GND VDD
*.PININFO A:B B:B BL0:B BL1:B BL2:B BL3:B BL4:B BL5:B BL6:B BL7:B BLq0:B 
*.PININFO BLq1:B BLq2:B BLq3:B BLq4:B BLq5:B BLq6:B BLq7:B C:B GND:B VDD:B
XI11 BL7 BLq7 GND VDD B7 / guan
XI12 BL6 BLq6 GND VDD B6 / guan
XI13 BL5 BLq5 GND VDD B5 / guan
XI14 BL4 BLq4 GND VDD B4 / guan
XI83 BL0 BLq0 GND VDD B0 / guan
XI84 BL1 BLq1 GND VDD B1 / guan
XI85 BL2 BLq2 GND VDD B2 / guan
XI86 BL3 BLq3 GND VDD B3 / guan
XI6 _A _B _C GND VDD B7 / nor3
XI8 _A B C GND VDD B4 / nor3
XI9 _A _B C GND VDD B6 / nor3
XI10 _A B _C GND VDD B5 / nor3
XI4 A _B _C GND VDD B3 / nor3
XI3 A _B C GND VDD B2 / nor3
XI2 A B _C GND VDD B1 / nor3
XI1 A B C GND VDD B0 / nor3
XI5 GND VDD C _C / inv
XI0 GND VDD A _A / inv
XI7 GND VDD B _B / inv
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    sense_amplifier
* View Name:    schematic
************************************************************************

.SUBCKT sense_amplifier B Bbar GND ReadOut ReadOutbar VDD sense
*.PININFO B:B Bbar:B GND:B ReadOut:B ReadOutbar:B VDD:B sense:B
MPM3 ReadOut ReadOutbar VDD VDD pch_tn W=810n L=180n M=1.0
MPM2 ReadOutbar ReadOut VDD VDD pch_tn W=810n L=180n M=1.0
MPM1 ReadOutbar sense Bbar VDD pch_tn W=1.305u L=180n M=1.0
MPM0 ReadOut sense B VDD pch_tn W=1.305u L=180n M=1.0
MNM2 net8 VDD GND GND nch_tn W=900n L=180n M=1.0
MNM1 ReadOutbar ReadOut net8 net8 nch_tn W=495n L=180n M=1.0
MNM0 ReadOut ReadOutbar net8 net8 nch_tn W=495n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    SRAM_6T
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_6T B Bbar GND VDD W0
*.PININFO B:B Bbar:B GND:B VDD:B W0:B
MNM3 B W0 net12 GND nch_tn W=700n L=180n M=1.0
MNM2 Bbar W0 net3 GND nch_tn W=700n L=180n M=1.0
MNM1 net3 net12 GND GND nch_tn W=1.5u L=180n M=1.0
MNM0 net12 net3 GND GND nch_tn W=1.5u L=180n M=1.0
MPM1 net3 net12 VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 net12 net3 VDD VDD pch_tn W=450n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    SRAM_8X8_wa
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_8X8_wa BE GND PRE ReadOut0 ReadOut1 ReadOut2 ReadOut3 ReadOut4 
+ ReadOut5 ReadOut6 ReadOut7 ReadOutbar0 ReadOutbar1 ReadOutbar2 ReadOutbar3 
+ ReadOutbar4 ReadOutbar5 ReadOutbar6 ReadOutbar7 S SAMP VDD WE WE_rep WN0 WN1 
+ WN2 data0 data1 data2 data3 data4 data5 data6 data7
*.PININFO BE:B GND:B PRE:B ReadOut0:B ReadOut1:B ReadOut2:B ReadOut3:B 
*.PININFO ReadOut4:B ReadOut5:B ReadOut6:B ReadOut7:B ReadOutbar0:B 
*.PININFO ReadOutbar1:B ReadOutbar2:B ReadOutbar3:B ReadOutbar4:B 
*.PININFO ReadOutbar5:B ReadOutbar6:B ReadOutbar7:B S:B SAMP:B VDD:B WE:B 
*.PININFO WE_rep:B WN0:B WN1:B WN2:B data0:B data1:B data2:B data3:B data4:B 
*.PININFO data5:B data6:B data7:B
XI76 B5 Bbar5 GND VDD PRE / precharge
XI75 B4 Bbar4 GND VDD PRE / precharge
XI77 B6 Bbar6 GND VDD PRE / precharge
XI78 B7 Bbar7 GND VDD PRE / precharge
XI43 B3 Bbar3 GND VDD PRE / precharge
XI41 B2 Bbar2 GND VDD PRE / precharge
XI39 B1 Bbar1 GND VDD PRE / precharge
XI8 B0 Bbar0 GND VDD PRE / precharge
XI121 WN0 write_assist WN1 BE WE_rep WE_rep WE_rep WE_rep WE_rep WE_rep WE_rep 
+ WE_rep WN2 GND SAMP VDD VSS_AST data7 / replica
XI118 B4 data4 GND VDD BE / MUX_B
XI116 B6 data6 GND VDD BE / MUX_B
XI114 B7 data7 GND VDD BE / MUX_B
XI112 B5 data5 GND VDD BE / MUX_B
XI36 B2 data2 GND VDD BE / MUX_B
XI33 B3 data3 GND VDD BE / MUX_B
XI30 B1 data1 GND VDD BE / MUX_B
XI6 B0 data0 GND VDD BE / MUX_B
XI117 Bbar4 data4 GND VDD BE / MUX_Bbar
XI115 Bbar6 data6 GND VDD BE / MUX_Bbar
XI113 Bbar7 data7 GND VDD BE / MUX_Bbar
XI111 Bbar5 data5 GND VDD BE / MUX_Bbar
XI35 Bbar2 data2 GND VDD BE / MUX_Bbar
XI32 Bbar3 data3 GND VDD BE / MUX_Bbar
XI29 Bbar1 data1 GND VDD BE / MUX_Bbar
XI7 Bbar0 data0 GND VDD BE / MUX_Bbar
XI5 WN0 WN1 W0 W1 W2 W3 W4 W5 W6 W7 WE WE WE WE WE WE WE WE WN2 GND VDD / 
+ Decoder3_8
XI74 B6 Bbar6 GND ReadOut6 ReadOutbar6 VDD S / sense_amplifier
XI73 B4 Bbar4 GND ReadOut4 ReadOutbar4 VDD S / sense_amplifier
XI71 B5 Bbar5 GND ReadOut5 ReadOutbar5 VDD S / sense_amplifier
XI72 B7 Bbar7 GND ReadOut7 ReadOutbar7 VDD S / sense_amplifier
XI26 B3 Bbar3 GND ReadOut3 ReadOutbar3 VDD S / sense_amplifier
XI25 B2 Bbar2 GND ReadOut2 ReadOutbar2 VDD S / sense_amplifier
XI24 B1 Bbar1 GND ReadOut1 ReadOutbar1 VDD S / sense_amplifier
XI4 B0 Bbar0 GND ReadOut0 ReadOutbar0 VDD S / sense_amplifier
XI110 B2 Bbar2 VSS_AST VDD W6 / SRAM_6T
XI109 B1 Bbar1 VSS_AST VDD W6 / SRAM_6T
XI108 B0 Bbar0 VSS_AST VDD W6 / SRAM_6T
XI107 B3 Bbar3 VSS_AST VDD W7 / SRAM_6T
XI106 B2 Bbar2 VSS_AST VDD W7 / SRAM_6T
XI105 B1 Bbar1 VSS_AST VDD W7 / SRAM_6T
XI104 B0 Bbar0 VSS_AST VDD W7 / SRAM_6T
XI103 B3 Bbar3 VSS_AST VDD W6 / SRAM_6T
XI102 B4 Bbar4 VSS_AST VDD W7 / SRAM_6T
XI101 B4 Bbar4 VSS_AST VDD W5 / SRAM_6T
XI100 B6 Bbar6 VSS_AST VDD W5 / SRAM_6T
XI99 B4 Bbar4 VSS_AST VDD W4 / SRAM_6T
XI98 B5 Bbar5 VSS_AST VDD W5 / SRAM_6T
XI97 B7 Bbar7 VSS_AST VDD W5 / SRAM_6T
XI96 B6 Bbar6 VSS_AST VDD W7 / SRAM_6T
XI95 B5 Bbar5 VSS_AST VDD W7 / SRAM_6T
XI94 B7 Bbar7 VSS_AST VDD W6 / SRAM_6T
XI93 B6 Bbar6 VSS_AST VDD W6 / SRAM_6T
XI92 B5 Bbar5 VSS_AST VDD W6 / SRAM_6T
XI91 B4 Bbar4 VSS_AST VDD W6 / SRAM_6T
XI90 B5 Bbar5 VSS_AST VDD W4 / SRAM_6T
XI89 B6 Bbar6 VSS_AST VDD W4 / SRAM_6T
XI88 B7 Bbar7 VSS_AST VDD W4 / SRAM_6T
XI87 B3 Bbar3 VSS_AST VDD W4 / SRAM_6T
XI86 B3 Bbar3 VSS_AST VDD W5 / SRAM_6T
XI85 B2 Bbar2 VSS_AST VDD W5 / SRAM_6T
XI55 B4 Bbar4 VSS_AST VDD W3 / SRAM_6T
XI63 B4 Bbar4 VSS_AST VDD W1 / SRAM_6T
XI65 B6 Bbar6 VSS_AST VDD W1 / SRAM_6T
XI67 B4 Bbar4 VSS_AST VDD W0 / SRAM_6T
XI64 B5 Bbar5 VSS_AST VDD W1 / SRAM_6T
XI66 B7 Bbar7 VSS_AST VDD W1 / SRAM_6T
XI84 B2 Bbar2 VSS_AST VDD W4 / SRAM_6T
XI57 B6 Bbar6 VSS_AST VDD W3 / SRAM_6T
XI56 B5 Bbar5 VSS_AST VDD W3 / SRAM_6T
XI80 B0 Bbar0 VSS_AST VDD W5 / SRAM_6T
XI79 B0 Bbar0 VSS_AST VDD W4 / SRAM_6T
XI81 B7 Bbar7 VSS_AST VDD W7 / SRAM_6T
XI82 B1 Bbar1 VSS_AST VDD W5 / SRAM_6T
XI83 B1 Bbar1 VSS_AST VDD W4 / SRAM_6T
XI62 B7 Bbar7 VSS_AST VDD W2 / SRAM_6T
XI61 B6 Bbar6 VSS_AST VDD W2 / SRAM_6T
XI60 B5 Bbar5 VSS_AST VDD W2 / SRAM_6T
XI59 B4 Bbar4 VSS_AST VDD W2 / SRAM_6T
XI68 B5 Bbar5 VSS_AST VDD W0 / SRAM_6T
XI69 B6 Bbar6 VSS_AST VDD W0 / SRAM_6T
XI70 B7 Bbar7 VSS_AST VDD W0 / SRAM_6T
XI23 B3 Bbar3 VSS_AST VDD W0 / SRAM_6T
XI22 B3 Bbar3 VSS_AST VDD W1 / SRAM_6T
XI21 B3 Bbar3 VSS_AST VDD W2 / SRAM_6T
XI20 B3 Bbar3 VSS_AST VDD W3 / SRAM_6T
XI19 B2 Bbar2 VSS_AST VDD W3 / SRAM_6T
XI18 B2 Bbar2 VSS_AST VDD W2 / SRAM_6T
XI17 B2 Bbar2 VSS_AST VDD W1 / SRAM_6T
XI16 B2 Bbar2 VSS_AST VDD W0 / SRAM_6T
XI15 B1 Bbar1 VSS_AST VDD W0 / SRAM_6T
XI14 B1 Bbar1 VSS_AST VDD W1 / SRAM_6T
XI13 B1 Bbar1 VSS_AST VDD W2 / SRAM_6T
XI12 B1 Bbar1 VSS_AST VDD W3 / SRAM_6T
XI58 B7 Bbar7 VSS_AST VDD W3 / SRAM_6T
XI3 B0 Bbar0 VSS_AST VDD W3 / SRAM_6T
XI2 B0 Bbar0 VSS_AST VDD W2 / SRAM_6T
XI1 B0 Bbar0 VSS_AST VDD W1 / SRAM_6T
XI0 B0 Bbar0 VSS_AST VDD W0 / SRAM_6T
MNM0 VSS_AST net22 GND GND nch_tn W=1.6u L=180n M=1.0
XI11 GND VDD write_assist net22 / inv
CI10 VSS_AST write_assist 10f $[CP]
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    xnor_v2
* View Name:    schematic
************************************************************************

.SUBCKT xnor_v2 A B GND VDD Y
*.PININFO A:B B:B GND:B VDD:B Y:B
MPM3 Y net14 net7 VDD pch_tn W=3.12u L=180n M=1.0
MPM2 net7 B VDD VDD pch_tn W=3.12u L=180n M=1.0
MPM1 Y net1 net7 VDD pch_tn W=3.12u L=180n M=1.0
MPM0 net7 A VDD VDD pch_tn W=3.12u L=180n M=1.0
MNM3 net16 net14 GND GND nch_tn W=780n L=180n M=1.0
MNM2 Y net1 net16 GND nch_tn W=780n L=180n M=1.0
MNM1 net17 B GND GND nch_tn W=780n L=180n M=1.0
MNM0 Y A net17 GND nch_tn W=780n L=180n M=1.0
XI1 GND VDD B net14 / inv_1
XI0 GND VDD A net1 / inv_1
.ENDS

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
XI16 GND VDD RST RST_B / inv_1
XI9 GND VDD net05 net5 / inv_1
XI11 GND VDD net013 net027 / inv_1
XI4 GND VDD CLK CLK_B / inv_1
XI13 net07 RST GND VDD Q_B / nand2_schematic
MNM4 net05 CLK net07 GND nch_tn W=300n L=180n M=1.0
MNM0 D CLK_B net8 GND nch_tn W=300n L=180n M=1.0
MNM5 net027 CLK_B net07 GND nch_tn W=390n L=180n M=1.0
MNM6 net013 RST_B GND GND nch_tn W=300n L=180n M=1.0
MNM1 net5 CLK net8 GND nch_tn W=390n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    D_flipflop_inv
* View Name:    schematic
************************************************************************

.SUBCKT D_flipflop_inv CLK_B D GND Q Q_B RST VDD
*.PININFO CLK_B:B D:B GND:B Q:B Q_B:B RST:B VDD:B
XI14 net3 D GND Q Q_B RST VDD / D_flipflop1
XI15 GND VDD CLK_B net3 / inv_1
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    inv_d
* View Name:    schematic
************************************************************************

.SUBCKT inv_d GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=600n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=1u L=180n M=1.0
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
* Cell Name:    PG_generate
* View Name:    schematic
************************************************************************

.SUBCKT PG_generate GFJI GKI GKJ GND PFJI PKI PKJ VDD
*.PININFO GFJI:B GKI:B GKJ:B GND:B PFJI:B PKI:B PKJ:B VDD:B
XI5 GND VDD net23 GKI / inv_1
XI3 GND VDD net24 PKI / inv_1
XI2 GND VDD net25 net015 / inv_1
XI1 PKJ PFJI GND VDD net24 / nand_2
XI0 GFJI PKJ GND VDD net25 / nand_2
XI4 GKJ net015 GND VDD net23 / nor_2
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    G_generate
* View Name:    schematic
************************************************************************

.SUBCKT G_generate GFJI GKI GKJ GND PKJ VDD
*.PININFO GFJI:B GKI:B GKJ:B GND:B PKJ:B VDD:B
XI2 GND VDD net17 net05 / inv_1
XI1 GND VDD net16 GKI / inv_1
XI3 PKJ GFJI GND VDD net17 / nand_2
XI0 GKJ net05 GND VDD net16 / nor_2
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    add_tree1
* View Name:    schematic
************************************************************************

.SUBCKT add_tree1 A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 B3 B4 B5 B6 B7 B8 C9Q C9QB CLK 
+ GND RST S1Q S1QB S2Q S2QB S3Q S3QB S4Q S4QB S5Q S5QB S6Q S6QB S7Q S7QB S8Q 
+ S8QB VDD
*.PININFO A1:B A2:B A3:B A4:B A5:B A6:B A7:B A8:B B1:B B2:B B3:B B4:B B5:B 
*.PININFO B6:B B7:B B8:B C9Q:B C9QB:B CLK:B GND:B RST:B S1Q:B S1QB:B S2Q:B 
*.PININFO S2QB:B S3Q:B S3QB:B S4Q:B S4QB:B S5Q:B S5QB:B S6Q:B S6QB:B S7Q:B 
*.PININFO S7QB:B S8Q:B S8QB:B VDD:B
XI65 C8 P8 GND VDD S8 / xnor_v2
XI64 B8 A8 GND VDD P8 / xnor_v2
XI45 C0 P1 GND VDD S1 / xnor_v2
XI44 C2 P2 GND VDD S2 / xnor_v2
XI43 C3 P3 GND VDD S3 / xnor_v2
XI38 C7 P7 GND VDD S7 / xnor_v2
XI40 C6 P6 GND VDD S6 / xnor_v2
XI42 C4 P4 GND VDD S4 / xnor_v2
XI41 C5 P5 GND VDD S5 / xnor_v2
XI21 B7 A7 GND VDD P7 / xnor_v2
XI20 B6 A6 GND VDD P6 / xnor_v2
XI19 B5 A5 GND VDD P5 / xnor_v2
XI18 B4 A4 GND VDD P4 / xnor_v2
XI17 B3 A3 GND VDD P3 / xnor_v2
XI16 B2 A2 GND VDD P2 / xnor_v2
XI15 B1 A1 GND VDD P1 / xnor_v2
XI63 GND VDD net065 G8 / inv_1
XI14 GND VDD net19 G7 / inv_1
XI13 GND VDD net20 G6 / inv_1
XI12 GND VDD net21 G5 / inv_1
XI11 GND VDD net22 G4 / inv_1
XI10 GND VDD net23 G3 / inv_1
XI9 GND VDD net24 G2 / inv_1
XI8 GND VDD net25 G1 / inv_1
XI52 CLKB_2 S1 GND S1Q S1QB RST VDD / D_flipflop_inv
XI60 CLKB_4 C9 GND C9Q C9QB RST VDD / D_flipflop_inv
XI59 CLKB_4 S8 GND S8Q S8QB RST VDD / D_flipflop_inv
XI58 CLKB_1 S7 GND S7Q S7QB RST VDD / D_flipflop_inv
XI57 CLKB_1 S6 GND S6Q S6QB RST VDD / D_flipflop_inv
XI56 CLKB_3 S5 GND S5Q S5QB RST VDD / D_flipflop_inv
XI55 CLKB_3 S4 GND S4Q S4QB RST VDD / D_flipflop_inv
XI54 CLKB_2 S3 GND S3Q S3QB RST VDD / D_flipflop_inv
XI53 CLKB_4 S2 GND S2Q S2QB RST VDD / D_flipflop_inv
XI72 GND VDD CLK CLKB_4 / inv_d
XI70 GND VDD CLK CLKB_2 / inv_d
XI71 GND VDD CLK CLKB_3 / inv_d
XI66 GND VDD CLK CLKB_1 / inv_d
XI62 A8 B8 GND VDD net065 / nand_2
XI7 A7 B7 GND VDD net19 / nand_2
XI6 A6 B6 GND VDD net20 / nand_2
XI5 A5 B5 GND VDD net21 / nand_2
XI4 A4 B4 GND VDD net22 / nand_2
XI3 A3 B3 GND VDD net23 / nand_2
XI2 A2 B2 GND VDD net24 / nand_2
XI1 A1 B1 GND VDD net25 / nand_2
XI25 G5_4 G7_4 G7_6 GND P5_4 P7_4 P7_6 VDD / PG_generate
XI24 G2 G3_2 G3 GND P2 P3_2 P3 VDD / PG_generate
XI23 G4 G5_4 G5 GND P4 P5_4 P5 VDD / PG_generate
XI22 G6 G7_6 G7 GND P6 P7_6 P7 VDD / PG_generate
XI61 C8 C9 G8 GND P8 VDD / G_generate
XI51 C6 C7 G6 GND P6 VDD / G_generate
XI49 C4 C5 G4 GND P4 VDD / G_generate
XI50 C4 C6 G5_4 GND P5_4 VDD / G_generate
XI46 C2 C3 G2 GND P2 VDD / G_generate
XI36 C2 C4 G3_2 GND P3_2 VDD / G_generate
XI35 C0 C2 G1 GND P1 VDD / G_generate
XI37 C4 C8 G7_4 GND P7_4 VDD / G_generate
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

************************************************************************
* Library Name: Test
* Cell Name:    main
* View Name:    schematic
************************************************************************

.SUBCKT main BLE CLK D0 D1 D2 D3 D4 D5 D6 D7 GND PRE RST SA SAMPLE TEST0 TEST1 
+ TEST2 TEST3 TEST4 TEST5 TEST6 TEST7 TEST_ADD_1 TEST_ADD_2 TEST_ADD_3 
+ TEST_ADD_4 TEST_ADD_5 TEST_ADD_6 TEST_ADD_7 TEST_ADD_8 TEST_ADD_C9 
+ TEST_ADD_C9B VDD W0 W1 W2 WE WE_rep shift0 shift1 shift2
*.PININFO BLE:B CLK:B D0:B D1:B D2:B D3:B D4:B D5:B D6:B D7:B GND:B PRE:B 
*.PININFO RST:B SA:B SAMPLE:B TEST0:B TEST1:B TEST2:B TEST3:B TEST4:B TEST5:B 
*.PININFO TEST6:B TEST7:B TEST_ADD_1:B TEST_ADD_2:B TEST_ADD_3:B TEST_ADD_4:B 
*.PININFO TEST_ADD_5:B TEST_ADD_6:B TEST_ADD_7:B TEST_ADD_8:B TEST_ADD_C9:B 
*.PININFO TEST_ADD_C9B:B VDD:B W0:B W1:B W2:B WE:B WE_rep:B shift0:B shift1:B 
*.PININFO shift2:B
XI0 BLE GND PRE net79 net78 net77 net76 net75 net74 net73 net72 TEST0 TEST1 
+ TEST2 TEST3 TEST4 TEST5 TEST6 TEST7 SA SAMPLE VDD WE WE_rep W0 W1 W2 D0 D1 
+ D2 D3 D4 D5 D6 D7 / SRAM_8X8_wa
XI1 net71 net70 net69 net039 net67 net66 net037 net038 T_1_0 T_1_1 T_1_2 T_1_3 
+ T_1_4 T_1_5 T_1_6 T_1_7 TEST_ADD_C9 TEST_ADD_C9B CLK GND RST T_1_0 
+ TEST_ADD_1 T_1_1 TEST_ADD_2 T_1_2 TEST_ADD_3 T_1_3 TEST_ADD_4 T_1_4 
+ TEST_ADD_5 T_1_5 TEST_ADD_6 T_1_6 TEST_ADD_7 T_1_7 TEST_ADD_8 VDD / add_tree1
XI2 net79 net78 net77 net76 net75 net74 net73 net72 GND shift0 shift1 shift2 
+ VDD net71 net70 net69 net039 net67 net66 net037 net038 / barrel_shifter
.ENDS
Xmain BLE CLK D0 D1 D2 D3 D4 D5 D6 D7 GND PRE RST SA SAMPLE TEST0 TEST1 
+ TEST2 TEST3 TEST4 TEST5 TEST6 TEST7 TEST_ADD_1 TEST_ADD_2 TEST_ADD_3 
+ TEST_ADD_4 TEST_ADD_5 TEST_ADD_6 TEST_ADD_7 TEST_ADD_8 TEST_ADD_C9 
+ TEST_ADD_C9B VDD W0 W1 W2 WE WE_rep shift0 shift1 shift2 main
VVDD VDD 0 0.65
VGND GND 0 0
.vec 'main_low.vec' 
VD0 D0 D[0]
VD1 D1 D[1]
VD2 D2 D[2]
VD3 D3 D[3]
VD4 D4 D[4]
VD5 D5 D[5]
VD6 D6 D[6]
VD7 D7 D[7]

VW0 W0 W[0]
VW1 W1 W[1]
VW2 W2 W[2]

Vshift0 shift0 shift[0]
Vshift1 shift1 shift[1]
Vshift2 shift2 shift[2]
.tran 0.1n 1200n
.measure tran v1 find v(TEST_ADD_1) at=1130n
.measure tran v2 find v(TEST_ADD_2) at=1130n
.measure tran v3 find v(TEST_ADD_3) at=1130n
.measure tran v4 find v(TEST_ADD_4) at=1130n
.measure tran v5 find v(TEST_ADD_5) at=1130n
.measure tran v6 find v(TEST_ADD_6) at=1130n
.measure tran v7 find v(TEST_ADD_7) at=1130n
.measure tran v8 find v(TEST_ADD_8) at=1130n
.end
