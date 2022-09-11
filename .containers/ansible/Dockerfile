FROM python:slim

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    make \
    sshpass \
    ssh \
    python3-apt\
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir -U pip && \
    python3 -m pip install --no-cache-dir pipenv && \
    python3 -m pip install --no-cache-dir cryptography

# Activate virtualenv
RUN echo "if [[ -z \"\${VIRTUAL_ENV}\" ]]; then" >> /root/.bashrc && \
    echo "source \$(pipenv --venv)/bin/activate" >> /root/.bashrc && \
    echo "fi"                                    >> /root/.bashrc

# Entrypoint
COPY ./.containers/ansible/scripts/ /opt/bin
RUN chmod -R +x /opt/bin
ENTRYPOINT [ "/opt/bin/entrypoint.sh" ]
