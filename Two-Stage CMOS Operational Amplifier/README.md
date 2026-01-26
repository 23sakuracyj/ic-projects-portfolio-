# Two-Stage CMOS Operational Amplifier Design (180 nm)

## Project Overview

This project presents a complete **two-stage CMOS operational amplifier** design and verification workflow based on a **180 nm CMOS process**.  
The work was conducted as an integrated circuit comprehensive design project, covering **schematic design, transistor-level simulation, layout implementation, and physical verification**.

The primary objective of this project is to demonstrate a **standard and reproducible analog IC design flow**, rather than targeting aggressive performance optimization.

---

## Design Objectives

- Implement a classical **two-stage CMOS operational amplifier**
- Achieve stable operation under **unit-gain negative feedback**
- Verify key analog performance metrics through simulation
- Complete **full-custom layout** and pass **DRC / LVS**
- Establish consistency between schematic-level and layout-level designs

---

## Architecture Overview

The amplifier adopts a conventional two-stage topology:

1. **First Stage**
   - NMOS differential input pair
   - PMOS current-mirror active load
   - Provides main voltage gain and differential-to-single-ended conversion

2. **Second Stage**
   - Common-source amplifier with current-source load
   - Enhances overall gain and output swing

3. **Frequency Compensation**
   - Miller compensation capacitor between first-stage output and amplifier output
   - Ensures sufficient phase margin under closed-loop operation

---

## Design Flow

The project follows a standard analog IC design methodology:

1. **Theoretical analysis**
   - Small-signal modeling
   - Gain, pole, and stability estimation

2. **Schematic design**
   - Transistor sizing based on gm/ro trade-offs
   - Bias current allocation and operating point verification

3. **Pre-layout simulation**
   - DC operating point analysis
   - AC analysis (gain, bandwidth)
   - Stability analysis (phase margin)
   - CMRR and PSRR evaluation

4. **Layout implementation**
   - Full-custom layout in Cadence Virtuoso
   - Multi-finger devices for large transistors
   - Dummy devices for matching improvement
   - Guard rings and structured power routing

5. **Physical verification**
   - DRC (Design Rule Check)
   - LVS (Layout Versus Schematic)

---

## Key Simulation Results

The following performance aspects were verified through Spectre simulations:

- **DC Characteristics**
  - Proper biasing of all transistors
  - Valid input common-mode range
  - Correct voltage follower behavior under unit-gain feedback

- **AC Performance**
  - High open-loop differential gain
  - Controlled gain roll-off with Miller compensation
  - Adequate phase margin ensuring closed-loop stability

- **Rejection Metrics**
  - CMRR evaluated over frequency
  - PSRR evaluated for supply noise sensitivity

All results exhibit behavior consistent with classical two-stage CMOS operational amplifiers.

---

## Layout and Verification

- Layout implemented using **full-custom methodology**
- Critical devices placed with symmetry and matching considerations
- Dummy transistors used to reduce edge effects
- Power and ground routing designed to minimize noise coupling

Verification status:
- ✅ DRC: Passed (only density-related warnings)
- ✅ LVS: Clean match between schematic and layout

---

## Tools Used

- **Cadence Virtuoso**
- **Spectre Simulator**
- **Calibre DRC / LVS**
- 180 nm CMOS PDK

---

## Project Status

- ✔ Schematic design completed
- ✔ Pre-layout simulation completed
- ✔ Layout completed
- ✔ DRC / LVS passed
- ⏳ Post-layout (PEX) simulation: not performed

---

## Limitations and Future Work

- No PVT corner analysis performed
- No post-layout parasitic extraction (PEX)
- Noise and offset analysis not included
- Design optimized for methodology validation rather than production use

Future improvements may include:
- Full PEX-based post-layout simulation
- PVT robustness analysis
- Power optimization and noise characterization
- Migration to advanced process nodes

---

## Notes

This project emphasizes **design correctness, methodology completeness, and physical realizability**, serving as a solid foundation for more advanced analog and mixed-signal IC designs.
