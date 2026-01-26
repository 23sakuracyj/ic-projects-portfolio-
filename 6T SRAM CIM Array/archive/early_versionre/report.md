# Design Archive and Known Issues (Early / Deprecated Versions)
This document records early design attempts and deprecated modules developed during the initial stages of the SRAM-based CIM project.
These versions are preserved for design traceability and technical completeness, although they are not used in the current architecture due to functional or timing limitations identified during simulation.

## 1. Overview
During the early exploration of the CIM write-back and control path, multiple circuit-level implementations were evaluated, including latch-based storage elements, transmission-gate-based shift logic, and tri-state output stages.
Although these designs were functional at the schematic level, detailed transient simulations revealed timing hazards and control complexity that made them unsuitable for reliable integration into the final CIM architecture.
The following sections summarize the purpose, implementation intent, and identified issues of each deprecated module.

## 2. Latch-Based Storage (D_latch.sp, D_latch.lis)
### Design Intent
A level-sensitive D latch was initially evaluated as a replacement for conventional master–slave edge-triggered flip-flops.
The motivation was to:
Reduce clocking complexity
Enable transparent data propagation during specific CIM control phases
Potentially reduce area and power overhead
### Observed Issues
Transient simulations revealed severe timing sensitivity, including:
Data transparency overlapping with control signal transitions
Race conditions between write-enable and latch transparency windows
Unstable behavior under tight timing margins at low voltage
Because the latch-based approach lacks a well-defined sampling edge, it became difficult to guarantee correct sequencing between CIM computation, write-back control, and monitoring logic.
### Conclusion
The latch-based storage scheme was abandoned in favor of edge-triggered control logic, which provides clearer timing boundaries and better robustness for array-level coordination.

## 3. ISOACC-Based Shift Logic (ISOAcc.sp, ISOAcc_v2.sp)
### Design Intent
The ISOACC (Isolated Accumulator) module was designed to support shift-based in-memory computation, inspired by related CIM literature.
It was intended to:
Accumulate partial computation results
Support bit-serial or shift-based data movement
Interface with downstream write-back logic
Two versions were implemented to explore alternative control strategies and signal isolation schemes.
### Observed Issues
Although functionally correct in isolation, the ISOACC module introduced:
Complex multi-phase control requirements
Tight coupling between shift timing and memory access timing
Increased risk of control skew when integrated with the SRAM array
These factors significantly increased system-level timing complexity without providing sufficient benefit for the current CIM target.
### Conclusion
The ISOACC-based shift computation path was not included in the final architecture.
The project instead adopts a simpler and more robust computation and write-back flow.

## 4. Transmission-Gate Shift Module (TG.sp, TG.tr0)
### Design Intent
A transmission-gate (TG) based shift module was explored as a low-overhead data shifting mechanism.
This design was adapted from reference circuits reported in prior CIM-related literature.
### Observed Issues
Simulation waveforms showed:
Degraded signal integrity under low-voltage operation
Sensitivity to control signal overlap
Limited noise margin when cascaded across multiple stages
While suitable for small, isolated signal paths, the TG-based shift structure proved unreliable when scaled or integrated into the broader CIM control logic.
### Conclusion
The TG-based shift module was retained only as a reference implementation and is not used in the current design.

## 5. Preliminary SRAM Array (SRAM_4x4.sp, SRAM_4x4.lis)
### Design Intent
A preliminary 4×4 SRAM array was constructed as an early proof-of-concept to validate:
Basic cell connectivity
Wordline and bitline routing
Initial read/write functionality
### Observed Issues
At this early stage, the array exhibited:
Timing misalignment between wordline activation and bitline sensing
Incomplete coordination between write enable and peripheral control signals
Sensitivity to clock skew in multi-cycle operations
These issues were primarily architectural and motivated a redesign of the control and write-back strategy.
### Conclusion
This version of the 4×4 SRAM array served as an exploratory prototype.
Its limitations directly informed subsequent architectural refinements in the final design.

## 6. Tri-State Gate Output Stage (Three_state_gate.sp, Three_state_gate.lis)
### Design Intent
A tri-state gate was initially considered for the output stage to enable shared bus access and conditional data driving.
### Observed Issues
Simulation results indicated:
Unclear enable timing relative to upstream logic
Risk of bus contention during control transitions
Limited benefit compared to explicit multiplexing structures
Given the added verification complexity and marginal advantages, the tri-state approach was deemed unnecessary.
### Conclusion
The tri-state gate was removed from the final design and replaced with deterministic logic-based selection.

## 7. Summary

The deprecated modules documented in this report reflect normal exploratory iterations in circuit and architecture design.
Each design was evaluated through transistor-level simulation, and decisions to abandon or replace modules were based on:
Timing robustness
Control complexity
Scalability
Compatibility with low-voltage operation
These early versions provide valuable insight into the design evolution and informed the final, more reliable CIM architecture.
