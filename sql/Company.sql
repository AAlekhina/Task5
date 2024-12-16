MERGE INTO company
USING organisation
ON (SIMILARITY(company.company_code, organisation.company_code) > 0.7)   -----(company.company_code = organisation.company_code)
WHEN MATCHED THEN
    UPDATE SET
               currency = organisation.currency,
               company_id = organisation.company_id
WHEN NOT MATCHED THEN
    INSERT (company_code, company_id, currency)
    VALUES (
        organisation.company_code,
        organisation.company_id,
        organisation.currency
           );

