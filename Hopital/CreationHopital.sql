DROP TABLE Pays CASCADE CONSTRAINTS;
DROP TABLE Adresses CASCADE CONSTRAINTS;
DROP TABLE Mutuelles CASCADE CONSTRAINTS;
DROP TABLE Specialites CASCADE CONSTRAINTS;
DROP TABLE medecins CASCADE CONSTRAINTS;
DROP TABLE Patients CASCADE CONSTRAINTS;
DROP TABLE PatientsMedecins CASCADE CONSTRAINTS;
DROP TABLE Hopitaux CASCADE CONSTRAINTS;
DROP TABLE Services CASCADE CONSTRAINTS;
DROP TABLE HopitauxServices CASCADE CONSTRAINTS;
DROP TABLE MedecinsServices CASCADE CONSTRAINTS;
DROP TABLE Groupes CASCADE CONSTRAINTS;
DROP TABLE Fabricants CASCADE CONSTRAINTS;
DROP TABLE Medicaments CASCADE CONSTRAINTS;
DROP TABLE Substances CASCADE CONSTRAINTS;
DROP TABLE Allergies CASCADE CONSTRAINTS;
DROP TABLE Composition CASCADE CONSTRAINTS;


--1
CREATE TABLE Pays (
    CodePays CHAR(2) CONSTRAINT CPPAYS PRIMARY KEY,
    Libelle VARCHAR2(50)   
);
--2
CREATE TABLE Adresses (
     CodeAdresse NUMBER(4) CONSTRAINT CPAdresses PRIMARY KEY,
     Adresse VARCHAR2(100),  
     Localite VARCHAR2(50), 
     CodePostal CHAR(5));
--3
CREATE TABLE Mutuelles (
     CodeMutuelle CHAR(3) CONSTRAINT CPAdresse PRIMARY KEY,
     Libelle VARCHAR2(100), 
     CodeAdresse NUMBER(4) CONSTRAINT REFMutuelleAdresses REFERENCES Adresses(CodeAdresse),
     Email VARCHAR2(100)  
);
--4
CREATE TABLE Specialites (
     Specialite CHAR(3) CONSTRAINT CPSpecialites PRIMARY KEY,
     Libelle VARCHAR2(80)       
);
--5
CREATE TABLE medecins (
     NrMedecin CHAR(11) 
         CONSTRAINT CPMedecins PRIMARY KEY,  
     Nom VARCHAR2(20)
         CONSTRAINT MedecinsNomNN CHECK (Nom IS NOT NULL)
         CONSTRAINT MedecinsNomLg CHECK (length(Nom) >= 2),          
     Prenom VARCHAR2(50),   
     Sexe CHAR(1) 
         CONSTRAINT MedecinsSexeNN CHECK (Sexe IS NOT NULL)
         CONSTRAINT MedecinsSexeMF CHECK (Sexe IN ('M', 'F')),      
     EtatCivil CHAR(1) 
         CONSTRAINT MedecinsEtatCivilNN CHECK (EtatCivil IS NOT NULL)
         CONSTRAINT MedecinsEtatCivilCMDV CHECK (EtatCivil IN ('C', 'M', 'D', 'V')),     
     Titre VARCHAR2(20),        
     DateDiplome DATE ,
     CptBancaire VARCHAR2(12),      
     Gsm VARCHAR2(15),
     CodeAdresse NUMBER(4)  
         CONSTRAINT REFMedecinsAdresses REFERENCES Adresses(CodeAdresse),
     Specialite CHAR(3) 
         CONSTRAINT REFMedecinsSpecialites REFERENCES Specialites(Specialite),
Datenaissance DATE
);

--6
CREATE TABLE Patients (
     NrSIS CHAR(11) CONSTRAINT CPPatients PRIMARY KEY,
     Nom VARCHAR2(20),          
     Prenom VARCHAR2(50),   
     Sexe CHAR(1),     
     EtatCivil CHAR(1),     
     Nationalite CHAR(2) CONSTRAINT REFPatientsPays REFERENCES Pays(CodePays),
     DateNaissance DATE ,    
     CptBancaire VARCHAR2(12),  
     GrpSanguin CHAR(2),    
     Taille NUMBER(3),			
     Poids NUMBER(3),		
     CodeMutuelle CHAR(3) CONSTRAINT REFPatientsMutuelles REFERENCES Mutuelles(CodeMutuelle),
     CodeAdresse NUMBER(4)  CONSTRAINT REFPatientsAdresses REFERENCES Adresses(CodeAdresse));

--7
CREATE TABLE PatientsMedecins (
     NrSIS CHAR(11) CONSTRAINT REFPatientsMedecinsPatients REFERENCES Patients(NrSIS), 
     NrMedecin CHAR(11) CONSTRAINT RefPatientsMedecinsMedecins REFERENCES Medecins(NrMedecin),
     CONSTRAINT CPPatientsMedecins PRIMARY KEY (NrSIS,NrMedecin));

--8     
CREATE TABLE Hopitaux (
   NrHopital char(7) 
       CONSTRAINT CPHopitaux PRIMARY KEY, 
   Nom VARCHAR2(50)
       CONSTRAINT HopitauxNomNN CHECK (Nom IS NOT NULL)
       CONSTRAINT HopitauxNomLg CHECK (length (Nom) > 10),           
   Telephone VARCHAR2(15),
   Email VARCHAR2(50)
       CONSTRAINT HopitauxEmailCK CHECK (Email LIKE '_%@_%'),          
   CodeAdresse NUMBER(4)  
       CONSTRAINT REFHopitauxAdresses REFERENCES Adresses(CodeAdresse),
   Capacite NUMBER(5)
       CONSTRAINT HopitauxCapaciteCK CHECK (COALESCE(Capacite, 15) > 10),
   Type CHAR(1)
       CONSTRAINT HopitauxTypeCU CHECK (Type IN ('C', 'U')),
   CptBancaire VARCHAR2(12) 
);

--9
CREATE TABLE Services (
       NrService CHAR(4) CONSTRAINT CPServices PRIMARY KEY ,
       Libelle VARCHAR2(50)
);

--10
CREATE TABLE HopitauxServices (
       NrHopital CHAR(7) CONSTRAINT REFHopitauxServicesHopitaux REFERENCES Hopitaux(NrHopital),
       NrService CHAR(4) CONSTRAINT REFHopitauxServicesServices REFERENCES Services(NrSErvice),
       ChefService CHAR(11) CONSTRAINT REFHopitauxServicesMedecins REFERENCES Medecins(NrMedecin),
       NbreMedecins NUMBER(4),
       CONSTRAINT CPHopitauxServices PRIMARY KEY (NrHopital,NrService)
);

--11
CREATE TABLE MedecinsServices (
    NrHopital CHAR(7),
    NrService CHAR(4),
    CONSTRAINT REFMedServicesHopServices 
    	FOREIGN KEY (NrHopital,NrService) REFERENCES HopitauxServices(NrHopital,NrService),
    NrMedecin CHAR(11) CONSTRAINT REFMedServicesMedecins REFERENCES Medecins(NrMedecin),
    CONSTRAINT CPMedecinsServices PRIMARY KEY (NrHopital,NrService,NrMedecin)
);

--12
create table GROUPES (	
	NRGROUPE NUMBER(2) CONSTRAINT CPGROUPES PRIMARY KEY,
	LIBELLE VARCHAR2(50));

--13
create table FABRICANTS (
     NRFABRICANT NUMBER(2) 
         CONSTRAINT CPFabricants PRIMARY KEY,
     NOM VARCHAR2(50)
         CONSTRAINT FabricantsNomNN CHECK (Nom IS NOT NULL)
         CONSTRAINT FabricantsNomLg CHECK (length (Nom) > 2),
     ADRESSE VARCHAR2(40)
         CONSTRAINT FabricantsAdresseNOrLg CHECK (Adresse IS NULL OR length(Adresse) > 10),
     CPOSTAL VARCHAR2(10),
         CONSTRAINT FabricantsCPostalNOrLg CHECK (CPostal IS NULL OR length(CPostal) = 4),
     LOCALITE VARCHAR2(30),
     CPAYS CHAR(2) CONSTRAINT RefFabricants_Pays REFERENCES PAYS(CodePays));   

--14       
create table MEDICAMENTS (     
	NRMEDICAMENT VARCHAR2(12) 
	    CONSTRAINT CPMedicaments PRIMARY KEY,
    DENOMINATION VARCHAR2(100)
        CONSTRAINT MedicamentsDenominationNN CHECK (Denomination IS NOT NULL)
        CONSTRAINT MedicamentsDenominationLg CHECK (length(Denomination) > 5),
    TYPE VARCHAR2(50)
        CONSTRAINT MedicamentsTypeNN CHECK (Type IS NOT NULL),
    CONDITIONNEMENT VARCHAR2(50),
    INDICATIONS VARCHAR2(50)
        CONSTRAINT MedicamentsIndications CHECK (Indications IS NULL OR length (Indications) > 5),
    NRGROUPE NUMBER(2) 
        CONSTRAINT RefMedic_Groupes REFERENCES Groupes(NrGroupe),
    NRFABRICANT NUMBER(2) 
        CONSTRAINT RefMedic_Fabricants REFERENCES Fabricants(NrFabricant));

--15     
create table SUBSTANCES (     
	NRSUBSTANCE char(4) CONSTRAINT CPSubstances PRIMARY KEY,
     	NOM VARCHAR2(50));

--16
create table ALLERGIES (
     NRSIS char(11) CONSTRAINT RefAllergique_Patients REFERENCES Patients(nrsis),
     NRSUBSTANCE char(4) CONSTRAINT RefAllergies_Substances REFERENCES Substances(nrsubstance),
     CONSTRAINT CPAllergique PRIMARY KEY (NRSIS,NRSUBSTANCE));

--17
create table COMPOSITION (     
	NRMEDICAMENT VARCHAR2(12) CONSTRAINT RefComposition_Medicaments   	REFERENCES Medicaments(nrmedicament),
     	NRSUBSTANCE char(4) CONSTRAINT RefComposition_Substances REFERENCES Substances(nrsubstance),
     	QUANTITE NUMBER(4),
     	UNITE char(3),
     	CONSTRAINT CPComposition primary key (NRMEDICAMENT,NRSUBSTANCE));
