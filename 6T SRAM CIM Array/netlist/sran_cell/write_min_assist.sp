************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: write_min_assist
* View Name:     schematic
* Netlisted on:  May  3 06:26:23 2026
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
* Cell Name:    write_min_assist
* View Name:    schematic
************************************************************************

.SUBCKT write_min_assist B Bbar GND Q_B VDD W0 write_assist
*.PININFO B:B Bbar:B GND:B Q_B:B VDD:B W0:B write_assist:B
MNM5 VSS_AST net026 GND GND nch_tn W=1.6u L=180n M=1.0
MNM3 B W0 Q VSS_AST nch_tn W=700n L=180n M=1.0
MNM2 Bbar W0 Q_B VSS_AST nch_tn W=700n L=180n M=1.0
MNM1 Q_B Q VSS_AST VSS_AST nch_tn W=1.5u L=180n M=1.0
MNM0 Q Q_B VSS_AST VSS_AST nch_tn W=1.5u L=180n M=1.0
MPM1 Q_B Q VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 Q Q_B VDD VDD pch_tn W=450n L=180n M=1.0
XI11 GND VDD write_assist net026 / inv
CI10 VSS_AST write_assist 10f $[CP]
.ENDS

