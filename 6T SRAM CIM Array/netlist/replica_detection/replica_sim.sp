.title
.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: replica_sim
* View Name:     schematic
* Netlisted on:  Apr  9 06:04:46 2026
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
* Cell Name:    replica_sim
* View Name:    schematic
************************************************************************

.SUBCKT replica_sim A ASSIST_EN B BE BLq7 C GND SAMP VDD data7
*.PININFO A:B ASSIST_EN:B B:B BE:B BLq7:B C:B GND:B SAMP:B VDD:B data7:B
MNM2 net010 net05 GND GND nch_tn W=220n L=180n M=2.0
MNM1 rep_fail net010 GND GND nch_tn W=400n L=180n M=1.0
MNM0 net05 Q_B GND GND nch_tn W=220n L=180n M=1.0
XI6 net026 net021 net022 GND VDD net029 / nor3
XI11 BL7 BLq7 GND VDD net029 / guan
XI113 Bbar7 data7 GND VDD BE / MUX_Bbar
XI114 B7 data7 GND VDD BE / MUX_B
XI0 B7 Bbar7 GND Q_B VDD BL7 / replica_SRAM_6T
MPM2 rep_fail net010 VDD VDD pch_tn W=1.2u L=180n M=1.0
MPM1 net010 net05 VDD VDD pch_tn W=700n L=180n M=1.0
MPM0 net05 Q_B VDD VDD pch_tn W=220n L=180n M=2.0
XI1 rep_fail SAMP GND VDD ASSIST_EN / and2
XI4 GND VDD C net022 / inv
XI3 GND VDD B net021 / inv
XI2 GND VDD A net026 / inv
.ENDS
Xreplica_sim A ASSIST_EN B BE BLq7 C GND SAMP VDD data7 replica_sim
VVDD VDD 0 0.65
VGND GND 0 0
.vec 'replica_sim.vec'
.tran 0.1n 250n
.end
