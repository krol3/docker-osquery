ARG VERSION=latest
FROM $VERSION
LABEL maintener="Zach Wasserman <zwass@kolide.co>"

RUN curl -L https://pkg.osquery.io/rpm/GPG | tee /etc/pki/rpm-gpg/RPM-GPG-KEY-osquery
RUN yum-config-manager --add-repo https://pkg.osquery.io/rpm/osquery-s3-rpm.repo
RUN yum-config-manager --enable osquery-s3-rpm

RUN yum install -y osquery

# Copy the default osquery.conf (However, a custom conf should be specified
# with `docker run -v osquery.conf:/etc/osquery.conf zwass/osqueryd`
COPY osquery.example.conf /etc/osquery/osquery.conf

CMD ["osqueryd", "--config_path=/etc/osquery/osquery.conf", "--verbose"]
