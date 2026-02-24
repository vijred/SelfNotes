# Accessing Your Linux Machine via WSL on Windows

## 1️⃣ Verify WSL Is Installed
Open **PowerShell** and run:

    wsl --status

If nothing appears, list installed distros:

    wsl -l -v

Example output:

      NAME      STATE           VERSION
    * Ubuntu    Stopped         2

------------------------------------------------------------------------

## 2️⃣ Start Your Linux Distribution

### Method A --- Start Menu

Open **Start Menu** → search for your distro (e.g., Ubuntu) → click it.

### Method B --- From PowerShell or Command Prompt

    wsl

If you have multiple distros:

    wsl -d Ubuntu

Replace `Ubuntu` with your distro name from `wsl -l -v`.

------------------------------------------------------------------------

## 3️⃣ Confirm You Are Inside Linux

You should see something like:

    username@DESKTOP-XYZ:~$

Run:

    uname -a

You should see `Linux` in the output.

------------------------------------------------------------------------

## 4️⃣ Access Linux Files from Windows

Linux filesystem is located at:

    \\wsl$

In File Explorer: 1. Open Explorer 2. Type `\\wsl$` in the address bar
3. Select your distro

------------------------------------------------------------------------

## 5️⃣ Access Windows Files from Linux

Inside WSL:

    cd /mnt/c

Example:

    cd /mnt/c/Users/YourWindowsUsername/Desktop

Windows drives are mounted as: - C → `/mnt/c` - D → `/mnt/d`

------------------------------------------------------------------------

## 6️⃣ If It Doesn't Start

Try:

    wsl --shutdown
    wsl

Or check if WSL feature is enabled:

    wsl --install
