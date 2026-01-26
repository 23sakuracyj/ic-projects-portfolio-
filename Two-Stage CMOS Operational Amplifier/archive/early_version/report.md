# Design Archive – Early Schematic Iterations of Two-Stage CMOS Operational Amplifier

This document records **early schematic iterations** of the two-stage CMOS
operational amplifier project.  
These versions represent intermediate design stages explored during biasing
and device matching refinement and are **not used in the final implementation**.

The archived designs are preserved to document the **design reasoning,
validation process, and decisions** leading to the final schematic and layout.

---

## Overview of Archived Versions

The `archive/early_version/` directory contains three schematic-level
iterations:

- `amplifier/` – baseline schematic without current mirror device matching  
- `amplifier_sim/` – simplified bias model with current mirror replaced by ideal current sources  
- `amplifier_v2/` – matched current mirror implementation without dummy devices  

Each version targets a **specific verification objective** in the design flow.

---

## 1. `amplifier/` – Baseline Schematic without Current Mirror Matching

### Design Intent

This version represents the **initial two-stage operational amplifier
schematic**, focusing on functional topology validation.

The objectives were to:

- Establish correct two-stage amplifier topology
- Verify signal flow from differential input to output
- Confirm basic biasing and operating regions of all transistors
- Perform preliminary AC and transient simulations

### Characteristics

- Differential input stage with PMOS current mirror load
- Second-stage common-source amplifier
- No explicit matching constraints on current mirror devices
- No layout-related considerations

### Observed Limitations

- Mismatch sensitivity in the current mirror load
- Increased offset and gain variation under process perturbations
- Limited suitability for layout-aware verification

### Conclusion

This version served as a **functional baseline**, but highlighted the necessity
of proper current mirror matching for robust analog performance.

---

## 2. `amplifier_sim/` – Idealized Bias Model with Current Sources

### Design Intent

To isolate the influence of the bias network and current mirror imperfections,
this version replaces the **current mirror with ideal current sources**.

The objectives were to:

- Decouple amplifier core behavior from bias circuitry
- Validate intrinsic gain, bandwidth, and stability of the signal path
- Establish reference performance targets independent of mirror mismatch

### Characteristics

- Ideal current sources used for biasing
- Simplified bias network
- Focus on small-signal and stability analysis

### Observed Limitations

- Unrealistic bias implementation
- No representation of matching, output resistance, or systematic offsets
- Not physically realizable in silicon

### Conclusion

This version was used strictly as a **simulation reference model** to understand
the theoretical performance limits of the amplifier core and was never intended
for physical implementation.

---

## 3. `amplifier_v2/` – Matched Current Mirror without Dummy Devices

### Design Intent

This iteration introduces **explicit current mirror device matching** in the
schematic, serving as a transition toward layout-aware design.

The objectives were to:

- Implement matched current mirror devices
- Improve bias stability and symmetry
- Prepare the design for full-custom layout

### Characteristics

- Matched current mirror transistor sizing
- Realistic bias network restored
- No dummy devices included at the schematic level

### Observed Limitations

- Edge effects and layout-dependent mismatch not yet addressed
- Susceptibility to systematic mismatch after layout
- Further refinement required for physical robustness

### Conclusion

This version represents a **pre-layout schematic refinement stage**, bridging
functional design and physical implementation. Dummy devices and layout-aware
techniques were incorporated in subsequent design stages.

---

## Design Evolution Summary

The archived versions reflect a **progressive analog design methodology**:

1. Functional topology validation (`amplifier/`)
2. Idealized performance benchmarking (`amplifier_sim/`)
3. Matching-aware schematic refinement (`amplifier_v2/`)
4. Final schematic and layout with matching and dummy devices (current version)

This staged approach reduced design risk and ensured that performance issues
were addressed systematically rather than empirically.

---

## Notes

These archived designs are retained to document the **design evolution and
engineering decision-making process**.  
They are not intended for reuse but serve as reference material supporting the
final implementation.

---

## Design Philosophy

This archive emphasizes a core principle of analog IC design:

> **Biasing integrity and device matching must be validated incrementally
before physical layout, rather than corrected post-layout.**
