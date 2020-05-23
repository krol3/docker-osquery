VERSION = "latest"
USER=krol
PROJECT = osquery
REPOSITORY=${USER}/${PROJECT}
# OS Version

# Image tags
UBUNTU14 = 14.04
UBUNTU16 = 16.04
UBUNTU18 = 18.04
UBUNTU20 = 20.04
CENTOS7 = 7
CENTOS8 = 8

define build_osquery
  echo ${1}/${2}/${3}
	cd ${1} && docker build -t ${REPOSITORY}:latest --build-arg VERSION=${2}:${3} .
	$(eval VERSION="$(shell docker run --rm ${REPOSITORY}:latest osqueryd --version|sed 's/osqueryd version //g')")
	docker tag ${REPOSITORY}:latest ${REPOSITORY}:${VERSION}-${2}${3}
	docker push ${REPOSITORY}:${VERSION}-${2}${3}
endef

run:
	docker run --rm ${REPOSITORY}:latest osqueryd --version

all:
	$(call build_osquery, 'ubuntu-osquery',ubuntu,${UBUNTU14})
	$(call build_osquery, 'ubuntu-osquery',ubuntu,${UBUNTU16})
	$(call build_osquery, 'ubuntu-osquery',ubuntu,${UBUNTU18})
	$(call build_osquery, 'ubuntu-osquery',ubuntu,${UBUNTU20})
	$(call build_osquery, 'centos-osquery',centos,${CENTOS7})
#	$(call build_osquery, 'centos-osquery',centos,${CENTOS8})

