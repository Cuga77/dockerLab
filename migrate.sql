CREATE TABLE client (
                        id VARCHAR(128) PRIMARY KEY NOT NULL,
                        balance NUMERIC(15, 2) DEFAULT 0 NOT NULL
);

CREATE TABLE reserve (
                         id BIGSERIAL PRIMARY KEY NOT NULL,
                         client_id VARCHAR(128) NOT NULL REFERENCES client(id) ON DELETE CASCADE,
                         service_id VARCHAR(128) NOT NULL,
                         order_id VARCHAR(128) NOT NULL,
                         price NUMERIC(15, 2) NOT NULL CHECK (price >= 0),
                         reserve_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE report (
                        id BIGSERIAL PRIMARY KEY NOT NULL,
                        client_id VARCHAR(128) NOT NULL REFERENCES client(id) ON DELETE CASCADE,
                        service_id VARCHAR(128) NOT NULL,
                        order_id VARCHAR(128) NOT NULL,
                        price NUMERIC(15, 2) NOT NULL CHECK (price >= 0),
                        report_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE client_sheet_change (
                                     id BIGSERIAL PRIMARY KEY NOT NULL,
                                     client_id VARCHAR(128) NOT NULL REFERENCES client(id) ON DELETE CASCADE,
                                     status INT CHECK (status IN (0, 1, -1)), -- 0: Neutral, 1: Positive, -1: Negative
                                     difference NUMERIC(15, 2) NOT NULL,
                                     change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
