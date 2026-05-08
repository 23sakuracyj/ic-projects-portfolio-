# 6T SRAM Compute-in-Memory Array with Replica-Sensed Adaptive Write Assist

## 1. Introduction

Compute-in-Memory (CIM) architectures based on SRAM are widely studied for reducing data movement between memory and processing units. In conventional Von Neumann architectures, frequent data transfer between the processor and memory introduces significant latency and power overhead, especially in data-intensive applications such as edge inference and neural network acceleration.

SRAM-based CIM can reduce this overhead by allowing stored data to participate directly in computation. However, when the supply voltage is reduced, conventional 6T SRAM cells suffer from degraded write ability. The access transistors become weaker, making it more difficult to break the original state of the cross-coupled inverters. As a result, write failures may occur, and incorrect stored weights will directly affect the correctness of CIM computation.

This project presents an 8×8 all-digital SRAM-CIM array based on standard 6T SRAM cells. To improve low-voltage write reliability, a replica-sensed adaptive write-assist circuit is introduced. The design uses a reference SRAM path to monitor the write condition of the main array. When the reference cell fails to complete the expected transition within the sampling window, the write-assist circuit is enabled to improve the write success rate.

The proposed architecture combines SRAM storage, adaptive write assist, replica-based detection, barrel shifting, and Brent-Kung adder-tree accumulation to support low-voltage digital CIM operation.

## 2. Overall Architecture

The proposed system is centered on an 8×8 6T SRAM array and its peripheral circuits. The SRAM array stores weight data, while the peripheral computation logic performs shift-and-accumulate operations.

The main functional modules include:

- 6T SRAM cell array
- Wordline decoder
- Bitline precharge and equalization circuit
- SRAM write driver
- Sense amplifier
- Local source-line write-assist circuit
- Replica detection circuit
- Data detection logic
- Barrel shifter
- Brent-Kung adder tree
- Register feedback path
- Timing and control logic

During CIM operation, the SRAM array outputs stored weight data. The barrel shifter shifts the read data according to the current input bit position. The shifted partial product is then accumulated by the Brent-Kung adder tree. The accumulated result is stored by D flip-flops and fed back for the next computation cycle.

## 3. 6T SRAM Cell and Array Design

The SRAM cell used in this project is a conventional 6T structure composed of two cross-coupled inverters and two access transistors. The cell supports hold, read, and write operations through WL, BL, and BLB signals.

The transistor sizing is designed to balance read stability and write ability:

| Device Type | Width |
|---|---:|
| Pull-down NMOS | 1.5 μm |
| Access NMOS | 700 nm |
| Pull-up PMOS | 450 nm |

The sizing relationship is:

```text
W_PD > W_ACCESS > W_PU
```

This configuration improves read stability by strengthening the pull-down path, while keeping the access transistor stronger than the pull-up transistor to support write operations.

The SRAM cell is verified through Static Noise Margin analysis, including:

- Hold SNM
- Read SNM
- Write SNM

At 1.8 V supply voltage, the simulated results are:

| Metric | Result |
|---|---:|
| Hold SNM | 0.5676 V |
| Read SNM | 0.2957 V |
| Write-0 SNM | 0.6519 V |
| Write-1 SNM | 0.7430 V |

These results show that the designed 6T SRAM cell has acceptable hold, read, and write margins under nominal supply voltage.

## 4. Local Source-Line Write-Assist Circuit

Under low-voltage operation, the access transistor drive capability is reduced, and the SRAM cell becomes more difficult to flip during write operations. To improve write reliability, this project adopts a local source-line bias write-assist circuit.

The key internal node of the write-assist circuit is:

```text
VSS_AST
```

During normal hold and read operations, `VSS_AST` is clamped to GND to avoid disturbing the stored data. During write operation, the write-assist signal triggers capacitive coupling, causing `VSS_AST` to rise temporarily above GND.

This temporary source-line elevation weakens the original latch state of the SRAM cell. As a result, the access transistor can more easily force the internal storage node to switch, improving the write success rate at low voltage.

The write-assist mechanism has the following characteristics:

- It does not modify the standard 6T SRAM cell structure.
- It weakens the cell only during the write phase.
- It improves low-voltage write ability.
- It avoids unnecessary disturbance during hold and read phases.
- It can be combined with replica detection for conditional activation.

## 5. Replica Detection Circuit

To avoid enabling write assist in every write cycle, a replica detection circuit is introduced. The replica circuit uses a reference SRAM path to estimate the write condition of the main array.

The replica detection module includes:

- 3-to-8 decoder
- Buffer chain
- Write driver
- 1×8 dummy SRAM reference cells
- Transmission gate
- Sampling logic
- Write-assist decision logic

During a write operation, the reference cell is driven under a condition similar to that of the main SRAM array. The internal storage node of the reference cell is sampled after a short delay.

If the reference cell completes the expected transition within the sampling window, the system considers the current write condition safe, and write assist remains disabled.

If the reference cell fails to complete the transition in time, the system judges that the main array may also suffer from write failure. In this case, the control logic raises:

```text
ASSIST_EN
```

The write-assist circuit is then activated to improve the write operation.

This mechanism allows the circuit to adapt to different Process, Voltage, and Temperature conditions without applying write assist unnecessarily.

## 6. Data Detection Logic

The design also includes an 8-bit data detection circuit. Since the write difficulty is not identical for all data patterns, the detection circuit first checks whether the input data contains a potentially difficult write case.

For the designed SRAM cell, write-0 shows a smaller margin than write-1 under the selected sizing condition. Therefore, the data detection circuit checks whether the 8-bit input contains low-level data.

If no risky write condition exists, the replica detection and write-assist path can remain inactive, reducing unnecessary power consumption.

If risky data is detected, the replica detection path is enabled to further judge whether write assist is required.

## 7. CIM Computation Architecture

The CIM computation adopts a digital shift-and-accumulate method. The SRAM array stores weight data, and the input vector is processed bit by bit.

For each input bit:

1. If the input bit is `1`, the SRAM weight data is read out.
2. The read data is shifted left according to the current bit position.
3. The shifted value is treated as a partial product.
4. The partial product is added to the previous accumulated result.
5. The new sum is stored in registers for the next cycle.

If the input bit is `0`, the corresponding partial product is skipped.

This structure avoids using a full multiplier and instead uses a barrel shifter, an adder tree, and register feedback to complete multiplication over multiple cycles.

## 8. Barrel Shifter

The barrel shifter is used to perform logical left shift on the SRAM output data. It is implemented using three stages of 2-to-1 multiplexers.

The three shift-control signals correspond to:

| Control Signal | Shift Amount |
|---|---:|
| W1 | 1 bit |
| W2 | 2 bits |
| W3 | 4 bits |

Therefore, the circuit can support arbitrary left shifts from 0 to 7 bits.

The shifted-out high bits are discarded, and the vacant low bits are filled with 0. This module generates the partial product for each CIM computation cycle.

## 9. Brent-Kung Adder Tree

The shifted partial product is sent to a Brent-Kung adder tree for accumulation.

Compared with a ripple-carry adder, the Brent-Kung adder reduces carry propagation delay by using a parallel prefix structure. Compared with more aggressive prefix adders such as Kogge-Stone, the Brent-Kung structure has lower wiring complexity, making it suitable for the peripheral logic of the proposed CIM array.

The adder output is connected to D flip-flops. This register stage stores the stable accumulation result and feeds it back to the next computation cycle.

This is important under low-voltage operation because combinational logic delay increases and transient glitches may appear during signal switching. Registering the output helps maintain stable multi-cycle accumulation.

## 10. Simulation and Verification

The proposed circuit is verified using transistor-level HSPICE simulation based on a 180 nm CMOS process.

The verification includes:

- 6T SRAM hold, read, and write operation simulation
- SNM, RSNM, and WSNM extraction
- Minimum write voltage simulation
- Standard write and write-assist comparison
- Decoder transient simulation
- D flip-flop transient simulation
- Replica detection simulation
- Barrel shifter simulation
- Brent-Kung adder simulation
- CIM single-operation simulation
- Random-vector CIM correctness verification
- PVT stability simulation
- Maximum operating frequency estimation

The evaluated PVT conditions include:

| Parameter | Values |
|---|---|
| Process Corner | FF, TT, SS |
| Temperature | 25 ℃, 85 ℃, 125 ℃ |
| Supply Voltage | 0.5 V, 0.55 V, 0.6 V, 0.65 V, 1.8 V |

## 11. Key Simulation Results

### 11.1 Minimum Write Voltage Improvement

The write-assist circuit reduces the minimum writable voltage under different PVT conditions.

| Condition | Standard Write | With Write Assist | Improvement |
|---|---:|---:|---:|
| SS / 25 ℃ / Write-0 | 0.63 V | 0.57 V | 60 mV |
| TT / 125 ℃ / Write-0 | 0.46 V | 0.39 V | 70 mV |

The results show that the local source-line write-assist circuit can improve low-voltage write reliability.

### 11.2 CIM Computation Result

A single CIM multiplication case is verified using:

```text
00101101 × 00001111
```

The theoretical result is:

```text
00000010_10100011
```

Since the implemented CIM output keeps the lower 8 bits, the expected output is:

```text
10100011
```

Simulation results show that the CIM array can produce the correct lower 8-bit result at both:

- 1.8 V standard supply
- 0.535 V low-voltage supply with write assist enabled

At 0.535 V, the computation cycle must be extended due to increased circuit delay.

### 11.3 Power and Energy Comparison

Compared with 1.8 V operation, low-voltage operation significantly reduces power and energy consumption.

At 0.55 V:

- Average power is reduced by 95.5%.
- Average energy is reduced by 91.7%.
- Computation time increases by 50.0%.

At 0.535 V with write assist enabled, compared with 0.55 V:

- Average power is further reduced by 8.6%.
- Average energy is further reduced by 8.5%.
- Computation time increases by 27.8%.

These results indicate that low-voltage CIM operation can improve energy efficiency, but at the cost of longer computation time.

### 11.4 PVT Stability

Random-vector simulations show that the CIM array is sensitive to PVT conditions.

The general trend is:

```text
FF corner > TT corner > SS corner
```

- FF corner shows the best low-voltage operating capability.
- TT corner can generally pass the test at 0.6 V and above.
- SS corner has the most severe failure cases, especially at low temperature and low supply voltage.

For the valid operating points, the maximum operating frequency ranges approximately from:

```text
7.57 MHz to 100 MHz
```

## 12. Key Contributions

The main contributions of this project are:

- Design of an 8×8 all-digital SRAM-CIM array based on standard 6T SRAM cells
- Local source-line write-assist circuit for low-voltage SRAM write reliability improvement
- Replica-based detection circuit for adaptive write-assist activation
- Digital shift-and-accumulate CIM structure using a barrel shifter and Brent-Kung adder tree
- Transistor-level verification under multiple voltage, temperature, and process conditions
- Evaluation of power, energy, computation delay, correctness rate, and maximum operating frequency

## 13. Repository Structure

A suggested repository structure is shown below:

```text
6T-SRAM-CIM-Adaptive-Write-Assist/
├── README.md
├── docs/
│   ├── figures/
│   └── thesis_summary.md
├── netlist/
│   ├── sram_cell/
│   ├── write_assist/
│   ├── replica_detection/
│   ├── decoder/
│   ├── sense_amp/
│   ├── dff/
│   └── cim_top/
├── sim/
│   ├── hspice/
│   ├── pvt_sweep/
│   ├── random_vector/
│   └── frequency_scan/
├── scripts/
│   ├── parse_result.py
│   ├── plot_waveform.py
│   ├── plot_pvt_map.py
│   └── run_sweep.sh
├── results/
│   ├── snm/
│   ├── write_margin/
│   ├── replica_detection/
│   ├── cim_output/
│   ├── power_energy/
│   └── pvt_summary/
└── LICENSE
```

## 14. How to Run Simulation

Before running the simulation, configure the HSPICE environment and update the model-library path in the simulation files.

Example command:

```bash
cd sim/pvt_sweep
bash run_sweep.sh
```

To parse simulation results:

```bash
python scripts/parse_result.py
```

To generate waveform or summary figures:

```bash
python scripts/plot_waveform.py
python scripts/plot_pvt_map.py
```

## 15. Applicability and Extension

The proposed design is suitable for low-power SRAM-CIM research and can be extended to:

- Larger SRAM-CIM arrays
- More advanced CMOS technology nodes
- Improved write-assist strength control
- More accurate replica detection timing
- Post-layout simulation with parasitic extraction
- Voltage-frequency scaling strategies
- Fault-tolerant CIM computation

## 16. Limitations

The current project is mainly verified at the schematic and pre-layout simulation level. Several limitations remain:

- Layout design has not yet been completed.
- Parasitic effects have not been fully evaluated.
- Extreme SS-corner and low-temperature cases still show failure points.
- Computation delay increases significantly under near-threshold operation.
- The current array scale is limited to 8×8.

Future work will focus on layout implementation, post-layout simulation, write-assist strength optimization, replica detection timing adjustment, and larger-scale CIM array evaluation.

## Keywords

`6T SRAM` `SRAM-CIM` `Compute-in-Memory` `Write Assist` `Replica Detection` `VSS_AST` `Low Voltage` `HSPICE` `Barrel Shifter` `Brent-Kung Adder` `PVT Simulation`