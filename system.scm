(use-modules (gnu))
(use-service-modules networking)
(use-package-modules package-management)

(operating-system

	(host-name "main-host")
	(locale "en_US.utf8")
	(timezone "Asia/Yekaterinburg")
	(keyboard-layout
		(keyboard-layout "us" "altgr-intl"))

	(users
		(cons* (user-account
							(name "serjleks")
							(comment "Sergei Aleksandrov")
							(group "users")
							(home-directory "/home/serjleks")
							(supplementary-groups
								'("wheel" "netdev" "audio" "video")))
						%base-user-accounts))

	(packages
		(append
			(list (specification->package "nss-certs")
						vim htop mc ncdu nano)
			%base-packages))

	(services %base-services)

	(bootloader
		(bootloader-configuration
			(bootloader grub-efi-bootloader)
			(target "/boot/efi")
			(keyboard-layout keyboard-layout)))

	(swap-devices
		(list (file-system-label "swap")))

	(file-systems
		(cons*
					(file-system
						(mount-point "/boot/efi")
						(type "vfat")
						(device
							(file-system-label "efi")))
					(file-system
						(mount-point "/")
						(type "ext4")
						(device
							(file-system-label "guix")))
					%base-file-systems)))
