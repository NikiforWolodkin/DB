CREATE TABLE VND_T2 (ID NUMBER);

INSERT INTO VND_T2 VALUES (10);
COMMIT;

SELECT * FROM VND_T2;

SELECT DISTINCT OBJECT_NAME FROM ALL_OBJECTS WHERE OBJECT_TYPE = 'TABLE';