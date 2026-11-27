# Information Security Threats and Vulnerabilities
# Lab Manual

## OS Used / Lab Environment
- **Web Server** - Windows Server 2016 (`10.10.1.16`)
- **Admin Machine-1** - Windows 10 (Attacker / Analyst endpoint)
- **AD Domain Controller** - Windows Server (`CCT\Administrator`)
- **pfSense Firewall** - Kept running throughout all lab exercises

---

## Creating a Trojan

Tool used: **Theef RAT**
- **RAT:** Allows attackers to remotely control and monitor a compromised system via C2 hidden backdoor.

**Trojan behaviour**
- Cannot self-replicate.
- Cannot independently spread.
- Disguise themselves as legitimate files or applications.
- Require user interaction (e.g., downloading, installing, or executing).
- Commonly rely on social engineering to trick users into execution.

**Tasks**
I will call the **Windows Server** (`Web Server`) as the **victim** and the **Windows endpoint** (`Admin Machine-1`) as the **attacker machine**.

1. **On the Victim machine (`Web Server`)**
   Navigate to the Theef directory on the lab machine:
   `Z:\CCT Module 01 Information Security Threats and Vulnerabilities\Remote Access Trojans (RAT)\Theef`
   and run `Server210.exe`.
   ![Victim running Server210.exe](./lab-screenshots/lab1_01_victim_server210.jpg)

2. **On the Attacker machine (`Admin Machine-1`)**
   2.1. Navigate to:
   ```
   Z:\CCT-Tools\CCT Module 01 Information Security Threats and Vulnerabilities\Remote Access Trojans (RAT)\Theef
   ```
   and run `Client210.exe` to access the victim machine remotely.
   ![Attacker launching Client210.exe](./lab-screenshots/lab1_02_attacker_client210.jpg)
   This opens the Theef main window.
   
   2.2. Enter the victim's IP address (`10.10.1.16`), leave the default **Port** (`6703`) and **FTP** (`2968`) as they are, and click **Connect**.
   ![Entering victim IP and clicking Connect](./lab-screenshots/lab1_04_theef_connect_ip.jpg)
   Now a remote connection between the attacker and victim machines has been successfully established. Click the **Computer Information** icon at the bottom of the window.
   ![Remote connection established in Theef](./lab-screenshots/lab1_05_theef_connected.jpg)

3. **Gathering System Information (`Computer Information` menu)**
   Click **PC Details**, **OS Info**, **Home**, and **Network** to enumerate the victim system.
   ![Computer Information PC Details](./lab-screenshots/lab1_06_theef_pc_details.jpg)

   | Menu | Used to Collect |
   | --- | --- |
   | **PC Details** | Hardware specifications, CPU type, RAM capacity, system uptime, and local time. |
   | **OS Info** | Windows version, build number, service pack details, and registered user/organization information. |
   | **Home** | User profile directories, system paths (e.g., Windows and System32 directories), and home folder details. |
   | **Network** | Local IP address, MAC address, subnet mask, default gateway, DNS servers, and active network adapter details. |

4. **Remote Surveillance & Control (`Spy` icon)**
   Click the **Spy** icon to open remote monitoring and control options (**Screen Capture**, **Task Manager**, **Process Viewer**, **Services**, **Keylogger**, **Webcam**, **Passwords**, **Remote Prompt**, **IM Chat Spy**, and **Microphone**).
   ![Theef Spy menu options](./lab-screenshots/lab1_07_theef_spy_menu.jpg)

   - **Task Manager:** Select **Spy → Task Manager**, click **Refresh** to list running processes (`Caption` and `Handle`), select a process, and click **Close window** to terminate it remotely on the victim.
     ![Theef remote Task Manager](./lab-screenshots/lab1_08_theef_task_manager.jpg)
   - **Keylogger:** Select **Spy → Keylogger** and click the **Start** icon to begin recording keystrokes from the victim machine.
     ![Theef Keylogger popup and Start button](./lab-screenshots/lab1_09_theef_keylogger_start.jpg)
     Sensitive text typed on the victim machine (e.g., into a text document) appears in the attacker's **Keylogger [Started]** window in real time.
     ![Theef Keylogger captured keystrokes](./lab-screenshots/lab1_10_theef_keylogger_captured.jpg)

5. **Cleanup**
   - Close all open windows on both **Admin Machine-1** and **Web Server**, then turn off **Web Server**.

---

## Creating a Virus

Tool used: **JPS Virus Maker (`JPS.exe`, v4.0)**
- **Virus behaviour:**
  - Self-replicating program that attaches copies of itself to other executable code without the user's knowledge or consent.
  - Can damage files in a file system, reside in memory, infect the boot sector, or be encrypted.
  - Unlike a Trojan, a virus replicates itself (e.g., *n* times).

**Machines**
- **Attacker:** `Admin Machine-1`
- **Victim:** `AD Domain Controller`
**Tasks**
1. **Take a VM Snapshot (Precaution)**
   - Before infecting **AD Domain Controller**, we will select it in VMware Workstation and click **Take a snapshot of this virtual machine**.
     ![VMware Take Snapshot toolbar icon](./lab-screenshots/lab2_01_vmware_take_snapshot.jpg)
   - Name the snapshot (e.g., `Snapshot 1`) and click **Take Snapshot**, then power on **AD Domain Controller** (with **pfSense Firewall** and **Admin Machine-1** running).
     ![Take Snapshot dialog](./lab-screenshots/lab2_02_vmware_snapshot_dialog.jpg)

2. **Build the Virus (on `Admin Machine-1`)**
   - Navigate to `Z:\CCT-Tools\CCT Module 01 Information Security Threats and Vulnerabilities\Virus Maker\JPS Virus Maker` and run `JPS.exe`.
   - Select **Virus Options**: `Disable TaskManager`, `Disable Windows Update`, `Disable Control Panel`, `Disable Drives`, `Hide Windows Clock`, `Hide Desktop Icons`, `Enable Remote Desktop`, `Remove Bluetooth`, `Turn Off Windows Firewall`, `Turn Off Windows Defender`, and `Auto Startup`.
     ![JPS Virus Maker main options](./lab-screenshots/lab2_03_jps_options_pane1.jpg)
   - Ensure the **None** trigger radio button is selected, then click the right-arrow (`>`) button to configure extended options.
     ![JPS Virus Maker None trigger and right arrow](./lab-screenshots/lab2_04_jps_trigger_none.jpg)
   - In the extended **Virus Options** pane, set:
     - **Change Windows Password:** `Pa$$w0rd`
     - **Change Computer Name:** `Test`
     - **Enable Convert to Worm:** Worm Name `fedevi`, **Copy After:** `1` sec
     - **Change Icon:** `JPG Icon`
     - Architecture dropdown: `x86(32Bit)` → click **Create Virus!**.
     ![JPS Virus Maker extended options](./lab-screenshots/lab2_05_jps_options_pane2.jpg)
   - Click **OK** on the **Virus Created Successfull !** confirmation pop-up.
     ![Virus Created Successfull dialog](./lab-screenshots/lab2_06_jps_virus_created.jpg)
   - Confirm `Server.exe` is generated inside the `JPS Virus Maker` folder. (Attackers typically pack it with a binder/packager and deliver it via email, chat, or network share.)
     ![Generated Server.exe in folder](./lab-screenshots/lab2_07_jps_server_exe.jpg)

3. **Execute & Observe Impact (on `AD Domain Controller`)**
  open `Z:\CCT-Tools\CCT Module 01 Information Security Threats and Vulnerabilities\Virus Maker\JPS Virus Maker`, and double-click `Server.exe`.
     ![Victim executing Server.exe from mapped drive](./lab-screenshots/lab2_08_victim_run_server.jpg)
   - **Observed effects:**
     - The desktop screen becomes blank immediately upon execution.
       ![Victim desktop turns blank](./lab-screenshots/lab2_09_victim_blank_desktop.jpg)
     - After rebooting, logging in with the original password (`admin@123`) fails with *"The password is incorrect. Try again."* — only the virus-set password (`Pa$$w0rd`) works.
       ![Original password rejected after reboot](./lab-screenshots/lab2_10_victim_wrong_password.jpg)
     - Attempting to open disabled tools (such as **Task Manager**) shows *"Task Manager has been disabled by your administrator."*
       ![Task Manager disabled error](./lab-screenshots/lab2_11_victim_taskmgr_disabled.jpg)

4. **Cleanup**
   - Turn off **Admin Machine-1** and **AD Domain Controller**, then click **Revert this virtual machine to snapshot** to restore **AD Domain Controller** to its clean pre-infection state.
     ![Revert VM to snapshot](./lab-screenshots/lab2_12_vmware_revert_snapshot.jpg)

---

## Creating Worm

Tool used: **Internet Worm Maker Thing (`Generator.exe`, v4.00 Public Edition)**
- **Worm behaviour:**
  - Standalone malicious program that replicates, executes, and spreads across network connections **independently without human intervention**.
  - Does not require a host file to replicate (unlike a virus).
  - Can drop backdoors (creating zombie bots/botnets), disable antivirus/security controls, corrupt files, and compile batch/VBS worms into `.exe` to evade antivirus.

**Machine**
- `Web Server`

**Tasks**
1. **Launch the Worm Maker**
   - On **Web Server**, navigate to `Z:\CCT Module 01 Information Security Threats and Vulnerabilities\Worm Maker\Internet Worm Maker Thing` and run `Generator.exe`.
     ![Internet Worm Maker Thing folder and main window](./lab-screenshots/lab3_01_worm_maker_launch.jpg)

2. **Configure Worm Identity & Startup**
   - Enter **Worm Name:** `JB Worm`, **Author:** `Jason`, **Version:** `4.0`, **Message:** `Your System is Hacked`.
   - Check **Include [C] Notice**, set **Output Path:** `C:\`, check **Compile To EXE Support**, and check **English Startup**.
     ![Worm Maker identity and startup settings](./lab-screenshots/lab3_02_worm_identity_startup.jpg)

3. **Configure Payloads & System Interference**
   - Select **Activate Payloads On Date**, set **Chance of activating payloads:** `1 IN 5 CHANCE`, and check `Hide All Drives`, `Disable Task Manager`, `Disable Keybord`, `Disable Mouse`, `Message Box` (Title: `Hacked`, Message: `Your System is Hacked`, Icon: `Information`), `Disable Regedit`, `Disable Explorer.exe`, `Change Reg Owner` (`Jason`), and `Change Reg Organisation` (`Jason`).
     ![Worm Maker payloads configuration part 1](./lab-screenshots/lab3_03_worm_payloads_1.jpg)
   - Check `Change Homepage` & `Open Webpage` (`http://www.moviescope.com`), `Disable Windows Security`, `Disable Norton Security`, `Uninstall Norton Script Blocking`, `Disable Macro Security`, `Disable Run Commnd`, `Disable Shutdown`, `Disable Logoff`, `Disable Windows Update`, `No Search Command`, `Swap Mouse Buttons`, `Change IE Title Bar`, `Change Win Media Player Txt`, `Open Cd Drives`, `Lock Workstation`, and `Download File`.
     ![Worm Maker payloads configuration part 2](./lab-screenshots/lab3_04_worm_payloads_2.jpg)
   - Check `Print Message` (Title: `Hacked`, Message: `Your System is Hacked`), `Disable System Restore`, `Change NOD32 Text` (URL: `http://www.moviescope.com`, Sender Name: `Jason`), `Mute Speakers`, `Delete a File`, `Delete a Folder`, `Change Wallpaper`, `CPU Monster`, and `Change Time` (`1:15`).
     ![Worm Maker payloads configuration part 3](./lab-screenshots/lab3_05_worm_payloads_3.jpg)
   - Check `Change Date` (`11/08/21`), `Loop Sound`, `Hide Desktop`, `Disable Malware Remove`, `Disable Windows File Protection`, `Corrupt Antivirus`, `Change Computer Name`, `Change Drive Icon`, `Add To Context Menu`, `Change Clock Text`, `Keyboard Disco`, `Add To Favorites`, `Exploit Windows Admin Lockout Bug`, `Blue Screen Of Death`, **Infection Options:** `Infect Bat Files`, and **Extras:** `Hide Virus Files`.
     ![Worm Maker payloads configuration part 4](./lab-screenshots/lab3_06_worm_payloads_4.jpg)

4. **Generate the Worm**
   - Click **Generate Worm** under **Control Panel** → click **OK** on `Your new worm.vbs has been made!`.
     ![Worm generated confirmation dialog](./lab-screenshots/lab3_07_worm_created_popup.jpg)
   - Verify `worm.vbs` is saved at `C:\worm.vbs`. When executed on a target machine, all configured payloads take effect.
     ![Generated worm.vbs in C drive](./lab-screenshots/lab3_08_worm_vbs_output.jpg)

5. **Cleanup**
   - Close all windows and turn off **Web Server**.

---

## Using Spytech Spyagent

Tool used: **Spytech SpyAgent**
- **Spyware behaviour:**
  - Stealth monitoring and surveillance software that secretly records all user activities: keystrokes, emails, visited websites, chat conversations, file operations, program usage, and periodic screenshots.
  - Supports remote log delivery (email, FTP, HTTP, DNS, encrypted C2), content/application blocking, and lockdown scheduling.

**Machines**
- **Host / Attacker:** `AD Domain Controller` 
- **Target / Victim:** `Web Server` (`10.10.1.16`; RDP login `John` / `user@123`)

**Tasks**
1. **Connect via RDP & Stage SpyAgent (from `AD Domain Controller`)**
   - Open **Remote Desktop Connection**, click **Show Options**, enter **Computer:** `10.10.1.16` and **User name:** `John`, click **Connect**, and enter `user@123` .
     ![Remote Desktop Connection options](./lab-screenshots/lab4_01_rdp_options.jpg)
   - Minimize RDP, navigate to `Z:\CCT Module 01 Information Security Threats and Vulnerabilities\General Spyware`, and copy the **Spytech SpyAgent** folder.
     ![Spytech SpyAgent folder in General Spyware](./lab-screenshots/lab4_02_spyagent_folder.jpg)
   - Paste **Spytech SpyAgent** onto the target system's Desktop inside the RDP session.
     ![Spytech SpyAgent pasted on target Desktop](./lab-screenshots/lab4_03_spyagent_desktop_copy.jpg)

2. **Install & Enable Stealth Mode (on `Web Server` via RDP)**
   - Run `Setup` inside **Spytech SpyAgent** (installer password: `spytech`; UAC admin password: `admin@123`).
   - Select **Administrator/Tester** as the installation type, include the uninstaller, accept the antivirus notice, and finish with **Run SpyAgent** checked.
     ![Select SpyAgent Installation Type](./lab-screenshots/lab4_04_spyagent_install_type.jpg)
     ![SpyAgent Setup Finished](./lab-screenshots/lab4_05_spyagent_finished.jpg)
   - Set an access password  in **Step 1**.
     ![Setting SpyAgent access password](./lab-screenshots/lab4_06_spyagent_set_password.jpg)
   - In the **Easy Configuration and Setup Wizard**, select **Complete + Stealth Configuration** and check **Load on Windows Startup** under **Extras**.
     ![SpyAgent Complete + Stealth Configuration](./lab-screenshots/lab4_07_spyagent_stealth_wizard.jpg)
     ![SpyAgent Load on Windows Startup](./lab-screenshots/lab4_08_spyagent_startup_extra.jpg)
   - In the SpyAgent dashboard, click **Start Monitoring** (enter `test@123`).
     ![SpyAgent dashboard Start Monitoring](./lab-screenshots/lab4_09_spyagent_dashboard_start.jpg)
   - Read the **Stealth Notice** (**Hotkey to exit stealth mode:** `Ctrl+Shift+Alt+M`), suppress the startup help tips, delete the **Spytech SpyAgent** folder from the Desktop to hide tracks, and close RDP.
     ![SpyAgent Stealth Notice hotkey](./lab-screenshots/lab4_10_spyagent_stealth_notice.jpg)

3. **Simulate Victim Activity (on `Web Server`)**
   - Log in directly to **Web Server** as `john` (`user@123`).
   - Browse websites in Google Chrome (e.g., Gmail) and type sensitive information into Notepad (e.g., `Secret.txt`), then **Sign out**.

4. **Retrieve Captured Surveillance Logs (from `AD Domain Controller` via RDP)**
   - Reconnect via RDP to `10.10.1.16` as `John`, press **`Ctrl+Shift+Alt+M`**, and enter `test@123` to bring SpyAgent out of stealth mode.
     ![SpyAgent unhide password prompt](./lab-screenshots/lab4_11_spyagent_unhide_prompt.jpg)
   - Inspect recorded activity across SpyAgent's panels:
     - **Keyboard & Mouse → View Keystrokes Log:** Shows every keystroke typed, application, window title, user, timestamp, and associated screen snapshot.
       ![Keyboard and Mouse View Keystrokes Log](./lab-screenshots/lab4_12_spyagent_keystrokes_menu.jpg)
       ![Captured Keystrokes Typed log](./lab-screenshots/lab4_13_spyagent_keystrokes_log.jpg)
     - **Screenshots** (including **Email Activity**): Displays periodic desktop captures of browsing and Notepad sessions.
       ![SpyAgent Screenshot Viewer](./lab-screenshots/lab4_14_spyagent_screenshots.jpg)
     - **Events Timeline:** Chronological log of websites visited, files created/deleted, programs started/closed, and windows viewed.
       ![SpyAgent Events Timeline](./lab-screenshots/lab4_15_spyagent_events_timeline.jpg)

5. **Cleanup**
   - Close all open windows, disconnect RDP, and turn off **AD Domain Controller** and **Web Server**.

---

## Find Vulnerabilities on Exploit Sites

Tool / Site used: **Exploit Database (`https://www.exploit-db.com/`)**
- **Purpose:**
  - Vulnerability research analyzes protocols, services, and configurations to identify flaws before exploitation.
  - Exploit databases index known vulnerabilities and public Proof-of-Concept (PoC) exploits by CVE, platform, and exploit type (and can be paired with tools like Metasploit during authorized security testing).

**Machine**
- `Admin Machine-1` (`Admin` / `admin@123`) 

**Tasks**
1. **Browse & Search Exploit-DB**
   - Open **Mozilla Firefox** and navigate to `https://www.exploit-db.com/` to view recent exploits.
     ![Exploit Database homepage](./lab-screenshots/lab5_01_exploitdb_home.jpg)
   - Open the left sidebar and click **SEARCH EDB** (`https://www.exploit-db.com/search`).
     ![Exploit Database sidebar SEARCH EDB](./lab-screenshots/lab5_02_exploitdb_sidebar_search.jpg)
   - In **Exploit Database Advanced Search**, filter by **Type:** `remote` and **Platform:** `Windows_x86-64` (plus optional `Title`, `CVE`, `Port`, `Author`, `Tag`, `Verified`, `Has App`, or `No Metasploit`), then click **Search**.
     ![Exploit Database Advanced Search filters](./lab-screenshots/lab5_03_exploitdb_advanced_search.jpg)

2. **Inspect & Download an Exploit**
   - From the search results, click **CloudMe Sync 1.11.2 Buffer Overflow - WoW64 (DEP Bypass)**.
     ![Exploit Database search results](./lab-screenshots/lab5_04_exploitdb_results.jpg)
   - Review its metadata (**EDB-ID:** `46250`, **CVE:** `2018-6892`, **Type:** `REMOTE`, **Platform:** `WINDOWS_X86-64`, **Date:** `2019-01-28`) and click the **Download** icon to save `46250.py` to `Downloads`.
     ![Exploit details and download icon](./lab-screenshots/lab5_05_exploitdb_detail.jpg)

3. **Analyze the Exploit Code**
   - Navigate to `Downloads`, right-click `46250.py`, and select **Edit with Notepad++**.
     ![Right-click Edit with Notepad++](./lab-screenshots/lab5_06_exploit_edit_notepadpp.jpg)
   - Inspect the Python PoC exploit code (target software version, tested OS, CVE reference, ROP chain, and payload structure).
     ![Exploit code opened in Notepad++](./lab-screenshots/lab5_07_exploit_code_notepadpp.jpg)


## Summary

### Creating a Trojan (Theef RAT)
1. **Launch Server:** Execute `Server210.exe` on the victim machine.
2. **Launch Client:** Run `Client210.exe` on the attacker machine.
3. **Establish Connection:** Enter the victim IP and connect using the default ports.
4. **Gather Information:** Retrieve PC details, OS information, user directories, and network configuration.
5. **Remote Monitoring:** Explore process management, screen capture, and keylogging capabilities.
6. **Cleanup:** Close applications and shut down the victim machine.

### Creating a Virus (JPS Virus Maker)
1. **Take Snapshot:** Create a VMware snapshot to restore the victim system.
2. **Configure Virus:** Launch JPS Virus Maker and select the available system modification options.
3. **Generate Virus:** Create the executable payload (`Server.exe`).
4. **Execute Payload:** Run the generated executable on the victim machine.
5. **Observe Impact:** Examine desktop changes, disabled system utilities, and password modification.
6. **Cleanup:** Revert the virtual machine to its original snapshot.

### Creating a Worm (Internet Worm Maker Thing)
1. **Launch Tool:** Run `Generator.exe` on the Web Server.
2. **Configure Identity:** Define the worm name, author, version, and startup information.
3. **Configure Payloads:** Explore available system modification, security disabling, and disruption options.
4. **Generate Worm:** Create the worm executable/script (`worm.vbs`).
5. **Verify Output:** Confirm that the generated file exists.
6. **Cleanup:** Close applications and shut down the Web Server.

### Using Spytech SpyAgent
1. **Establish RDP Connection:** Connect to the Web Server from the AD Domain Controller.
2. **Transfer Tool:** Copy Spytech SpyAgent to the target machine.
3. **Install SpyAgent:** Complete installation and configure monitoring settings.
4. **Enable Monitoring:** Start monitoring and configure stealth mode.
5. **Simulate Activity:** Perform browsing and typing activities on the target machine.
6. **Retrieve Logs:** Review captured keystrokes, screenshots, email activity, and event timelines.
7. **Cleanup:** Close applications, disconnect RDP, and shut down the lab machines.

### Finding Vulnerabilities on Exploit Sites
1. **Access Exploit-DB:** Visit [Exploit-DB](https://www.exploit-db.com/).
2. **Search Exploits:** Use advanced search filters to identify remote Windows exploits.
3. **Select Exploit:** Locate the CloudMe Sync 1.11.2 Buffer Overflow exploit.
4. **Review Details:** Examine its EDB-ID, CVE reference, platform, exploit type, and publication date.
5. **Download PoC:** Download the corresponding Python exploit file (`46250.py`).
6. **Analyze Code:** Inspect the exploit's target version, operating system, ROP chain, and payload structure.

###  Conclusion

The exercises demonstrated how Trojans, viruses, worms, and spyware compromise systems through unauthorized access, replication, surveillance, and system modification. The final exercise introduced vulnerability discovery and Proof-of-Concept analysis using Exploit-DB. These activities reinforced the importance of malware detection, vulnerability assessment, system hardening, and defensive security monitoring.

