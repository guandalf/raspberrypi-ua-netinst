# raspberrypi-ua-netinst v1.5.2
- support for Raspberry Pi Zero W
- added limitation of installer attempts/retries with visual LED notification
- add config editability with Windows editors
- added or changed configuration variables
  - support for USB audio
  - separate option to disable raspberry logos (no longer included in `quiet_boot`)
  - disable rainbow screen
  - disable overscan
  - disable screensaver (console blank timeout)
  - enable custom device tree overlays
**Bugfixes:**
- sha256sums generated file format
- possibly missing apt-transport-https
- improve log output

# raspberrypi-ua-netinst v1.5.1
- added or changed configuration variables
  - console mode as `final_action`
  - RTC support
  - **changed** `enable_watchdog` to `watchdog_enable`
- add apt config files
- use ntp client of systemd if available
- use mirrordirector for Raspbian packages
- support apt-cacher(-ng) for build- and/or installation process
- more stable build process
- improved log output
- improved module and driver loading for installer
- variable processing via conf file for build process

**Bugfixes:**
- wheezy installation
- config files in archive
- fix potentially wrong file permissions
- apt preferences files
- wifi for wheezy
- watchdog for wheezy

# raspberrypi-ua-netinst v1.5.0
**Very important note:**
This is a release with many big improvements and important changes!

If you are coming from an older version, **check your configuration options** to see if they need to be changed and note that the **customization files need to be placed in a new location**! Also check, if you still need the "post-install.txt".

- consolidated and **changed location of all** custom configuration and installer files
- changed handling of custom files, so the **"post-install.txt" is not required** any longer for this
- set F2FS as default root file system
- added or changed configuration variables
  - enable SPI and I²C (I2C)
  - configure I²C baudrate
  - wifi region
  - **changed** `root_ssh_allow` to `root_ssh_pwlogin`
  - disable SSH password login completely
  - HDMI settings
  - remove installer after success
  - remove installer log files after success
- added logrotate to default server packages
- allow providing SSH public keys as files
- retry downloads if errors occur
- added more timezones
- many more big and small backend improvements

**Bugfixes:**
- filtered unnecessary installer warnings
- enable devices even if a custom config.txt is used
- configure system default locale if `locales` option is not used

# raspberrypi-ua-netinst v1.4.1
- added configuration variables
  - set keyboard layout
- added method to set time with http
- dynamically add packages if needed by configuration variables
- added docs for configuration variables
- add hardware version 2 Model B+ (with BCM2837)

**Bugfixes:**
- locale selection
- backup kernel for reinstall (see #31 for workaround)

# raspberrypi-ua-netinst v1.3.0
- improvements and tests on model Zero (many thanks to @thijstriemstra)
- added support for many USB ethernet devices
- added core packages to improve GPIO support
- added support for onboard Bluetooth on model 3B

**Bugfixes:**
- locale selection
- serial port handling with Bluetooth on model 3B

# raspberrypi-ua-netinst v1.2.1
- added compatibility for onboard wireless lan with model 3B to get used by installer and system (no ethernet needed)
- added more configuration variables
  - allow user to access GPIOs
  - create/add user to (system) groups
  - permit/prevent root remote SSH login
  - ...
- accelerated boot when using custom network connection
- added serial console for model 3B
- added universal installer output to serial
- fix installation error handling
- minor fixes and improvements (output cleanup, code cleanup)
- improved quiet boot
- removed initramfs duality

**Bugfixes:**
- v1.2.0 build failed if git version had no tag

# raspberrypi-ua-netinst v1.1.1
This is a bugfix release.

- Fixed installer customization to enable audio
- Added ability to install Raspberry Pi tools like `vcgencmd`, `raspistill` and similar  
  (see #6 to patch existing systems)


# raspberrypi-ua-netinst v1.1.0
- added installer variable to enable audio
- added installer variable to enable camera module
- re-added installer variable to customize the amount of memory assigned to the GPU

# raspberrypi-ua-netinst v1.0.1
- default config.txt from raspbian added:  
  `dtparam=audio=on` is commented out