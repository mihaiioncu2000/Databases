DROP TABLE vehicol;
CREATE TABLE vehicol(
NR_VEHICOL int NOT NULL PRIMARY KEY,
MARCA VARCHAR(50) NOT NULL,
TIP varchar(50) NOT NULL,
SERIE_MOTOR varchar(50) NOT NULL,
SERIE_CAROSERIE varchar(50)NOT NULL,
CARBURANT varchar(50) NOT NULL,
CULOARE varchar(50) NOT NULL,
CAPACITATE_CIL int NOT NULL
);

DROP TABLE tip_masina;
CREATE TABLE tip_masina(
TIP varchar(50) NOT NULL PRIMARY KEY,
COMENTARII varchar(300)
);


ALTER TABLE vehicol ADD CONSTRAINT fk_vehicol FOREIGN KEY(TIP) REFERENCES tip_masina(TIP);

DROP TABLE proprietate;
CREATE TABLE proprietate(
CNP varchar(13) NOT NULL ,
NR_VEHICOL int NOT NULL,
DATA_CUMPARARII date NOT NULL,
PRET int not null,
CONSTRAINT fk1 PRIMARY KEY (nr_vehicol)
);

DROP TABLE persoana;
CREATE TABLE persoana(
NUME  varchar(20) NOT NULL ,
PRENUME  varchar(20) NOT NULL ,
CARTE_IDENTITATE varchar(2) NOT NULL,
CNP varchar(13) NOT NULL,
ADRESA varchar(200),
CONSTRAINT fk2 PRIMARY KEY (cnp)
);

ALTER TABLE proprietate ADD CONSTRAINT fk1_vehicol FOREIGN KEY(NR_VEHICOL) REFERENCES vehicol(NR_VEHICOL);
ALTER TABLE proprietate ADD CONSTRAINT fk2_vehicol FOREIGN KEY(CNP) REFERENCES persoana(CNP);

INSERT INTO tip_masina VALUES ('A','Stare buna');
INSERT INTO tip_masina VALUES ('B','Stare buna');
INSERT INTO tip_masina VALUES ('C','Stare medie');
INSERT INTO tip_masina VALUES ('D','Stare rea');
INSERT INTO tip_masina VALUES ('E','Stare buna');
INSERT INTO tip_masina VALUES ('F','Stare medie');
INSERT INTO tip_masina VALUES ('G','Stare buna');
INSERT INTO tip_masina VALUES ('H','Stare rea');
INSERT INTO tip_masina VALUES ('I','Stare buna');
INSERT INTO tip_masina VALUES ('J','Stare buna');
INSERT INTO tip_masina VALUES ('K','Stare buna');
INSERT INTO tip_masina VALUES ('L','Stare rea');


INSERT INTO vehicol VALUES (1,'Dacia','A','EURONORM EG 88/436/EW G','C16NZ_02A12345','Motorina Standard','Negru',2);
INSERT INTO vehicol VALUES (2,'BMW','B','GM Holden ADR 37','A324N_321BA5','Gaz','Rosu',2);
INSERT INTO vehicol VALUES (3,'Mazda','C','EG 91','B72AR_4651AS','Efix Benz95','Ablastru',3);
INSERT INTO vehicol VALUES (4,'Fiat','D','441EW','B99BN_LA982','Rompetrol Gazx87','Galben',4);
INSERT INTO vehicol VALUES (5,'Renaul','E','US83','BERNS_9091','Motorina Standard','Negru',1);
INSERT INTO vehicol VALUES (6,'Renaul','F','RB99','HJOS-32AS','Benzina Extra99','Alb',2);
INSERT INTO vehicol VALUES (7,'Dacia','G','SSU83','FOLS-9999','Benzina ExtraS+','Portocaliu',2);
INSERT INTO vehicol VALUES (8,'Golf','H','AXU8MD','HOLMS11','Gaz','Negru',3);
INSERT INTO vehicol VALUES (9,'Renaul','I','MMDS00','CHEMP-121','Benzina Standard','Alb',1);
INSERT INTO vehicol VALUES (10,'Aston Martin','J','KENCH1','TROK90','EKTO PLUS95','Rosu',2);
INSERT INTO vehicol VALUES (11,'Honda','K','COLT45','FER15','MOTORINA AURO-L','Rosu',2);
INSERT INTO vehicol VALUES (12,'Mitsubisi','L','NZ_02A','436EW','MOTORINA Diesel','Albastru',2);




INSERT INTO persoana VALUES ('Petre','Dorin','AB','8235869972397','Strada Valea Rosie');
INSERT INTO persoana VALUES ('Dunca','Razvan','BC','0679950382296','Vasile Alecsandri');
INSERT INTO persoana VALUES ('Alex','Floare','DE','2574148488467','Mihai Eminescu');
INSERT INTO persoana VALUES ('Leontin','Cristian','EF','7838188938623','Strada Nicolae Iorga');
INSERT INTO persoana VALUES ('Prodan','Mihai','FG','8402367157484','Strada Rovine');
INSERT INTO persoana VALUES ('Petre','Alex','CD','7518303147184','Strada Peter');
INSERT INTO persoana VALUES ('Ciurel','Florentin','GH','2658955836358','Strada Florilor');
INSERT INTO persoana VALUES ('Spinu','Viorel','HI','5195414694941','Strada Ciuperca');
INSERT INTO persoana VALUES ('Deleu','Sanda','IJ','6639846381756','Strada Ion Creanga');
INSERT INTO persoana VALUES ('Nunca','Vladimir','JK','2216399863225','Strada Piata Unirii');
INSERT INTO persoana VALUES ('Nunca','Vladimir','JK','4301247206814','Strada Piata Unirii');
INSERT INTO persoana VALUES ('Nunca','Vladimir','JK','2377608378950','Strada Piata Unirii');

INSERT INTO proprietate VALUES ('8235869972397',1,'14-APR-2015',4000);
INSERT INTO proprietate VALUES ('0679950382296',2,'15-JAN-1989',4525);
INSERT INTO proprietate VALUES ('2574148488467',3,'3-JUN-1995',8000);
INSERT INTO proprietate VALUES ('7838188938623',4,'12-JUN-2000',7000);
INSERT INTO proprietate VALUES ('8402367157484',5,'12-JUL-2003',5500);
INSERT INTO proprietate VALUES ('7518303147184',6,'12-SEP-2005',5700);
INSERT INTO proprietate VALUES ('2658955836358',7,'24-OCT-1997',6000);
INSERT INTO proprietate VALUES ('5195414694941',8,'27-NOV-1998',9200);
INSERT INTO proprietate VALUES ('6639846381756',9,'15-APR-1998',7500);
INSERT INTO proprietate VALUES ('2216399863225',10,'13-MAY-1999',4500);
INSERT INTO proprietate VALUES ('4301247206814',11,'16-MAY-1999',6200);
INSERT INTO proprietate VALUES ('4301247206814',12,'19-MAY-1999',5000);


--2 afisam  numarul de marci si numarul masinilor cu marcile respective
SELECT vehicol.NR_VEHICOL, vehicol.MARCA FROM vehicol,proprietate
WHERE
vehicol.NR_VEHICOL=proprietate.NR_VEHICOL
SELECT COUNT(DISTINCT vehicol.MARCA) FROM vehicol,proprietate WHERE vehicol.NR_VEHICOL=proprietate.NR_VEHICOL;
SELECT MARCA,COUNT(MARCA) from vehicol group by MARCA 

--3 afisam marcile fiecarei masini si afisam suma acestora
SELECT vehicol.MARCA, SUM(proprietate.PRET) FROM vehicol,proprietate
WHERE  vehicol.NR_VEHICOL=proprietate.NR_VEHICOL
GROUP BY vehicol.MARCA


--4 CREAM PROCEDURA PRET care va efectua un calcul a numarului si pretului mediu al masinilor de marca Ford
DROP PROCEDURE PRET
GO
CREATE PROCEDURE PRET
AS SELECT COUNT(vehicol.MARCA),AVG(proprietate.PRET) FROM vehicol,proprietate
WHERE proprietate.NR_VEHICOL=vehicol.NR_VEHICOL and vehicol.MARCA='Renaul'
EXEC PRET

SELECT COUNT(vehicol.MARCA),AVG(proprietate.PRET) FROM vehicol,proprietate
WHERE proprietate.NR_VEHICOL=vehicol.NR_VEHICOL and vehicol.MARCA='Renaul'
--o sa afisam si rezultatul unei asemenea proceduri

--5 afisam marca si datele persoanei care are in proprietate masina cea mai scumpa
SELECT vehicol.MARCA,persoana.CNP,proprietate.PRET from vehicol,proprietate,persoana
WHERE PRET=(SELECT DISTINCT MAX(PRET) FROM proprietate) and
persoana.CNP=proprietate.CNP and 

vehicol.NR_VEHICOL=proprietate.NR_VEHICOL