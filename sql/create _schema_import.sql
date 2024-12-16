----- Create Primary key
ALTER TABLE company
ADD CONSTRAINT pk_company_no PRIMARY KEY (company_id);

ALTER TABLE status
ADD CONSTRAINT pk_status PRIMARY KEY (status_id);

ALTER TABLE iso
DROP CONSTRAINT pk_iso;

ALTER TABLE iso
ADD CONSTRAINT pk_iso PRIMARY KEY (iso_id);

ALTER TABLE prg
ADD CONSTRAINT pk_product PRIMARY KEY (product_group_id);



---------CREATE foreign key for import
ALTER TABLE import
ADD CONSTRAINT fk_import_owner
FOREIGN KEY (project_owner)
REFERENCES company(company_id);

ALTER TABLE import
ADD CONSTRAINT fk_import_status
FOREIGN KEY (status_id)
REFERENCES status(status_id);

ALTER TABLE import
ADD CONSTRAINT fk_iso
FOREIGN KEY (iso_id)
REFERENCES iso(iso_id);


ALTER TABLE import
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES prg(product_group_id);

ALTER TABLE organisation
ADD CONSTRAINT pk_currency PRIMARY KEY (currency);

