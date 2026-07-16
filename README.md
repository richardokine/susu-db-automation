# Liatett Susu Enterprise – Automated DB Maintenance & Uptime Engine

A production-grade PowerShell automation utility engineered to maintain business continuity, execute disaster recovery routines, and enforce storage optimizations for a distributed financial database system.

## 📋 Context & Business Logic
During my tenure as IT Operations Manager at Liatett Susu Enterprise in Accra, Ghana, I was directly responsible for preserving a $\ge 99.9\%$ database uptime metric. This script was created to mitigate risk from two primary infrastructure vectors:
1. **Storage Exhaustion**: Preventing database locks caused by unchecked transaction logs filling server storage arrays.
2. **Hardware Reliability Deficits**: Running low-level diagnostics on physical server nodes before executing high-I/O operations.

## 🛠️ System Architecture & Workflow
The engine runs via a Windows Task Scheduler daemon and executes the following programmatic pipeline:
*   **Volumetric Storage Pre-Check**: Evaluates logic conditions where available storage space must be $>10\text{ GB}$ on the primary partition; otherwise, it halts execution to safeguard database stability.
*   **Atomic Backup Routine**: Initiates system native backup commands to generate time-stamped transaction images.
*   **Pruning & Lifecycle Management**: Implements a FIFO (First-In, First-Out) maintenance window, locating and permanently purging stale backup files older than 7 days.

## 🚀 How to Execute
1. Open PowerShell as an Administrator.
2. Initialize the execution environment:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope Process
   ```
3. Execute the daemon script:
   ```powershell
   .\SusuBackupEngine.ps1
   ```
