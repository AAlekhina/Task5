CREATE TABLE import
(
    id SERIAL PRIMARY KEY,
    project_owner BIGINT,
    product_id BIGINT,
    project_type VARCHAR(5),
    iso_id INT,
    project_id VARCHAR(25),
    currency VARCHAR(5),
    status_id      INT,
    date_close DATE,
    date_sign DATE,
    budcv      DECIMAL(15, 2),
    buddmc_3rd DECIMAL(15, 2),
    buddmc_ic DECIMAL(15,2),
    buddmc_int DECIMAL(15,2),
    buddmc DECIMAL(15,2),
    budtsc DECIMAL(15,2),
    budtrc DECIMAL(15,2),
    budinc DECIMAL(15,2),
    budtse DECIMAL(15,2),
    budpmc DECIMAL(15,2),
    budoc DECIMAL(15,2),
    budpc DECIMAL(15,2),
    budgp DECIMAL(15,2),
    budgp_per DECIMAL(5,2),
    forcv DECIMAL(15,2),
    fordmc_3rd DECIMAL(15, 2),
    fordmc_ic DECIMAL(15,2),
    fordmc_int DECIMAL(15,2),
    fordmc DECIMAL(15,2),
    fortsc DECIMAL(15,2),
    fortrc DECIMAL(15,2),
    forinc DECIMAL(15,2),
    fortse DECIMAL(15,2),
    forpmc DECIMAL(15,2),
    foroc DECIMAL(15,2),
    forpc DECIMAL(15,2),
    forgp DECIMAL(15,2),
    forgp_per DECIMAL(15,2),
    actis DECIMAL(15,2) DEFAULT 0,
    actdmc_3rd DECIMAL(15, 2) DEFAULT 0,
    actdmc_ic DECIMAL(15,2) DEFAULT 0,
    actdmc_int DECIMAL(15,2) DEFAULT 0,
    actdmc DECIMAL(15,2) DEFAULT 0,
    acttsc DECIMAL(15,2) DEFAULT 0,
    acttrc DECIMAL(15,2) DEFAULT 0,
    actinc DECIMAL(15,2) DEFAULT 0,
    acttse DECIMAL(15,2) DEFAULT 0,
    actpmc DECIMAL(15,2) DEFAULT 0,
    actoc DECIMAL(15,2) DEFAULT 0,
    actpc DECIMAL(15,2) DEFAULT 0,
    actns DECIMAL(15,2) DEFAULT 0,
    actsc_per DECIMAL(15,2) DEFAULT 0,
    actsp DECIMAL(15,2) DEFAULT 0,
    actsl DECIMAL(15,2) DEFAULT 0,
    actgc DECIMAL(15,2) DEFAULT 0,
    actgp DECIMAL(15,2) DEFAULT 0,
    actnv DECIMAL(15,2) DEFAULT 0,
    act1280 DECIMAL(15,2) DEFAULT 0,
    act2280 DECIMAL(15,2) DEFAULT 0,
    actsti DECIMAL(15,2) DEFAULT 0,
    actobl DECIMAL(15,2) DEFAULT 0
);

-- Insert data
INSERT INTO import (project_id, status_id, budcv, buddmc_3rd, buddmc_ic, buddmc_int, buddmc, budtsc, budtrc, budinc, budtse,
                    budpmc, budoc, budpc, budgp, budgp_per,
                    forcv, fordmc_3rd, fordmc_ic, fordmc_int, fordmc, fortsc, fortrc, forinc, fortse, forpmc, foroc,forpc,
                    forgp, forgp_per,
                    actis, actdmc_3rd, actdmc_ic, actdmc_int, actdmc, acttsc, acttrc, actinc, acttse, actpmc, actoc, actpc
                    )
SELECT
    di.project_id,
    CASE
        WHEN p_sta = 'Open' THEN 1
        WHEN p_sta = 'Closed' THEN 2
        ELSE NULL
    END AS status_id,
    di.budcv,
    di.buddmc_3rd,
    di.buddmc_ic,
    di.buddmc_int,
    (buddmc_3rd + buddmc_ic + buddmc_int) AS buddmc,
    (budtsc_3rd + budtsc_ic + budtsc_int) AS budtsc,
    (budtrc_3rd + budtrc_ic + budtrc_int) AS budtrc,
    (budinc_3rd + budinc_ic + budinc_int) AS budinc,
    (budtse_3rd + budtse_ic + budtse_int) AS budtse,
    budpmc,
    (budtra+budcom+budlic+budoth) AS budoc,
    (buddmc+budtsc+budtrc+budinc+budtse+budpmc+budoc) AS budpc,
    (budcv-budpc) AS budgp,
    CASE
        WHEN budcv = 0 THEN 0
        ELSE ((budcv - budpc) / budcv * 100)
    END AS budgp_per,
    forcv,
    fordmc_3rd,
    fordmc_ic,
    fordmc_int,
    (fordmc_3rd + fordmc_ic + fordmc_int) AS fordmc,
    (fortsc_3rd + fortsc_ic + fortsc_int) AS fortsc,
    (fortrc_3rd + fortrc_ic + fortrc_int) AS fortrc,
    (forinc_3rd + forinc_ic + forinc_int) AS forinc,
    (fortse_3rd + fortse_ic + fortse_int) AS fortse,
    forpmc,
    (fortra+forcom+forlic+foroth) AS foroc,
    (fordmc+fortsc+fortrc+forinc+fortse+forpmc+foroc) AS forpc,
    (forcv-forpc) AS forgp,
    CASE
        WHEN forcv = 0 THEN 0
        ELSE ((forcv - forpc) / forcv * 100)
    END AS forgp_per,
    actis AS actis,
    actdmc_3rd AS actdmc_3rd,
    actdmc_ic AS actdmc_ic,
    actdmc_int AS actdmc_int,
    (actdmc_3rd + actdmc_ic + actdmc_int) AS actdmc,
    (acttsc_3rd + acttsc_ic + acttsc_int) AS acttsc,
    (acttrc_3rd + acttrc_ic + acttrc_int) AS acttrc,
    (actinc_3rd + actinc_ic + actinc_int) AS actinc,
    (acttse_3rd + acttse_ic + acttse_int) AS acttse,
    actpmc AS actpmc,
    (acttra+actcom+actlic+actoth) AS actoc,
    (actdmc+acttsc+acttrc+actinc+acttse+actpmc+actoc) AS actpc
FROM data_input  AS di;

---- Update - calculate fields
DO $$
DECLARE
    SoL decimal(15,2):= 1;
    SoP decimal(15,2):= 0.95;
BEGIN
        UPDATE import
        SET
            actsc_per = CASE
                            WHEN forpc <> 0 THEN actpc / forpc
                            ELSE 0
                        END;

        UPDATE import
        SET
            actsp = CASE
                        WHEN (status_id = 1 AND forgp > 0) THEN forgp * 0.95 * actsc_per
                        WHEN (status_id = 2 AND forgp > 0) THEN forgp * 1 * actsc_per
                        ELSE 0
                    END,
            actsl = CASE
                        WHEN forgp < 0 THEN forgp * SoL
                        ELSE 0
                    END;

        UPDATE import
        SET
            actns = actpc + actsp + actsl,
            actgc = actpc + actsp,
            actgp = actis + actsl,
            actnv = actgc - actgp,
            act1280 = CASE
                        WHEN actnv > 0 THEN actnv
                        ELSE 0
                      END,
            act2280 = CASE
                        WHEN actnv < 0 THEN -1*actnv
                        ELSE 0
                      END,
            actsti = CASE
                        WHEN (forcv - actsti) < 0 THEN 0
                        ELSE (forcv - actsti)
                     END,
            actobl = CASE
                        WHEN actsc_per > 1 THEN  0
                        ELSE (forcv - actsc_per * forcv)
                     END;
END $$; LANGUAGE PLPGSQL;

