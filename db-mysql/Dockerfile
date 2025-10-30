FROM mysql:9.3

ENV MYSQL_ROOT_PASSWORD=fiap-soat11@pass
ENV MYSQL_DATABASE=fiap
ENV MYSQL_USER=user_fiap
ENV MYSQL_PASSWORD=pass_fiap

COPY ["init/sql/1_inicializacao.sql", "/docker-entrypoint-initdb.d/1_inicializacao.sql"]