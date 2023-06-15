REPO_NAME := $(shell basename `git rev-parse --show-toplevel` | tr '[:upper:]' '[:lower:]')
DOCKER_REGISTRY := mathematiguy
IMAGE := ${REPO_NAME}.sif
RUN ?= singularity exec ${FLAGS} --nv ${IMAGE}
FLAGS ?=  -B $$(pwd):/code --pwd /code
SINGULARITY_ARGS ?=

.PHONY: sandbox container shell root-shell docker docker-push docker-pull enter enter-root

assignment-4/article.pdf: assignment-4/article.tex
	${RUN} bash -c "cd assignment-4 && latexmk article.tex -pdf"

clean:
	cd assignment-4 && rm -f article.aux article.fls article.bbl article.log article.toc article.blg article.out article.pdf article.fdb_latexmk

REMOTE ?= cn-f001
push:
	rsync -rvahzP ${IMAGE} ${REMOTE}.server.mila.quebec:${SCRATCH}

container: ${IMAGE}
${IMAGE}:
	sudo singularity build ${IMAGE} ${SINGULARITY_ARGS} Singularity

shell:
	singularity shell ${FLAGS} ${IMAGE} ${SINGULARITY_ARGS}

root-shell:
	sudo singularity shell ${FLAGS} ${IMAGE} ${SINGULARITY_ARGS}
