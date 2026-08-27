PYTHON ?= python3

.PHONY: doctor-setup doctor-build doctor-test doctor-health doctor-env

doctor-setup:
	$(PYTHON) -m pip install -e .

doctor-build:
	$(PYTHON) -m pip check

doctor-test: doctor-health doctor-env

doctor-env:
	test -f .env.example
	$(PYTHON) -m unittest tests.test_env_example

doctor-health:
	$(PYTHON) -c "import urirun_node"
