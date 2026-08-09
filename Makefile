PYTHON ?= python3

.PHONY: doctor-setup doctor-build doctor-test doctor-health

doctor-setup:
	$(PYTHON) -m pip install -e .

doctor-build:
	$(PYTHON) -m pip check

doctor-test: doctor-health

doctor-health:
	$(PYTHON) -c "import urirun_node"
