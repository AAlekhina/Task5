CREATE TABLE sales_mart (
    id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES company(company_id),
    status_id INT REFERENCES status(status_id),
    iso_id INT REFERENCES iso(iso_id),
    project_id VARCHAR(25),
    currency VARCHAR(5),
    currency_rate DECIMAL(15, 2),
    sales_net_bud DECIMAL(15, 2),  -- Net Sale
    sales_net_for DECIMAL(15, 2),
    sales_net_act DECIMAL(15, 2),
    order_intake_bud3rd DECIMAL(15, 2),  -- Order Intake 3rd
    order_intake_for3rd DECIMAL(15, 2),
    order_intake_act3rd DECIMAL(15, 2),
    order_portfolio DECIMAL(15, 2),  -- Order portfolio
    gross_profit_bud DECIMAL(15, 2),  -- Growth Profit
    gross_profit_for DECIMAL(15, 2),
    gross_profit_act DECIMAL(15, 2),
    gross_profit_per_bud DECIMAL(15, 2),  -- Growth profit ib %
    gross_profit_per_for DECIMAL(15, 2),
    gross_profit_per_act DECIMAL(15, 2),
    report_date DATE  -- Date report
);


INSERT INTO sales_mart (
    company_id, status_id, iso_id, project_id, currency,
    sales_net_bud, sales_net_for, sales_net_act,
    order_intake_bud3rd, order_intake_for3rd, order_intake_act3rd,
    order_portfolio, gross_profit_bud, gross_profit_for, gross_profit_act,
    report_date
)
SELECT
    import.project_owner AS company_id,
    import.status_id AS status_id,
    import.iso_id AS iso_id,
    import.project_id AS project_id,
    import.currency AS currency,
    import.budcv AS sales_net_bud,
    import.forcv AS sales_net_for,
    import.actns AS sales_net_act,
    import.buddmc_3rd AS arder_intake_bud3rd,
    import.fordmc_3rd AS order_intake_for3rd,
    import.actdmc_3rd AS order_intake_act3rd,
    import.actobl AS order_portfolio,
    import.budgp AS gross_profit_bud,
    import.forgp AS gross_profit_for,
    import.actns - import.actpc AS gorss_profit_act,
    CURRENT_DATE AS report_date
FROM
    public.import import
LEFT JOIN company ON import.project_owner = company.company_id
LEFT JOIN iso ON import.iso_id = iso.iso_id;

UPDATE sales_mart s
SET currency_rate = COALESCE(
    (
        SELECT 1/averageexchangerate
        FROM exchange e
        WHERE e.transactioncurrencyname = s.currency
        AND EXTRACT(YEAR FROM DATE(e.periodid)) = EXTRACT(YEAR FROM DATE '2023-05-01')
        AND EXTRACT(MONTH FROM DATE(e.periodid)) = EXTRACT(MONTH FROM DATE '2023-05-01')
        LIMIT 1
    ),
    1
);
