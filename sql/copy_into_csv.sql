COPY sales_mart TO './mart.csv' WITH CSV HEADER;
COPY sales_mart TO '/home/user/work/DABI/Task4/mart.csv' WITH CSV HEADER;
COPY sales_mart TO  '/data/postgres/mart.csv' WITH CSV HEADER;
COPY status TO  '/data/postgres/status.csv' WITH CSV HEADER;
COPY company TO  '/data/postgres/company.csv' WITH CSV HEADER;
COPY iso TO  '/data/postgres/iso.csv' WITH CSV HEADER;

