.PHONY: default test

default:
	# available targets:
	#   test: run the theme in sddm-greeter test mode
	#   archlinux: create archlinux package

test:
	sddm-greeter --test-mode --theme src

archlinux:
	make -C dist/archlinux build
