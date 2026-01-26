************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: precharge
* View Name:     schematic
* Netlisted on:  Jan 26 23:02:06 2026
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

