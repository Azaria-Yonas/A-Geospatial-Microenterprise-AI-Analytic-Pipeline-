CREATE TABLE requests(
    index_num BIGSERIAL NOT NULL,
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    zcta INT REFERENCES zcta(zcta),

    api VARCHAR(8) NOT NULL CHECK (api IN ('places','overpass','arcgis','census')),
    endpoint VARCHAR,
    method VARCHAR(4) NOT NULL CHECK (method IN ('POST','GET')),


    headers JSONB,
    body JSONB,
     
    status_code INT,
    error_message TEXT,

    date_time TIMESTAMPTZ DEFAULT now()
);


CREATE INDEX requests_zcta_and_api ON requests(zcta, api);
CREATE INDEX requests_status_code ON requests(status_code);
CREATE INDEX requests_date_time ON requests(date_time);
