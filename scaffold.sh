#!/usr/bin/env bash
set -euo pipefail

TARGET_PATH="${1:-.}"
mkdir -p "$TARGET_PATH"
ROOT="$(cd "$TARGET_PATH" && pwd)"

modules=(
  'Module 01 - Information Security Threats and Vulnerabilities'
  'Module 02 - Information Security Attacks'
  'Module 03 - Network Security Fundamentals'
  'Module 04 - Identification, Authentication and Authorization'
  'Module 05 - Network Security Controls - Administrative Controls'
  'Module 06 - Network Security Controls - Physical Controls'
  'Module 07 - Network Security Controls - Technical Controls'
  'Module 08 - Network Security Assessment Techniques and Tools'
  'Module 09 - Application Security'
  'Module 10 - Virtualization and Cloud Computing'
  'Module 11 - Wireless Network Security'
  'Module 12 - Mobile Device Security'
  'Module 13 - IoT and OT Security'
  'Module 14 - Cryptography'
  'Module 15 - Data Security'
  'Module 16 - Network Troubleshooting'
  'Module 17 - Network Traffic Monitoring'
  'Module 18 - Network Logs Monitoring and Analysis'
  'Module 19 - Incident Response'
  'Module 20 - Computer Forensics'
  'Module 21 - Business Continuity and Disaster Recovery'
  'Module 22 - Risk Management'
)

create_tracked_leaf() {
  local directory="$1"
  local description="$2"
  local placeholder="$directory/.gitkeep"

  mkdir -p "$directory"
  if [[ ! -e "$placeholder" ]]; then
    printf '# %s\n' "$description" > "$placeholder"
  fi
}

create_tracked_leaf "$ROOT/Wrap Up" 'Wrap-up materials and course completion notes.'

for module in "${modules[@]}"; do
  module_path="$ROOT/$module"
  mkdir -p "$module_path"

  create_tracked_leaf "$module_path/Notes" "Notes, summaries, and timestamp-linked cues for $module."
  create_tracked_leaf "$module_path/Labs" "Lab walkthroughs, screenshots, and configurations for $module."
  create_tracked_leaf "$module_path/Exercises" "Practice questions and review items for $module."
done

printf 'CCT study structure created under: %s\n' "$ROOT"
