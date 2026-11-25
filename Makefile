PYTHON ?= python3
VENV ?= .doctor-venv

.PHONY: doctor-setup doctor-build doctor-test doctor-health doctor-env

doctor-setup:
	$(PYTHON) -m pip install -e .

# Hermetic dependency consistency check: install this project (and only its
# declared dependencies) into a throwaway virtualenv so unrelated packages
# in the ambient environment cannot break the build.
doctor-build:
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/python -m pip install --quiet --upgrade pip
	$(VENV)/bin/python -m pip install --quiet .
	$(VENV)/bin/python -m pip check
	rm -rf $(VENV)

doctor-test: doctor-health doctor-env

doctor-env:
	test -f .env.example
	$(PYTHON) -m unittest tests.test_env_example

doctor-health:
	$(PYTHON) -c "import urirun_node"
