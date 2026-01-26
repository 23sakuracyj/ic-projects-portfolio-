# 8-bit Tree Prefix Adder (Full-Custom CMOS Design)

## Overview

This project presents the **design, simulation, and full-custom layout implementation**
of an **8-bit tree-structured prefix adder**, targeting high-speed binary addition
with acceptable power and area overhead.

The design is implemented using **Cadence Virtuoso** for schematic and layout,
and verified through **HSPICE transistor-level simulation**.
Both **pre-layout** and **post-layout (PEX)** simulations are performed.
Performance is evaluated and compared against a conventional
**Ripple Carry Adder (RCA)**.

---

## Design Objectives

- Achieve faster addition compared to ripple-based adders
- Maintain reasonable power consumption and silicon area
- Perform full-custom CMOS design without relying on standard-cell libraries
- Complete the full design flow: schematic → simulation → layout → DRC/LVS → PEX

---

## Architecture

The adder adopts a **tree prefix (Kogge–Stone–style) structure**, which computes
carry signals in parallel using a multi-level prefix network.

### Key Principles

- For each bit:
  - Generate signal: `G = A · B`
  - Propagate signal: `P = A ⊕ B`
- Carry signals are computed hierarchically using prefix merge operations
- Final sum is obtained by:
Si = Pi ⊕ Ci

By reducing the carry computation depth from linear to logarithmic,
the critical path delay is significantly shortened.

---

## Basic Cell Design

All logic is implemented at the **transistor level**.
The following CMOS building blocks are designed and characterized:

- Inverter
- 2× inverter buffer
- Large-drive inverter
- 2-input NAND
- 2-input NOR
- XOR gate (static CMOS, 12-transistor implementation)
- Edge-triggered D flip-flop with reset

Each cell is:
- Designed schematically
- Simulated in HSPICE
- Implemented with full-custom layout
- Verified with DRC and LVS

---

## Top-Level Adder Implementation

The complete 8-bit adder consists of:

- G/P generation logic
- Multi-level prefix carry network
- XOR-based sum generation
- Output registers implemented with D flip-flops

To support synchronous operation and measurement,
all sum outputs and the final carry-out are registered.
A global clock and reset are used.

---

## Simulation and Verification

### Pre-Layout Simulation

- Functional correctness verified for multiple input patterns
- Worst-case propagation delay ≈ **0.75 ns**
- Parallel carry generation confirmed by near-simultaneous output transitions

### Comparison with Ripple Carry Adder

| Metric | Tree Adder | Ripple Carry Adder |
|------|-----------|--------------------|
| Worst-case delay | ~0.75 ns | ~1.6 ns |
| Average power | ~1.5 mW | ~0.8 mW |
| MOS count | 668 | 224 |

The tree adder significantly improves speed at the cost of higher
area and dynamic power—an expected and acceptable trade-off in
high-performance designs.

---

## Layout and Physical Verification

- Full-custom layout completed in Cadence Virtuoso
- Layout size: **~39 µm × 101.8 µm**
- Total transistor count: **668 MOSFETs**
- Power rails routed globally
- Critical carry paths minimized in routing

### Verification Results

- **DRC**: Clean (no rule violations)
- **LVS**: Clean (layout matches schematic)
- **PEX simulation** confirms functional correctness

---

## Post-Layout (PEX) Results

After parasitic extraction:

- Worst-case delay increases to ~**1.16 ns**
- Power increases moderately due to interconnect capacitance
- Functional behavior remains correct

The post-layout degradation is within acceptable margins,
indicating sufficient timing robustness.

---

## Key Takeaways

- Prefix adders provide substantial speed improvement through parallel carry computation
- Area and power overhead scale with logic complexity
- Full-custom design enables fine-grained performance optimization
- Post-layout verification is essential to validate real-world behavior

---

## Tools and Environment

- **Cadence Virtuoso** – schematic & layout
- **HSPICE** – transistor-level simulation
- **Calibre** – DRC / LVS / PEX
- CMOS technology node: **~0.12–0.18 µm class**

---

## Author Contribution

This project was completed **independently**.
All schematic design, simulation, layout, and verification
were performed by the author.

---

## Notes

Due to the use of shared academic servers, original SPICE netlists
and raw simulation output files are not fully archived locally.
However, representative waveforms, layouts, and extracted
performance metrics are preserved and documented.
