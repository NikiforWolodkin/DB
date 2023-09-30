ALTER SESSION SET "_oracle_script" = TRUE;
ALTER SESSION SET CONTAINER=VND_PDB;
ALTER PLUGGABLE DATABASE VND_PDB OPEN;

SELECT NAME, OPEN_MODE FROM V$PDBS;



CREATE TABLESPACE TS_VND
    DATAFILE 'TS_VND.dbf'
    SIZE 7M
    AUTOEXTEND ON NEXT 5M
    MAXSIZE 30M;
    
CREATE TEMPORARY TABLESPACE TS_VND_TEMP
    TEMPFILE 'TS_VND_TEMP.dbf'
    SIZE 5M
    AUTOEXTEND ON NEXT 3M
    MAXSIZE 20M;

CREATE ROLE RL_VND;

GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE
      TO RL_VND;
    
CREATE PROFILE PF_VND LIMIT
    PASSWORD_LIFE_TIME 180
    SESSIONS_PER_USER 3
    FAILED_LOGIN_ATTEMPTS 7
    PASSWORD_LOCK_TIME 1
    PASSWORD_REUSE_TIME 10
    PASSWORD_GRACE_TIME DEFAULT
    CONNECT_TIME 180
    IDLE_TIME 30;
    
CREATE USER U1_VND_PDB 
    IDENTIFIED BY pass
    DEFAULT TABLESPACE TS_VND
    TEMPORARY TABLESPACE TS_VND_TEMP
    PROFILE PF_VND
    ACCOUNT UNLOCK;
    
GRANT RL_VND TO U1_VND_PDB;

ALTER USER U1_VND_PDB QUOTA 2M ON TS_VND;