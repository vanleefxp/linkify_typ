CURRENT_DIR := $(dir $(MAKEFILE_LIST))

pack:
	@cd $(CURRENT_DIR)
	py -3.14 "./typacker.py" export
	py -3.14 "./typacker.py" doc
	py -3.14 "./typacker.py" copy