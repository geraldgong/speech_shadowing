SHELL := /usr/bin/env bash

#######
# Help
#######

.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sorted(sys.stdin):
    match = re.match(r'^([$()a-zA-Z_-]+):.*?## (.*)$$', line)
    if match:
        target, help = match.groups()
        print("%-20s %s" % (target, help))

endef
export PRINT_HELP_PYSCRIPT

help:
	@ python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

###################
# Conda Enviroment
###################

PY_VERSION := 3.6
CONDA_ENV_NAME ?= conda_env_shadow
CONDA_ENV_HDFS_PATH ?= /user/$(USER)/conda-envs/
ACTIVATE_ENV = conda activate ./$(CONDA_ENV_NAME)

.PHONY: conda-env-build
conda-env-build: $(CONDA_ENV_NAME)  ## Build the conda environment
$(CONDA_ENV_NAME):
	conda create -p $(CONDA_ENV_NAME)  --copy -y  python=$(PY_VERSION)
	$(ACTIVATE_ENV) && python -s -m pip install -r requirements.txt
	

.PHONY: register-env-in-jupyter
register-env-in-jupyter: ## Make our conda env available from Jupyter
	$(ACTIVATE_ENV) && python -s -m ipykernel install --user --name $(CONDA_ENV_NAME)
