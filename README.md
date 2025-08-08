# RAL-Based UVM Register Verification Project

## Project Overview

This project demonstrates a UVM (Universal Verification Methodology) testbench for verifying register interfaces using the RAL (Register Abstraction Layer) model. It includes:

- UVM register classes for modeling registers.
- Functional sequences for write, read, set, update, and reset.
- Coverage collection with field-level bins.
- Reset verification and RTL/RAL consistency checks.

## Specifications

[specification 1RAL.docx](https://github.com/user-attachments/files/21670269/specification.1RAL.docx)

## Test cases
Test Case 1: Register Write and Read via Frontdoor
Objective: Verify that all registers can be written and read using frontdoor access.

Test Case 2: Reset Value Check
Objective: Confirm the default reset value of each register matches the specification.

Test Case 3: Register Write and Read via Backdoor
Objective: Verify that all registers can be written and read using backdoor access.

## Result
Write and Read via Frontdoor

<img width="1232" height="362" alt="Screenshot 2025-08-07 130131" src="https://github.com/user-attachments/assets/ce181e2f-cd90-447a-b2bf-80f5ce8159ad" />

Reset Value Check

<img width="1228" height="409" alt="Screenshot 2025-08-07 130418" src="https://github.com/user-attachments/assets/3cb2280a-14cc-4674-bdea-e466536a2b71" />

Coverage Report

<img width="1067" height="548" alt="Screenshot 2025-08-07 125400" src="https://github.com/user-attachments/assets/b3217c28-43f2-4f43-8f0c-53975dad9d36" />













