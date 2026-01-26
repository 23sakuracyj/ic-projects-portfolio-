.title
.option post
.temp 85
.lib "/home/IC/CYJ2025/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: ISOAcc
* View Name:     schematic
* Netlisted on:  May 23 11:15:16 2025
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

.SUBCKT TG GND VDD data data_s data_shift sel
*.PININFO GND:B VDD:B data:B data_s:B data_shift:B sel:B
MNM1 data sel_b data_s GND nch_tn W=220n L=180n M=1.0
MNM0 data sel data_shift GND nch_tn W=220n L=180n M=1.0
MPM1 data_s sel data VDD pch_tn W=220n L=180n M=1.0
MPM0 data_shift sel_b data VDD pch_tn W=220n L=180n M=1.0
XI0 GND VDD sel sel_b / inv
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    ISOAcc
* View Name:    schematic
************************************************************************

.SUBCKT ISOAcc ACC0 ACC1 ACC1_0 ACC1_1 ACC1_2 ACC1_3 ACC1_4 ACC1_5 ACC1_6 ACC2 
+ ACC2_0 ACC2_1 ACC2_2 ACC2_3 ACC2_4 ACC2_5 ACC2_6 ACC3 ACC4 ACC5 ACC6 GND 
+ NEXT VDD data0 data1 data2 data3 data4 data5 data6 sel0 sel1 sel2 sel3
*.PININFO ACC0:B ACC1:B ACC1_0:B ACC1_1:B ACC1_2:B ACC1_3:B ACC1_4:B ACC1_5:B 
*.PININFO ACC1_6:B ACC2:B ACC2_0:B ACC2_1:B ACC2_2:B ACC2_3:B ACC2_4:B 
*.PININFO ACC2_5:B ACC2_6:B ACC3:B ACC4:B ACC5:B ACC6:B GND:B NEXT:B VDD:B 
*.PININFO data0:B data1:B data2:B data3:B data4:B data5:B data6:B sel0:B 
*.PININFO sel1:B sel2:B sel3:B
XI27 GND VDD ACC1_2 GND ACC2_6 sel3 / TG
XI26 GND VDD ACC1_1 GND ACC2_5 sel3 / TG
XI25 GND VDD ACC1_0 GND ACC2_4 sel3 / TG
XI24 GND VDD GND GND ACC2_3 sel3 / TG
XI23 GND VDD GND GND ACC2_2 sel3 / TG
XI22 GND VDD GND GND ACC2_1 sel3 / TG
XI21 GND VDD GND GND ACC2_0 sel3 / TG
XI20 GND VDD GND GND ACC1_0 sel2 / TG
XI19 GND VDD GND GND ACC1_1 sel2 / TG
XI18 GND VDD ACC0 GND ACC1_2 sel2 / TG
XI17 GND VDD ACC1 GND ACC1_3 sel2 / TG
XI16 GND VDD ACC2 ACC1_0 ACC1_4 sel2 / TG
XI15 GND VDD ACC3 ACC1_1 ACC1_5 sel2 / TG
XI14 GND VDD ACC4 ACC1_2 ACC1_6 sel2 / TG
XI13 GND VDD GND GND ACC0 sel1 / TG
XI12 GND VDD net10 GND ACC1 sel1 / TG
XI11 GND VDD net9 ACC0 ACC2 sel1 / TG
XI10 GND VDD net8 ACC1 ACC3 sel1 / TG
XI9 GND VDD net7 sel2 ACC4 sel1 / TG
XI8 GND VDD net6 ACC3 ACC5 sel1 / TG
XI7 GND VDD net3 ACC4 ACC6 sel1 / TG
XI6 GND VDD data0 GND net10 sel0 / TG
XI5 GND VDD data1 net10 net9 sel0 / TG
XI4 GND VDD data2 net9 net8 sel0 / TG
XI3 GND VDD data3 net8 net7 sel0 / TG
XI2 GND VDD data4 net7 net6 sel0 / TG
XI1 GND VDD data5 net6 net3 sel0 / TG
XI0 GND VDD data6 net3 NEXT sel0 / TG
.ENDS
VVDD VDD 0 1.8
VGND GND 0 
.vec 'ISOAcc_data.vec'
.vec 'ISOAcc_sel_v2.vec'
VDATA0 data0 vin[0]
VDATA1 data1 vin[1]
VDATA2 data2 vin[2]
VDATA3 data3 vin[3]
VDATA4 data4 vin[4]
VDATA5 data5 vin[5]
VDATA6 data6 vin[6]
VSEL0  sel0  vins[0]
VSEL1  sel1  vins[1]
VSEL2  sel2  vins[2]
VSEL3  sel3  vins[3]
.probe
.tran 1p 200ns
XISOAcc ACC0 ACC1 ACC1_0 ACC1_1 ACC1_2 ACC1_3 ACC1_4 ACC1_5 ACC1_6 ACC2 
+ ACC2_0 ACC2_1 ACC2_2 ACC2_3 ACC2_4 ACC2_5 ACC2_6 ACC3 ACC4 ACC5 ACC6 GND 
+ NEXT VDD data0 data1 data2 data3 data4 data5 data6 sel0 sel1 sel2 sel3 ISOAcc
.end
