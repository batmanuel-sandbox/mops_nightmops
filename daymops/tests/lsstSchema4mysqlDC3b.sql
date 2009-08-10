
-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/Copyrights>
-- for copyright information.


CREATE TABLE AAA_Version_3_0_31 (version CHAR);

CREATE TABLE mops_Event_OrbitIdentification
(
	eventId BIGINT NOT NULL,
	childObjectId BIGINT NOT NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventOrbitIdentificationToMovingObject_childObjectId (childObjectId ASC),
	KEY (eventId)
) ;


CREATE TABLE _mops_MoidQueue
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INT NOT NULL,
	eventId BIGINT NOT NULL,
	insertTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (movingObjectId, movingObjectVersion),
	KEY (movingObjectId),
	INDEX idx_mopsMoidQueue_eventId (eventId ASC)
) ;


CREATE TABLE _mops_EonQueue
(
	movingObjectId BIGINT NOT NULL,
	eventId BIGINT NOT NULL,
	insertTime TIMESTAMP NOT NULL,
	status CHAR(1) NULL DEFAULT 'I',
	PRIMARY KEY (movingObjectId),
	KEY (movingObjectId),
	INDEX idx__mopsEonQueue_eventId (eventId ASC)
) ;


CREATE TABLE _DIASourceToAlert
(
	alertId INTEGER NOT NULL,
	diaSourceId BIGINT NOT NULL,
	KEY (diaSourceId),
	KEY (alertId)
) ;


CREATE TABLE DIASource
(
	diaSourceId BIGINT NOT NULL,
	ampExposureId BIGINT NOT NULL,
	diaSourceToId BIGINT NULL,
	filterId TINYINT NOT NULL,
	objectId BIGINT NULL,
	movingObjectId BIGINT NULL,
	procHistoryId INTEGER NOT NULL,
	scId INTEGER NOT NULL,
	ssmId BIGINT NULL,
	ra DOUBLE NOT NULL,
	raErrForDetection FLOAT(0) NOT NULL,
	raErrForWcs FLOAT(0) NULL,
	decl DOUBLE NOT NULL,
	declErrForDetection FLOAT(0) NOT NULL,
	declErrForWcs FLOAT(0) NULL,
	xFlux DOUBLE NULL,
	xFluxErr FLOAT(0) NULL,
	yFlux DOUBLE NULL,
	yFluxErr FLOAT(0) NULL,
	raFlux DOUBLE NULL,
	raFluxErr FLOAT(0) NULL,
	declFlux DOUBLE NULL,
	declFluxErr FLOAT(0) NULL,
	xPeak DOUBLE NULL,
	yPeak DOUBLE NULL,
	raPeak DOUBLE NULL,
	declPeak DOUBLE NULL,
	xAstrom DOUBLE NULL,
	xAstromErr FLOAT(0) NULL,
	yAstrom DOUBLE NULL,
	yAstromErr FLOAT(0) NULL,
	raAstrom DOUBLE NULL,
	raAstromErr FLOAT(0) NULL,
	declAstrom DOUBLE NULL,
	declAstromErr FLOAT(0) NULL,
	taiMidPoint DOUBLE NOT NULL,
	taiRange FLOAT(0) NOT NULL,
	lengthDeg DOUBLE NOT NULL,
	psfFlux DOUBLE NOT NULL,
	psfFluxErr FLOAT(0) NOT NULL,
	apFlux DOUBLE NOT NULL,
	apFluxErr FLOAT(0) NOT NULL,
	modelFlux DOUBLE NOT NULL,
	modelFluxErr FLOAT(0) NULL,
	instFlux DOUBLE NOT NULL,
	instFluxErr FLOAT(0) NOT NULL,
	nonGrayCorrFlux DOUBLE NULL,
	nonGrayCorrFluxErr FLOAT(0) NULL,
	atmCorrFlux DOUBLE NULL,
	atmCorrFluxErr FLOAT(0) NULL,
	apDia FLOAT(0) NULL,
	refMag FLOAT(0) NULL,
	Ixx FLOAT(0) NULL,
	IxxErr FLOAT(0) NULL,
	Iyy FLOAT(0) NULL,
	IyyErr FLOAT(0) NULL,
	Ixy FLOAT(0) NULL,
	IxyErr FLOAT(0) NULL,
	snr FLOAT(0) NOT NULL,
	chi2 FLOAT(0) NOT NULL,
	valx1 DOUBLE NOT NULL,
	valx2 DOUBLE NOT NULL,
	valy1 DOUBLE NOT NULL,
	valy2 DOUBLE NOT NULL,
	valxy DOUBLE NOT NULL,
	obsCode CHAR(3) NULL,
	isSynthetic CHAR(1) NULL,
	mopsStatus CHAR(1) NULL,
	flagForAssociation SMALLINT NULL,
	flagForDetection SMALLINT NULL,
	flagForWcs SMALLINT NULL,
	flagClassification BIGINT NULL,
	PRIMARY KEY (diaSourceId),
	UNIQUE UQ_DIASource_diaSourceToId(diaSourceToId),
	KEY (ampExposureId),
	KEY (ampExposureId),
	KEY (filterId),
	KEY (movingObjectId),
	KEY (objectId),
	KEY (procHistoryId),
	INDEX idx_DIASource_ssmId (ssmId ASC),
	KEY (scId),
	INDEX idx_DIASource_psfMag (psfFlux ASC),
	INDEX idx_DIASource_taiMidPoint (taiMidPoint ASC)
) TYPE=MyISAM;


CREATE TABLE Alert
(
	alertId INTEGER NOT NULL DEFAULT 0,
	ampExposureId BIGINT NOT NULL,
	objectId BIGINT NOT NULL,
	timeGenerated DATETIME NOT NULL,
	imagePStampURL VARCHAR(255) NULL,
	templatePStampURL VARCHAR(255) NULL,
	alertURL VARCHAR(255) NULL,
	PRIMARY KEY (alertId),
	KEY (objectId),
	INDEX idx_Alert_timeGenerated (timeGenerated ASC),
	KEY (ampExposureId)
) TYPE=MyISAM;


CREATE TABLE Calibration_CCD_Exposure
(
	ccdExposureId BIGINT NOT NULL,
	exposureId INTEGER NOT NULL,
	calibTypeId TINYINT NOT NULL,
	filterId TINYINT NOT NULL,
	equinox FLOAT(0) NOT NULL,
	ctype1 VARCHAR(20) NOT NULL,
	ctype2 VARCHAR(20) NOT NULL,
	crpix1 FLOAT(0) NOT NULL,
	crpix2 FLOAT(0) NOT NULL,
	crval1 DOUBLE NOT NULL,
	crval2 DOUBLE NOT NULL,
	cd1_1 DOUBLE NOT NULL,
	cd2_1 DOUBLE NOT NULL,
	cd1_2 DOUBLE NOT NULL,
	cd2_2 DOUBLE NOT NULL,
	dateObs DATETIME NOT NULL,
	expTime FLOAT(0) NOT NULL,
	nCombine INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY (ccdExposureId),
	KEY (exposureId),
	KEY (ccdExposureId)
) ;


CREATE TABLE Calibration_Amp_Exposure
(
	ccdExposureId BIGINT NULL,
	ampExposureId BIGINT NOT NULL,
	PRIMARY KEY (ampExposureId),
	KEY (ccdExposureId),
	KEY (ampExposureId)
) ;


CREATE TABLE mops_Event
(
	eventId BIGINT NOT NULL AUTO_INCREMENT,
	procHistoryId INT NOT NULL,
	eventType CHAR(1) NOT NULL,
	eventTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	movingObjectId BIGINT NULL,
	movingObjectVersion INT NULL,
	orbitCode CHAR(1) NULL,
	d3 FLOAT(0) NULL,
	d4 FLOAT(0) NULL,
	ccdExposureId BIGINT NULL,
	classification CHAR(1) NULL,
	ssmId BIGINT NULL,
	PRIMARY KEY (eventId),
	KEY (movingObjectId),
	INDEX idx_mopsEvent_ccdExposureId (ccdExposureId ASC),
	INDEX idx_mopsEvent_movingObjectId (movingObjectId ASC, movingObjectVersion ASC),
	INDEX idx_mopsEvent_procHistoryId (procHistoryId ASC),
	INDEX idx_mopsEvent_ssmId (ssmId ASC)
) ;


CREATE TABLE _SourceToAmp_Exposure
(
	sourceId BIGINT NOT NULL,
	ampExposureId BIGINT NOT NULL,
	KEY (sourceId),
	KEY (ampExposureId)
) ;


CREATE TABLE placeholder_VarObject
(
	objectId BIGINT NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	raErr FLOAT(0) NOT NULL,
	declErr FLOAT(0) NOT NULL,
	flagForStage1 INTEGER NULL,
	flagForStage2 INTEGER NULL,
	flagForStage3 INTEGER NULL,
	uAmplitude FLOAT(0) NULL,
	uPeriod FLOAT(0) NULL,
	uTimescale FLOAT(0) NULL,
	gAmplitude FLOAT(0) NULL,
	gPeriod FLOAT(0) NULL,
	gTimescale FLOAT(0) NULL,
	rAmplitude FLOAT(0) NULL,
	rPeriod FLOAT(0) NULL,
	rTimescale FLOAT(0) NULL,
	iAmplitude FLOAT(0) NULL,
	iPeriod FLOAT(0) NULL,
	iTimescale FLOAT(0) NULL,
	zAmplitude FLOAT(0) NULL,
	zPeriod FLOAT(0) NULL,
	zTimescale FLOAT(0) NULL,
	yAmplitude FLOAT(0) NULL,
	yPeriod FLOAT(0) NULL,
	yTimescale FLOAT(0) NULL,
	uScalegram01 FLOAT(0) NULL,
	uScalegram02 FLOAT(0) NULL,
	uScalegram03 FLOAT(0) NULL,
	uScalegram04 FLOAT(0) NULL,
	uScalegram05 FLOAT(0) NULL,
	uScalegram06 FLOAT(0) NULL,
	uScalegram07 FLOAT(0) NULL,
	uScalegram08 FLOAT(0) NULL,
	uScalegram09 FLOAT(0) NULL,
	uScalegram10 FLOAT(0) NULL,
	uScalegram11 FLOAT(0) NULL,
	uScalegram12 FLOAT(0) NULL,
	uScalegram13 FLOAT(0) NULL,
	uScalegram14 FLOAT(0) NULL,
	uScalegram15 FLOAT(0) NULL,
	uScalegram16 FLOAT(0) NULL,
	uScalegram17 FLOAT(0) NULL,
	uScalegram18 FLOAT(0) NULL,
	uScalegram19 FLOAT(0) NULL,
	uScalegram20 FLOAT(0) NULL,
	uScalegram21 FLOAT(0) NULL,
	uScalegram22 FLOAT(0) NULL,
	uScalegram23 FLOAT(0) NULL,
	uScalegram24 FLOAT(0) NULL,
	uScalegram25 FLOAT(0) NULL,
	gScalegram01 FLOAT(0) NULL,
	gScalegram02 FLOAT(0) NULL,
	gScalegram03 FLOAT(0) NULL,
	gScalegram04 FLOAT(0) NULL,
	gScalegram05 FLOAT(0) NULL,
	gScalegram06 FLOAT(0) NULL,
	gScalegram07 FLOAT(0) NULL,
	gScalegram08 FLOAT(0) NULL,
	gScalegram09 FLOAT(0) NULL,
	gScalegram10 FLOAT(0) NULL,
	gScalegram11 FLOAT(0) NULL,
	gScalegram12 FLOAT(0) NULL,
	gScalegram13 FLOAT(0) NULL,
	gScalegram14 FLOAT(0) NULL,
	gScalegram15 FLOAT(0) NULL,
	gScalegram16 FLOAT(0) NULL,
	gScalegram17 FLOAT(0) NULL,
	gScalegram18 FLOAT(0) NULL,
	gScalegram19 FLOAT(0) NULL,
	gScalegram20 FLOAT(0) NULL,
	gScalegram21 FLOAT(0) NULL,
	gScalegram22 FLOAT(0) NULL,
	gScalegram23 FLOAT(0) NULL,
	gScalegram24 FLOAT(0) NULL,
	gScalegram25 FLOAT(0) NULL,
	rScalegram01 FLOAT(0) NULL,
	rScalegram02 FLOAT(0) NULL,
	rScalegram03 FLOAT(0) NULL,
	rScalegram04 FLOAT(0) NULL,
	rScalegram05 FLOAT(0) NULL,
	rScalegram06 FLOAT(0) NULL,
	rScalegram07 FLOAT(0) NULL,
	rScalegram08 FLOAT(0) NULL,
	rScalegram09 FLOAT(0) NULL,
	rScalegram10 FLOAT(0) NULL,
	rScalegram11 FLOAT(0) NULL,
	rScalegram12 FLOAT(0) NULL,
	rScalegram13 FLOAT(0) NULL,
	rScalegram14 FLOAT(0) NULL,
	rScalegram15 FLOAT(0) NULL,
	rScalegram16 FLOAT(0) NULL,
	rScalegram17 FLOAT(0) NULL,
	rScalegram18 FLOAT(0) NULL,
	rScalegram19 FLOAT(0) NULL,
	rScalegram20 FLOAT(0) NULL,
	rScalegram21 FLOAT(0) NULL,
	rScalegram22 FLOAT(0) NULL,
	rScalegram23 FLOAT(0) NULL,
	rScalegram24 FLOAT(0) NULL,
	rScalegram25 FLOAT(0) NULL,
	iScalegram01 FLOAT(0) NULL,
	iScalegram02 FLOAT(0) NULL,
	iScalegram03 FLOAT(0) NULL,
	iScalegram04 FLOAT(0) NULL,
	iScalegram05 FLOAT(0) NULL,
	iScalegram06 FLOAT(0) NULL,
	iScalegram07 FLOAT(0) NULL,
	iScalegram08 FLOAT(0) NULL,
	iScalegram09 FLOAT(0) NULL,
	iScalegram10 FLOAT(0) NULL,
	iScalegram11 FLOAT(0) NULL,
	iScalegram12 FLOAT(0) NULL,
	iScalegram13 FLOAT(0) NULL,
	iScalegram14 FLOAT(0) NULL,
	iScalegram15 FLOAT(0) NULL,
	iScalegram16 FLOAT(0) NULL,
	iScalegram17 FLOAT(0) NULL,
	iScalegram18 FLOAT(0) NULL,
	iScalegram19 FLOAT(0) NULL,
	iScalegram20 FLOAT(0) NULL,
	iScalegram21 FLOAT(0) NULL,
	iScalegram22 FLOAT(0) NULL,
	iScalegram23 FLOAT(0) NULL,
	iScalegram24 FLOAT(0) NULL,
	iScalegram25 FLOAT(0) NULL,
	zScalegram01 FLOAT(0) NULL,
	zScalegram02 FLOAT(0) NULL,
	zScalegram03 FLOAT(0) NULL,
	zScalegram04 FLOAT(0) NULL,
	zScalegram05 FLOAT(0) NULL,
	zScalegram06 FLOAT(0) NULL,
	zScalegram07 FLOAT(0) NULL,
	zScalegram08 FLOAT(0) NULL,
	zScalegram09 FLOAT(0) NULL,
	zScalegram10 FLOAT(0) NULL,
	zScalegram11 FLOAT(0) NULL,
	zScalegram12 FLOAT(0) NULL,
	zScalegram13 FLOAT(0) NULL,
	zScalegram14 FLOAT(0) NULL,
	zScalegram15 FLOAT(0) NULL,
	zScalegram16 FLOAT(0) NULL,
	zScalegram17 FLOAT(0) NULL,
	zScalegram18 FLOAT(0) NULL,
	zScalegram19 FLOAT(0) NULL,
	zScalegram20 FLOAT(0) NULL,
	zScalegram21 FLOAT(0) NULL,
	zScalegram22 FLOAT(0) NULL,
	zScalegram23 FLOAT(0) NULL,
	zScalegram24 FLOAT(0) NULL,
	zScalegram25 FLOAT(0) NULL,
	yScalegram01 FLOAT(0) NULL,
	yScalegram02 FLOAT(0) NULL,
	yScalegram03 FLOAT(0) NULL,
	yScalegram04 FLOAT(0) NULL,
	yScalegram05 FLOAT(0) NULL,
	yScalegram06 FLOAT(0) NULL,
	yScalegram07 FLOAT(0) NULL,
	yScalegram08 FLOAT(0) NULL,
	yScalegram09 FLOAT(0) NULL,
	yScalegram10 FLOAT(0) NULL,
	yScalegram11 FLOAT(0) NULL,
	yScalegram12 FLOAT(0) NULL,
	yScalegram13 FLOAT(0) NULL,
	yScalegram14 FLOAT(0) NULL,
	yScalegram15 FLOAT(0) NULL,
	yScalegram16 FLOAT(0) NULL,
	yScalegram17 FLOAT(0) NULL,
	yScalegram18 FLOAT(0) NULL,
	yScalegram19 FLOAT(0) NULL,
	yScalegram20 FLOAT(0) NULL,
	yScalegram21 FLOAT(0) NULL,
	yScalegram22 FLOAT(0) NULL,
	yScalegram23 FLOAT(0) NULL,
	yScalegram24 FLOAT(0) NULL,
	yScalegram25 FLOAT(0) NULL,
	primaryPeriod FLOAT(0) NULL,
	primaryPeriodErr FLOAT(0) NULL,
	uPeriodErr FLOAT(0) NULL,
	gPeriodErr FLOAT(0) NULL,
	rPeriodErr FLOAT(0) NULL,
	iPeriodErr FLOAT(0) NULL,
	zPeriodErr FLOAT(0) NULL,
	yPeriodErr FLOAT(0) NULL,
	PRIMARY KEY (objectId),
	KEY (objectId)
) ;


CREATE TABLE placeholder_ObjectPhotoZ
(
	objectId BIGINT NOT NULL,
	redshift FLOAT(0) NOT NULL,
	redshiftErr FLOAT(0) NOT NULL,
	probability TINYINT NOT NULL DEFAULT 100,
	photoZ1 FLOAT(0) NULL,
	photoZ1Err FLOAT(0) NULL,
	photoZ2 FLOAT(0) NULL,
	photoZ2Err FLOAT(0) NULL,
	photoZ1Outlier FLOAT(0) NULL,
	photoZ2Outlier FLOAT(0) NULL,
	KEY (objectId)
) ;


CREATE TABLE aux_Science_FPA_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE Object
(
	objectId BIGINT NOT NULL,
	procHistoryId INTEGER NOT NULL,
	ra DOUBLE NOT NULL,
	raErr FLOAT(0) NOT NULL,
	decl DOUBLE NOT NULL,
	declErr FLOAT(0) NOT NULL,
	muRa DOUBLE NULL,
	muRaErr FLOAT(0) NULL,
	muDecl DOUBLE NULL,
	muDeclErr FLOAT(0) NULL,
	xFlux DOUBLE NULL,
	xFluxErr FLOAT(0) NULL,
	yFlux DOUBLE NULL,
	yFluxErr FLOAT(0) NULL,
	raFlux DOUBLE NULL,
	raFluxErr FLOAT(0) NULL,
	declFlux DOUBLE NULL,
	declFluxErr FLOAT(0) NULL,
	xPeak DOUBLE NULL,
	yPeak DOUBLE NULL,
	raPeak DOUBLE NULL,
	declPeak DOUBLE NULL,
	xAstrom DOUBLE NULL,
	xAstromErr FLOAT(0) NULL,
	yAstrom DOUBLE NULL,
	yAstromErr FLOAT(0) NULL,
	raAstrom DOUBLE NULL,
	raAstromErr FLOAT(0) NULL,
	declAstrom DOUBLE NULL,
	declAstromErr FLOAT(0) NULL,
	refrRaAstrom FLOAT(0) NULL,
	refrRaAstromErr FLOAT(0) NULL,
	refrDeclAstrom FLOAT(0) NULL,
	refrDeclAstromErr FLOAT(0) NULL,
	parallax FLOAT(0) NULL,
	parallaxErr FLOAT(0) NULL,
	earliestObsTime DATETIME NULL,
	latestObsTime DATETIME NULL,
	primaryPeriod FLOAT(0) NULL,
	primaryPeriodErr FLOAT(0) NULL,
	ugColor DOUBLE NULL,
	grColor DOUBLE NULL,
	riColor DOUBLE NULL,
	izColor DOUBLE NULL,
	zyColor DOUBLE NULL,
	cx DOUBLE NOT NULL,
	cxErr FLOAT(0) NOT NULL,
	cy DOUBLE NOT NULL,
	cyErr FLOAT(0) NOT NULL,
	cz DOUBLE NOT NULL,
	czErr FLOAT(0) NOT NULL,
	flagForStage1 INTEGER NULL,
	flagForStage2 INTEGER NULL,
	flagForStage3 INTEGER NULL,
	isProvisional BOOL NOT NULL DEFAULT FALSE,
	zone INTEGER NULL,
	uMag DOUBLE NULL,
	uMagErr FLOAT(0) NULL,
	uPetroMag DOUBLE NULL,
	uPetroMagErr FLOAT(0) NULL,
	uApMag DOUBLE NULL,
	uApMagErr FLOAT(0) NULL,
	uPosErrA FLOAT(0) NULL,
	uPosErrB FLOAT(0) NULL,
	uPosErrTheta FLOAT(0) NULL,
	uNumObs INTEGER NULL,
	uVarProb TINYINT NULL,
	uAmplitude FLOAT(0) NULL,
	uPeriod FLOAT(0) NULL,
	uPeriodErr FLOAT(0) NULL,
	uIx FLOAT(0) NULL,
	uIxErr FLOAT(0) NULL,
	uIy FLOAT(0) NULL,
	uIyErr FLOAT(0) NULL,
	uIxx FLOAT(0) NULL,
	uIxxErr FLOAT(0) NULL,
	uIyy FLOAT(0) NULL,
	uIyyErr FLOAT(0) NULL,
	uIxy FLOAT(0) NULL,
	uIxyErr FLOAT(0) NULL,
	uTimescale FLOAT(0) NULL,
	gMag DOUBLE NULL,
	gMagErr FLOAT(0) NULL,
	gPetroMag DOUBLE NULL,
	gPetroMagErr FLOAT(0) NULL,
	gApMag DOUBLE NULL,
	gApMagErr FLOAT(0) NULL,
	gPosErrA FLOAT(0) NULL,
	gPosErrB FLOAT(0) NULL,
	gPosErrTheta FLOAT(0) NULL,
	gNumObs INTEGER NULL,
	gVarProb TINYINT NULL,
	gAmplitude FLOAT(0) NULL,
	gPeriod FLOAT(0) NULL,
	gPeriodErr FLOAT(0) NULL,
	gIx FLOAT(0) NULL,
	gIxErr FLOAT(0) NULL,
	gIy FLOAT(0) NULL,
	gIyErr FLOAT(0) NULL,
	gIxx FLOAT(0) NULL,
	gIxxErr FLOAT(0) NULL,
	gIyy FLOAT(0) NULL,
	gIyyErr FLOAT(0) NULL,
	gIxy FLOAT(0) NULL,
	gIxyErr FLOAT(0) NULL,
	gTimescale FLOAT(0) NULL,
	rMag DOUBLE NULL,
	rMagErr FLOAT(0) NULL,
	rPetroMag DOUBLE NULL,
	rPetroMagErr FLOAT(0) NULL,
	rApMag DOUBLE NULL,
	rApMagErr FLOAT(0) NULL,
	rPosErrA FLOAT(0) NULL,
	rPosErrB FLOAT(0) NULL,
	rPosErrTheta FLOAT(0) NULL,
	rNumObs INTEGER NULL,
	rVarProb TINYINT NULL,
	rAmplitude FLOAT(0) NULL,
	rPeriod FLOAT(0) NULL,
	rPeriodErr FLOAT(0) NULL,
	rIx FLOAT(0) NULL,
	rIxErr FLOAT(0) NULL,
	rIy FLOAT(0) NULL,
	rIyErr FLOAT(0) NULL,
	rIxx FLOAT(0) NULL,
	rIxxErr FLOAT(0) NULL,
	rIyy FLOAT(0) NULL,
	rIyyErr FLOAT(0) NULL,
	rIxy FLOAT(0) NULL,
	rIxyErr FLOAT(0) NULL,
	rTimescale FLOAT(0) NULL,
	iMag DOUBLE NULL,
	iMagErr FLOAT(0) NULL,
	iPetroMag DOUBLE NULL,
	iPetroMagErr FLOAT(0) NULL,
	iApMag DOUBLE NULL,
	iApMagErr FLOAT(0) NULL,
	iPosErrA FLOAT(0) NULL,
	iPosErrB FLOAT(0) NULL,
	iPosErrTheta FLOAT(0) NULL,
	iNumObs INTEGER NULL,
	iVarProb TINYINT NULL,
	iAmplitude FLOAT(0) NULL,
	iPeriod FLOAT(0) NULL,
	iPeriodErr FLOAT(0) NULL,
	iIx FLOAT(0) NULL,
	iIxErr FLOAT(0) NULL,
	iIy FLOAT(0) NULL,
	iIyErr FLOAT(0) NULL,
	iIxx FLOAT(0) NULL,
	iIxxErr FLOAT(0) NULL,
	iIyy FLOAT(0) NULL,
	iIyyErr FLOAT(0) NULL,
	iIxy FLOAT(0) NULL,
	iIxyErr FLOAT(0) NULL,
	iTimescale FLOAT(0) NULL,
	zMag DOUBLE NULL,
	zMagErr FLOAT(0) NULL,
	zPetroMag DOUBLE NULL,
	zPetroMagErr FLOAT(0) NULL,
	zApMag DOUBLE NULL,
	zApMagErr FLOAT(0) NULL,
	zPosErrA FLOAT(0) NULL,
	zPosErrB FLOAT(0) NULL,
	zPosErrTheta FLOAT(0) NULL,
	zNumObs INTEGER NULL,
	zVarProb TINYINT NULL,
	zAmplitude FLOAT(0) NULL,
	zPeriod FLOAT(0) NULL,
	zPeriodErr FLOAT(0) NULL,
	zIx FLOAT(0) NULL,
	zIxErr FLOAT(0) NULL,
	zIy FLOAT(0) NULL,
	zIyErr FLOAT(0) NULL,
	zIxx FLOAT(0) NULL,
	zIxxErr FLOAT(0) NULL,
	zIyy FLOAT(0) NULL,
	zIyyErr FLOAT(0) NULL,
	zIxy FLOAT(0) NULL,
	zIxyErr FLOAT(0) NULL,
	zTimescale FLOAT(0) NULL,
	yMag DOUBLE NULL,
	yMagErr FLOAT(0) NULL,
	yPetroMag DOUBLE NULL,
	yPetroMagErr FLOAT(0) NULL,
	yApMag DOUBLE NULL,
	yApMagErr FLOAT(0) NULL,
	yPosErrA FLOAT(0) NULL,
	yPosErrB FLOAT(0) NULL,
	yPosErrTheta FLOAT(0) NULL,
	yNumObs INTEGER NULL,
	yVarProb TINYINT NULL,
	yAmplitude FLOAT(0) NULL,
	yPeriod FLOAT(0) NULL,
	yPeriodErr FLOAT(0) NULL,
	yIx FLOAT(0) NULL,
	yIxErr FLOAT(0) NULL,
	yIy FLOAT(0) NULL,
	yIyErr FLOAT(0) NULL,
	yIxx FLOAT(0) NULL,
	yIxxErr FLOAT(0) NULL,
	yIyy FLOAT(0) NULL,
	yIyyErr FLOAT(0) NULL,
	yIxy FLOAT(0) NULL,
	yIxyErr FLOAT(0) NULL,
	yTimescale FLOAT(0) NULL,
	PRIMARY KEY (objectId),
	INDEX idx_Object_ugColor (ugColor ASC),
	INDEX idx_Object_grColor (grColor ASC),
	INDEX idx_Object_riColor (riColor ASC),
	INDEX idx_Object_izColor (izColor ASC),
	INDEX idx_Object_zyColor (zyColor ASC),
	INDEX idx_Object_latestObsTime (latestObsTime ASC),
	KEY (procHistoryId)
) TYPE=MyISAM;


CREATE TABLE MovingObject
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INT NOT NULL DEFAULT '1',
	procHistoryId INTEGER NULL,
	taxonomicTypeId SMALLINT NULL,
	ssmObjectName VARCHAR(32) NULL,
	q DOUBLE NOT NULL,
	e DOUBLE NOT NULL,
	i DOUBLE NOT NULL,
	node DOUBLE NOT NULL,
	meanAnom DOUBLE NULL,
	argPeri DOUBLE NOT NULL,
	distPeri DOUBLE NOT NULL,
	timePeri DOUBLE NOT NULL,
	epoch DOUBLE NOT NULL,
	h_v DOUBLE NOT NULL,
	g DOUBLE NULL DEFAULT 0.15,
	rotationPeriod DOUBLE NULL,
	rotationEpoch DOUBLE NULL,
	albedo DOUBLE NULL,
	poleLat DOUBLE NULL,
	poleLon DOUBLE NULL,
	d3 DOUBLE NULL,
	d4 DOUBLE NULL,
	orbFitResidual DOUBLE NOT NULL,
	orbFitChi2 DOUBLE NULL,
	classification CHAR(1) NULL,
	ssmId BIGINT NULL,
	mopsStatus CHAR(1) NULL,
	stablePass CHAR(1) NULL,
	timeCreated TIMESTAMP NULL,
	uMag DOUBLE NULL,
	uMagErr FLOAT(0) NULL,
	uAmplitude FLOAT(0) NULL,
	uPeriod FLOAT(0) NULL,
	gMag DOUBLE NULL,
	gMagErr FLOAT(0) NULL,
	gAmplitude FLOAT(0) NULL,
	gPeriod FLOAT(0) NULL,
	rMag DOUBLE NULL,
	rMagErr FLOAT(0) NULL,
	rAmplitude FLOAT(0) NULL,
	rPeriod FLOAT(0) NULL,
	iMag DOUBLE NULL,
	iMagErr FLOAT(0) NULL,
	iAmplitude FLOAT(0) NULL,
	iPeriod FLOAT(0) NULL,
	zMag DOUBLE NULL,
	zMagErr FLOAT(0) NULL,
	zAmplitude FLOAT(0) NULL,
	zPeriod FLOAT(0) NULL,
	yMag DOUBLE NULL,
	yMagErr FLOAT(0) NULL,
	yAmplitude FLOAT(0) NULL,
	yPeriod FLOAT(0) NULL,
	flag INTEGER NULL,
	src01 DOUBLE NULL,
	src02 DOUBLE NULL,
	src03 DOUBLE NULL,
	src04 DOUBLE NULL,
	src05 DOUBLE NULL,
	src06 DOUBLE NULL,
	src07 DOUBLE NULL,
	src08 DOUBLE NULL,
	src09 DOUBLE NULL,
	src10 DOUBLE NULL,
	src11 DOUBLE NULL,
	src12 DOUBLE NULL,
	src13 DOUBLE NULL,
	src14 DOUBLE NULL,
	src15 DOUBLE NULL,
	src16 DOUBLE NULL,
	src17 DOUBLE NULL,
	src18 DOUBLE NULL,
	src19 DOUBLE NULL,
	src20 DOUBLE NULL,
	src21 DOUBLE NULL,
	convCode VARCHAR(8) NULL,
	o_minus_c DOUBLE NULL,
	moid1 DOUBLE NULL,
	moidLong1 DOUBLE NULL,
	moid2 DOUBLE NULL,
	moidLong2 DOUBLE NULL,
	arcLengthDays DOUBLE NULL,
	PRIMARY KEY (movingObjectId, movingObjectVersion),
	KEY (procHistoryId),
	INDEX idx_MovingObject_taxonomicTypeId (taxonomicTypeId ASC),
	INDEX idx_MovingObject_ssmId (ssmId ASC),
	INDEX idx_MovingObject_ssmObjectName (ssmObjectName ASC),
	INDEX idx_MovingObject_status (mopsStatus ASC)
) ;


CREATE TABLE Science_CCD_Exposure
(
	scienceCCDExposureId BIGINT NOT NULL,
	scienceFPAExposureId INTEGER NOT NULL,
	filterId TINYINT NOT NULL,
	equinox FLOAT(0) NOT NULL,
	url VARCHAR(255) NOT NULL,
	ctype1 VARCHAR(20) NOT NULL,
	ctype2 VARCHAR(20) NOT NULL,
	crpix1 FLOAT(0) NOT NULL,
	crpix2 FLOAT(0) NOT NULL,
	crval1 DOUBLE NOT NULL,
	crval2 DOUBLE NOT NULL,
	cd1_1 DOUBLE NOT NULL,
	cd2_1 DOUBLE NOT NULL,
	cd1_2 DOUBLE NOT NULL,
	cd2_2 DOUBLE NOT NULL,
	dateObs DATETIME NOT NULL,
	expTime FLOAT(0) NOT NULL,
	photoFlam FLOAT(0) NOT NULL,
	photoZP FLOAT(0) NOT NULL,
	nCombine INTEGER NOT NULL DEFAULT 1,
	taiMjd DOUBLE NULL,
	bixX INTEGER NULL,
	binY INTEGER NULL,
	saturationLimit BIGINT NULL,
	dataSection VARCHAR(24) NULL,
	ccdSize VARCHAR(50) NULL,
	gain DOUBLE NULL,
	readNoise DOUBLE NULL,
	PRIMARY KEY (scienceCCDExposureId),
	KEY (scienceCCDExposureId),
	KEY (scienceFPAExposureId)
) ;


CREATE TABLE Raw_CCD_Exposure
(
	rawCCDExposureId BIGINT NOT NULL,
	rawFPAExposureId INTEGER NOT NULL,
	procHistoryId INTEGER NULL,
	referenceRawFPAExposureId BIGINT NOT NULL,
	filterId TINYINT NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	equinox FLOAT(0) NOT NULL,
	url VARCHAR(255) NOT NULL,
	ctype1 VARCHAR(20) NOT NULL,
	ctype2 VARCHAR(20) NOT NULL,
	crpix1 FLOAT(0) NOT NULL,
	crpix2 FLOAT(0) NOT NULL,
	crval1 DOUBLE NOT NULL,
	crval2 DOUBLE NOT NULL,
	cd11 DOUBLE NOT NULL,
	cd21 DOUBLE NOT NULL,
	cd12 DOUBLE NOT NULL,
	cd22 DOUBLE NOT NULL,
	dateObs DATETIME NOT NULL,
	taiObs DATETIME NULL,
	mjdObs DOUBLE NULL,
	expTime FLOAT(0) NOT NULL,
	darkTime FLOAT(0) NULL,
	zd FLOAT(0) NOT NULL,
	airmass FLOAT(0) NULL,
	kNonGray DOUBLE NOT NULL,
	c0 DOUBLE NOT NULL,
	c0Err FLOAT(0) NOT NULL,
	cx1 DOUBLE NOT NULL,
	cx1Err FLOAT(0) NOT NULL,
	cx2 DOUBLE NOT NULL,
	cx2Err FLOAT(0) NOT NULL,
	cy1 DOUBLE NOT NULL,
	cy1Err FLOAT(0) NOT NULL,
	cy2 DOUBLE NOT NULL,
	cy2Err FLOAT(0) NOT NULL,
	cxy DOUBLE NOT NULL,
	cxyErr FLOAT(0) NOT NULL,
	PRIMARY KEY (rawCCDExposureId),
	KEY (rawFPAExposureId),
	KEY (procHistoryId)
) ;


CREATE TABLE Raw_Amp_Exposure
(
	rawAmpExposureId BIGINT NOT NULL,
	amplifierId SMALLINT NOT NULL,
	rawCCDExposureId BIGINT NOT NULL,
	procHistoryId INTEGER NOT NULL,
	binX SMALLINT NULL,
	binY SMALLINT NULL,
	sizeX SMALLINT NULL,
	sizeY SMALLINT NULL,
	taiObs DATETIME NULL,
	expTime FLOAT(0) NULL,
	bias FLOAT(0) NOT NULL,
	gain FLOAT(0) NOT NULL,
	rdNoise FLOAT(0) NOT NULL,
	telAngle FLOAT(0) NOT NULL,
	az FLOAT(0) NULL,
	altitude FLOAT(0) NULL,
	flag SMALLINT NULL,
	zpt DOUBLE NULL,
	zptErr FLOAT(0) NULL,
	sky FLOAT(0) NOT NULL,
	skySig FLOAT(0) NULL,
	skyErr FLOAT(0) NULL,
	psf_nstar INTEGER NULL,
	psf_apcorr FLOAT(0) NULL,
	psf_sigma1 FLOAT(0) NULL,
	psf_sigma2 FLOAT(0) NULL,
	psf_b FLOAT(0) NULL,
	psf_b_2G FLOAT(0) NULL,
	psf_p0 FLOAT(0) NULL,
	psf_beta FLOAT(0) NULL,
	psf_sigmap FLOAT(0) NULL,
	psf_nprof INTEGER NULL,
	psf_fwhm FLOAT(0) NOT NULL,
	psf_sigma_x FLOAT(0) NULL,
	psf_sigma_y FLOAT(0) NULL,
	psf_posAngle FLOAT(0) NULL,
	psf_peak FLOAT(0) NULL,
	psf_x0 FLOAT(0) NULL,
	psf_x1 FLOAT(0) NULL,
	radesys VARCHAR(5) NULL,
	equinox FLOAT(0) NOT NULL,
	ctype1 VARCHAR(20) NOT NULL,
	ctype2 VARCHAR(20) NOT NULL,
	cunit1 VARCHAR(10) NULL,
	cunit2 VARCHAR(10) NULL,
	crpix1 FLOAT(0) NOT NULL,
	crpix2 FLOAT(0) NOT NULL,
	crval1 FLOAT(0) NOT NULL,
	crval2 FLOAT(0) NOT NULL,
	cd11 FLOAT(0) NOT NULL,
	cd12 FLOAT(0) NOT NULL,
	cd21 FLOAT(0) NOT NULL,
	cd22 FLOAT(0) NOT NULL,
	cdelt1 FLOAT(0) NULL,
	cdelt2 FLOAT(0) NULL,
	PRIMARY KEY (rawAmpExposureId),
	KEY (amplifierId),
	KEY (rawCCDExposureId),
	KEY (procHistoryId)
) ;


CREATE TABLE _Science_FPA_ExposureToTemplateImage
(
	scienceFPAExposureId BIGINT NOT NULL,
	templateImageId INTEGER NOT NULL,
	KEY (templateImageId),
	KEY (scienceFPAExposureId)
) ;


CREATE TABLE _FPA_FringeToCMExposure
(
	biasExposureId INTEGER NOT NULL,
	darkExposureId INTEGER NOT NULL,
	flatExposureId INTEGER NOT NULL,
	cmFringeExposureId INTEGER NOT NULL,
	KEY (cmFringeExposureId),
	KEY (darkExposureId),
	KEY (flatExposureId),
	KEY (biasExposureId)
) ;


CREATE TABLE _FPA_FlatToCMExposure
(
	flatExposureId INTEGER NOT NULL,
	biasExposureId INTEGER NOT NULL,
	darkExposureId INTEGER NOT NULL,
	cmFlatExposureId INTEGER NOT NULL,
	KEY (biasExposureId),
	KEY (cmFlatExposureId),
	KEY (darkExposureId),
	KEY (flatExposureId)
) ;


CREATE TABLE _FPA_DarkToCMExposure
(
	darkExposureId INTEGER NOT NULL,
	biasExposureId INTEGER NOT NULL,
	cmDarkExposureId INTEGER NOT NULL,
	KEY (cmDarkExposureId),
	KEY (darkExposureId),
	KEY (biasExposureId)
) ;


CREATE TABLE _FPA_BiasToCMExposure
(
	biasExposureId INTEGER NOT NULL,
	cmBiasExposureId INTEGER NOT NULL,
	KEY (cmBiasExposureId),
	KEY (biasExposureId)
) ;


CREATE TABLE prv_Snapshot
(
	snapshotId MEDIUMINT NOT NULL,
	procHistoryId INTEGER NOT NULL,
	snapshotDescr VARCHAR(255) NULL,
	PRIMARY KEY (snapshotId),
	KEY (procHistoryId)
) ;


CREATE TABLE prv_cnf_MaskAmpImage
(
	cMaskAmpImageId BIGINT NOT NULL,
	amplifierId SMALLINT NOT NULL,
	url VARCHAR(255) NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cMaskAmpImageId),
	KEY (amplifierId)
) ;


CREATE TABLE prv_cnf_Amplifier
(
	cAmplifierId SMALLINT NOT NULL,
	amplifierId SMALLINT NOT NULL,
	serialNumber VARCHAR(40) NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cAmplifierId),
	KEY (amplifierId)
) TYPE=MyISAM;


CREATE TABLE _aux_Science_FPA_Exposure_Group
(
	dummy INTEGER NULL
) ;


CREATE TABLE Visit
(
	visitId INTEGER NOT NULL,
	rawFPAExposureId INTEGER NOT NULL,
	PRIMARY KEY (visitId),
	KEY (rawFPAExposureId)
) ;


CREATE TABLE Science_FPA_Exposure
(
	scienceFPAExposureId INTEGER NOT NULL,
	rawFPAExposureId INTEGER NOT NULL,
	subtractedRawFPAExposureId INTEGER NOT NULL,
	varianceRawFPAExposureId INTEGER NOT NULL,
	cseGroupId MEDIUMINT NOT NULL,
	PRIMARY KEY (scienceFPAExposureId),
	UNIQUE UQ_Science_FPA_Exposure_rawFPAExposureId(rawFPAExposureId),
	KEY (rawFPAExposureId),
	KEY (subtractedRawFPAExposureId),
	KEY (varianceRawFPAExposureId),
	KEY (cseGroupId)
) ;


CREATE TABLE Calibration_FPA_Exposure
(
	calibrationFPAExposureId INTEGER NOT NULL,
	PRIMARY KEY (calibrationFPAExposureId),
	KEY (calibrationFPAExposureId)
) ;


CREATE TABLE Flat_FPA_Exposure
(
	flatExposureId INTEGER NOT NULL,
	filterId TINYINT NOT NULL,
	averPixelValue FLOAT(0) NULL,
	stdevPixelValue FLOAT(0) NULL,
	wavelength FLOAT(0) NULL,
	type TINYINT NULL,
	PRIMARY KEY (flatExposureId),
	KEY (flatExposureId)
) ;


CREATE TABLE Dark_FPA_Exposure
(
	darkExposureId INTEGER NOT NULL,
	averPixelValue FLOAT(0) NULL,
	stdevPixelValue FLOAT(0) NULL,
	PRIMARY KEY (darkExposureId),
	KEY (darkExposureId)
) ;


CREATE TABLE Bias_FPA_Exposure
(
	biasExposureId INTEGER NOT NULL,
	averPixelValue FLOAT(0) NULL,
	stdevPixelValue FLOAT(0) NULL,
	PRIMARY KEY (biasExposureId),
	KEY (biasExposureId)
) ;


CREATE TABLE mops_TrackletsToDIASource
(
	trackletId BIGINT NOT NULL,
	diaSourceId BIGINT NOT NULL,
	PRIMARY KEY (trackletId, diaSourceId),
	INDEX idx_mopsTrackletsToDIASource_diaSourceId (diaSourceId ASC),
	KEY (trackletId)
) ;


CREATE TABLE mops_TracksToTracklet
(
	trackId BIGINT NULL,
	trackletId BIGINT NULL,
	PRIMARY KEY (trackId, trackletId),
	INDEX idx_mopsTracksToTracklet_trackletId (trackletId ASC),
	KEY (trackId)
) ;


CREATE TABLE mops_MovingObjectToTracklet
(
	movingObjectId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	INDEX idx_mopsMovingObjectToTracklets_movingObjectId (movingObjectId ASC),
	INDEX idx_mopsMovingObjectToTracklets_trackletId (trackletId ASC)
) ;


CREATE TABLE mops_Event_TrackletRemoval
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventTrackletRemoval_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event_TrackletPrecovery
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	ephemerisDistance FLOAT(0) NOT NULL,
	ephemerisUncertainty FLOAT(0) NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventTrackletPrecovery_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event_TrackletAttribution
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	ephemerisDistance FLOAT(0) NOT NULL,
	ephemerisUncertainty FLOAT(0) NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventTrackletAttribution_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event_OrbitDerivation
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	PRIMARY KEY (eventId, trackletId),
	INDEX idx_mopsEventDerivation_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE _SourceToObject
(
	objectId BIGINT NOT NULL,
	sourceId BIGINT NOT NULL,
	splitPercentage TINYINT NOT NULL,
	INDEX idx_SourceToObject_objectId (objectId ASC),
	INDEX idx_SourceToObject_sourceId (sourceId ASC)
) ;


CREATE TABLE prv_ProcHistory
(
	procHistoryId INTEGER NOT NULL,
	PRIMARY KEY (procHistoryId)
) ;


CREATE TABLE prv_cnf_CCD
(
	cCCDId SMALLINT NOT NULL,
	ccdId SMALLINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cCCDId),
	KEY (ccdId)
) ;


CREATE TABLE prv_Amplifier
(
	amplifierId SMALLINT NOT NULL,
	ccdId SMALLINT NULL,
	amplifierDescr VARCHAR(80) NULL,
	PRIMARY KEY (amplifierId),
	KEY (ccdId)
) ;


CREATE TABLE prv_cnf_StageToPipeline
(
	cStageToPipelineId MEDIUMINT NOT NULL,
	stageToPipelineId MEDIUMINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cStageToPipelineId),
	KEY (stageToPipelineId)
) ;


CREATE TABLE prv_cnf_PipelineToRun
(
	cPipelineToRunId MEDIUMINT NOT NULL,
	pipelineToRunId MEDIUMINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cPipelineToRunId),
	KEY (pipelineToRunId)
) ;


CREATE TABLE aux_Fringe_FPA_CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Flat_FPA_CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Dark_FPA_CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Bias_FPA_CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE Source
(
	sourceId BIGINT NOT NULL,
	ampExposureId BIGINT NULL,
	filterId TINYINT NOT NULL,
	objectId BIGINT NULL,
	movingObjectId BIGINT NULL,
	procHistoryId INTEGER NOT NULL,
	ra DOUBLE NOT NULL,
	raErrForDetection FLOAT(0) NULL,
	raErrForWcs FLOAT(0) NOT NULL,
	decl DOUBLE NOT NULL,
	declErrForDetection FLOAT(0) NULL,
	declErrForWcs FLOAT(0) NOT NULL,
	xFlux DOUBLE NULL,
	xFluxErr FLOAT(0) NULL,
	yFlux DOUBLE NULL,
	yFluxErr FLOAT(0) NULL,
	raFlux DOUBLE NULL,
	raFluxErr FLOAT(0) NULL,
	declFlux DOUBLE NULL,
	declFluxErr FLOAT(0) NULL,
	xPeak DOUBLE NULL,
	yPeak DOUBLE NULL,
	raPeak DOUBLE NULL,
	declPeak DOUBLE NULL,
	xAstrom DOUBLE NULL,
	xAstromErr FLOAT(0) NULL,
	yAstrom DOUBLE NULL,
	yAstromErr FLOAT(0) NULL,
	raAstrom DOUBLE NULL,
	raAstromErr FLOAT(0) NULL,
	declAstrom DOUBLE NULL,
	declAstromErr FLOAT(0) NULL,
	taiMidPoint DOUBLE NOT NULL,
	taiRange FLOAT(0) NULL,
	psfFlux DOUBLE NOT NULL,
	psfFluxErr FLOAT(0) NOT NULL,
	apFlux DOUBLE NOT NULL,
	apFluxErr FLOAT(0) NOT NULL,
	modelFlux DOUBLE NOT NULL,
	modelFluxErr FLOAT(0) NOT NULL,
	petroFlux DOUBLE NULL,
	petroFluxErr FLOAT(0) NULL,
	instFlux DOUBLE NOT NULL,
	instFluxErr FLOAT(0) NOT NULL,
	nonGrayCorrFlux DOUBLE NULL,
	nonGrayCorrFluxErr FLOAT(0) NULL,
	atmCorrFlux DOUBLE NULL,
	atmCorrFluxErr FLOAT(0) NULL,
	apDia FLOAT(0) NULL,
	Ixx FLOAT(0) NULL,
	IxxErr FLOAT(0) NULL,
	Iyy FLOAT(0) NULL,
	IyyErr FLOAT(0) NULL,
	Ixy FLOAT(0) NULL,
	IxyErr FLOAT(0) NULL,
	snr FLOAT(0) NOT NULL,
	chi2 FLOAT(0) NOT NULL,
	sky FLOAT(0) NULL,
	skyErr FLOAT(0) NULL,
	flagForAssociation SMALLINT NULL,
	flagForDetection SMALLINT NULL,
	flagForWcs SMALLINT NULL,
	PRIMARY KEY (sourceId),
	KEY (ampExposureId),
	KEY (filterId),
	KEY (movingObjectId),
	KEY (objectId),
	KEY (procHistoryId)
) TYPE=MyISAM;


CREATE TABLE Raw_FPA_Exposure
(
	rawFPAExposureId INTEGER NOT NULL,
	filterId TINYINT NOT NULL,
	procHistoryId INTEGER NULL,
	visitId INTEGER NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	obsDate DATETIME NOT NULL,
	tai DOUBLE NOT NULL,
	taiDark DOUBLE NULL,
	azimuth FLOAT(0) NULL,
	altitude FLOAT(0) NULL,
	temperature FLOAT(0) NULL,
	texp FLOAT(0) NOT NULL,
	flag SMALLINT NULL,
	ra_ll DOUBLE NOT NULL,
	dec_ll DOUBLE NOT NULL,
	ra_lr DOUBLE NOT NULL,
	dec_lr DOUBLE NOT NULL,
	ra_ul DOUBLE NOT NULL,
	dec_ul DOUBLE NOT NULL,
	ra_ur DOUBLE NOT NULL,
	dec_ur DOUBLE NOT NULL,
	PRIMARY KEY (rawFPAExposureId),
	UNIQUE UQ_Raw_FPA_Exposure_visitId(visitId),
	KEY (filterId),
	KEY (procHistoryId)
) TYPE=MyISAM;


CREATE TABLE mops_Tracklet
(
	trackletId BIGINT NOT NULL AUTO_INCREMENT,
	ccdExposureId BIGINT NOT NULL,
	procHistoryId INT NOT NULL,
	ssmId BIGINT NULL,
	velRa DOUBLE NULL,
	velRaErr FLOAT(0) NULL,
	velDecl DOUBLE NULL,
	velDeclErr FLOAT(0) NULL,
	velTot DOUBLE NULL,
	accRa DOUBLE NULL,
	accRaErr FLOAT(0) NULL,
	accDecl DOUBLE NULL,
	accDeclErr FLOAT(0) NULL,
	extEpoch DOUBLE NULL,
	extRa DOUBLE NULL,
	extRaErr FLOAT(0) NULL,
	extDecl DOUBLE NULL,
	extDeclErr FLOAT(0) NULL,
	extMag DOUBLE NULL,
	extMagErr FLOAT(0) NULL,
	probability DOUBLE NULL,
	status CHAR(1) NULL,
	classification CHAR(1) NULL,
	PRIMARY KEY (trackletId),
	INDEX idx_mopsTracklets_ccdExposureId (ccdExposureId ASC),
	INDEX idx_mopsTracklets_ssmId (ssmId ASC),
	INDEX idx_mopsTracklets_classification (classification ASC),
	INDEX idx_mopsTracklets_extEpoch (extEpoch ASC)
) ;


CREATE TABLE sdqa_Rating_ForScienceCCDExposure
(
	sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	ccdExposureId BIGINT NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricErr FLOAT(0) NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	UNIQUE UQ_sdqa_Rating_ForScienceCCDExposure_metricId_ccdExposureId(sdqa_metricId, ccdExposureId),
	KEY (sdqa_metricId),
	KEY (sdqa_thresholdId),
	KEY (ccdExposureId)
) ;


CREATE TABLE prv_StageToProcHistory
(
	stageId SMALLINT NOT NULL,
	procHistoryId INTEGER NOT NULL,
	stageStart DATETIME NULL,
	stageEnd DATETIME NULL,
	KEY (stageId),
	KEY (procHistoryId)
) ;


CREATE TABLE prv_cnf_Telescope
(
	cTelescopeId SMALLINT NOT NULL,
	telescopeId TINYINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cTelescopeId),
	KEY (telescopeId)
) ;


CREATE TABLE prv_cnf_Raft
(
	cRaftId TINYINT NOT NULL,
	raftId SMALLINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cRaftId),
	KEY (raftId)
) ;


CREATE TABLE prv_cnf_Filter
(
	cFilterId TINYINT NOT NULL,
	filterId TINYINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cFilterId),
	KEY (filterId)
) ;


CREATE TABLE prv_CCD
(
	ccdId SMALLINT NOT NULL,
	raftId SMALLINT NOT NULL,
	amp01 SMALLINT NOT NULL,
	amp02 SMALLINT NOT NULL,
	amp03 SMALLINT NOT NULL,
	amp04 SMALLINT NOT NULL,
	amp05 SMALLINT NOT NULL,
	amp06 SMALLINT NOT NULL,
	amp07 SMALLINT NOT NULL,
	amp08 SMALLINT NOT NULL,
	amp09 SMALLINT NOT NULL,
	amp10 SMALLINT NOT NULL,
	PRIMARY KEY (ccdId),
	KEY (raftId)
) ;


CREATE TABLE prv_StageToUpdatableColumn
(
	stageId SMALLINT NOT NULL,
	columnId SMALLINT NOT NULL,
	cStageToUpdateColumnId SMALLINT NOT NULL,
	KEY (stageId),
	KEY (columnId),
	KEY (cStageToUpdateColumnId)
) ;


CREATE TABLE prv_StageToPipeline
(
	stageToPipelineId MEDIUMINT NOT NULL,
	pipelineId TINYINT NOT NULL,
	stageId SMALLINT NOT NULL,
	PRIMARY KEY (stageToPipelineId),
	KEY (pipelineId),
	KEY (stageId)
) ;


CREATE TABLE prv_PipelineToRun
(
	pipelineToRunId MEDIUMINT NOT NULL,
	runId MEDIUMINT NOT NULL,
	pipelineId TINYINT NOT NULL,
	PRIMARY KEY (pipelineToRunId),
	KEY (runId),
	KEY (pipelineId)
) ;


CREATE TABLE prv_cnf_StageToSlice
(
	cStageToSliceId MEDIUMINT NOT NULL,
	stageToSliceId MEDIUMINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cStageToSliceId),
	KEY (stageToSliceId)
) ;


CREATE TABLE prv_cnf_Slice
(
	nodeId SMALLINT NOT NULL,
	sliceId MEDIUMINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	KEY (nodeId),
	KEY (sliceId)
) ;


CREATE TABLE prv_cnf_PolicyKey
(
	policyKeyId INTEGER NOT NULL,
	value TEXT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (policyKeyId),
	KEY (policyKeyId)
) ;


CREATE TABLE prv_cnf_Node
(
	cNodeId INTEGER NOT NULL,
	nodeId SMALLINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cNodeId),
	KEY (nodeId)
) ;


CREATE TABLE _aux_FPA_Fringe2CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE _aux_FPA_Flat2CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE _aux_FPA_Dark2CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE _aux_FPA_Bias2CMExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE Science_Amp_Exposure
(
	scienceAmpExposureId BIGINT NOT NULL,
	scienceCCDExposureId BIGINT NOT NULL,
	sdqa_imageStatusId SMALLINT NOT NULL,
	PRIMARY KEY (scienceAmpExposureId),
	KEY (scienceAmpExposureId),
	KEY (scienceCCDExposureId),
	KEY (sdqa_imageStatusId)
) ;


CREATE TABLE _Science_FPA_Exposure_Group
(
	cseGroupId MEDIUMINT NOT NULL,
	darkTime DATETIME NULL,
	biasTime DATETIME NULL,
	u_fringeTime DATETIME NULL,
	g_fringeTime DATETIME NULL,
	r_fringeTime DATETIME NULL,
	i_fringeTime DATETIME NULL,
	z_fringeTime DATETIME NULL,
	y_fringeTime DATETIME NULL,
	u_flatTime DATETIME NULL,
	g_flatTime DATETIME NULL,
	r_flatTime DATETIME NULL,
	i_flatTime DATETIME NULL,
	z_flatTime DATETIME NULL,
	y_flatTime DATETIME NULL,
	cmBiasExposureId INTEGER NULL,
	cmDarkExposureId INTEGER NULL,
	u_cmFlatExposureId INTEGER NULL,
	g_cmFlatExposureId INTEGER NULL,
	r_cmFlatExposureId INTEGER NULL,
	i_cmFlatExposureId INTEGER NULL,
	z_cmFlatExposureId INTEGER NULL,
	y_cmFlatExposureId INTEGER NULL,
	u_cmFringeExposureId INTEGER NULL,
	g_cmFringeExposureId INTEGER NULL,
	r_cmFringeExposureId INTEGER NULL,
	i_cmFringeExposureId INTEGER NULL,
	z_cmFringeExposureId INTEGER NULL,
	y_cmFringeExposureId INTEGER NULL,
	PRIMARY KEY (cseGroupId),
	KEY (cmBiasExposureId),
	KEY (cmDarkExposureId),
	KEY (u_cmFlatExposureId)
) ;


CREATE TABLE mops_SSM
(
	ssmId BIGINT NOT NULL AUTO_INCREMENT,
	ssmDescId SMALLINT NULL,
	q DOUBLE NOT NULL,
	e DOUBLE NOT NULL,
	i DOUBLE NOT NULL,
	node DOUBLE NOT NULL,
	argPeri DOUBLE NOT NULL,
	timePeri DOUBLE NOT NULL,
	epoch DOUBLE NOT NULL,
	h_v DOUBLE NOT NULL,
	h_ss DOUBLE NULL,
	g DOUBLE NULL,
	albedo DOUBLE NULL,
	ssmObjectName VARCHAR(32) NOT NULL,
	PRIMARY KEY (ssmId),
	UNIQUE UQ_mopsSSM_ssmObjectName(ssmObjectName),
	INDEX idx_mopsSSM_ssmDescId (ssmDescId ASC),
	INDEX idx_mopsSSM_epoch (epoch ASC)
) ;


CREATE TABLE sdqa_Threshold
(
	sdqa_thresholdId SMALLINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	upperThreshold DOUBLE NULL,
	lowerThreshold DOUBLE NULL,
	createdDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (sdqa_thresholdId),
	UNIQUE UQ_sdqa_Threshold_sdqa_metricId(sdqa_metricId),
	KEY (sdqa_metricId)
) ;


CREATE TABLE sdqa_Rating_ForScienceFPAExposure
(
	sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	exposureId INTEGER NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricErr FLOAT(0) NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	UNIQUE UQ_sdqa_Rating_ForScienceFPAExposure_metricId_exposureId(sdqa_metricId, exposureId),
	KEY (exposureId),
	KEY (sdqa_metricId),
	KEY (sdqa_thresholdId)
) ;


CREATE TABLE sdqa_Rating_ForScienceAmpExposure
(
	sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	ampExposureId BIGINT NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricErr FLOAT(0) NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	UNIQUE UQ_sdqa_Rating_ForScienceAmpExposure_metricId_ampExposureId(sdqa_metricId, ampExposureId),
	KEY (sdqa_metricId),
	KEY (sdqa_thresholdId),
	KEY (ampExposureId)
) ;


CREATE TABLE _SourceClassifToDescr
(
	scId INTEGER NOT NULL,
	scAttrId SMALLINT NOT NULL,
	scDescrId SMALLINT NOT NULL,
	status BIT NULL DEFAULT 1,
	KEY (scId),
	KEY (scAttrId),
	KEY (scDescrId)
) ;


CREATE TABLE _ObjectToType
(
	objectId BIGINT NOT NULL,
	typeId SMALLINT NOT NULL,
	probability TINYINT NULL DEFAULT 100,
	KEY (typeId),
	KEY (objectId)
) ;


CREATE TABLE _MovingObjectToType
(
	movingObjectId BIGINT NOT NULL,
	typeId SMALLINT NOT NULL,
	probability TINYINT NULL DEFAULT 100,
	KEY (typeId),
	KEY (movingObjectId)
) ;


CREATE TABLE _AlertToType
(
	alertTypeId SMALLINT NOT NULL,
	alertId INTEGER NOT NULL,
	KEY (alertId),
	KEY (alertTypeId)
) ;


CREATE TABLE prv_UpdatableColumn
(
	columnId SMALLINT NOT NULL,
	tableId SMALLINT NOT NULL,
	columnName VARCHAR(64) NOT NULL,
	PRIMARY KEY (columnId),
	KEY (tableId)
) ;


CREATE TABLE prv_Telescope
(
	telescopeId TINYINT NOT NULL,
	focalPlaneId TINYINT NOT NULL,
	PRIMARY KEY (telescopeId),
	KEY (focalPlaneId)
) ;


CREATE TABLE prv_Raft
(
	raftId SMALLINT NOT NULL,
	focalPlaneId TINYINT NOT NULL,
	ccd01 SMALLINT NOT NULL,
	ccd02 SMALLINT NOT NULL,
	ccd03 SMALLINT NOT NULL,
	ccd04 SMALLINT NOT NULL,
	ccd05 SMALLINT NOT NULL,
	ccd06 SMALLINT NOT NULL,
	ccd07 SMALLINT NOT NULL,
	ccd08 SMALLINT NOT NULL,
	ccd09 SMALLINT NOT NULL,
	PRIMARY KEY (raftId),
	KEY (focalPlaneId)
) ;


CREATE TABLE prv_Filter
(
	filterId TINYINT NOT NULL,
	focalPlaneId TINYINT NOT NULL,
	name VARCHAR(80) NOT NULL,
	url VARCHAR(255) NULL,
	clam FLOAT(0) NOT NULL,
	bw FLOAT(0) NOT NULL,
	PRIMARY KEY (filterId),
	UNIQUE name(name),
	INDEX focalPlaneId (focalPlaneId ASC)
) TYPE=MyISAM;


CREATE TABLE prv_cnf_FocalPlane
(
	cFocalPlaneId SMALLINT NOT NULL,
	focalPlaneId TINYINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cFocalPlaneId),
	KEY (focalPlaneId)
) ;


CREATE TABLE prv_StageToSlice
(
	stageToSliceId MEDIUMINT NOT NULL,
	stageId SMALLINT NOT NULL,
	sliceId MEDIUMINT NOT NULL,
	PRIMARY KEY (stageToSliceId),
	KEY (stageId),
	KEY (sliceId)
) ;


CREATE TABLE prv_Stage
(
	stageId SMALLINT NOT NULL,
	policyId MEDIUMINT NOT NULL,
	stageName VARCHAR(255) NULL,
	PRIMARY KEY (stageId),
	KEY (policyId)
) ;


CREATE TABLE prv_Run
(
	runId MEDIUMINT NOT NULL,
	policyId MEDIUMINT NOT NULL,
	PRIMARY KEY (runId),
	KEY (policyId)
) ;


CREATE TABLE prv_PolicyKey
(
	policyKeyId INTEGER NOT NULL,
	policyFileId INTEGER NOT NULL,
	keyName VARCHAR(255) NOT NULL,
	keyType VARCHAR(16) NOT NULL,
	PRIMARY KEY (policyKeyId),
	KEY (policyFileId)
) ;


CREATE TABLE prv_Pipeline
(
	pipelineId TINYINT NOT NULL,
	policyId MEDIUMINT NOT NULL,
	pipelineName VARCHAR(64) NULL,
	PRIMARY KEY (pipelineId),
	KEY (policyId)
) ;


CREATE TABLE prv_Node
(
	nodeId SMALLINT NOT NULL,
	policyId MEDIUMINT NOT NULL,
	PRIMARY KEY (nodeId),
	KEY (policyId)
) ;


CREATE TABLE prv_cnf_SoftwarePackage
(
	packageId INTEGER NOT NULL,
	version VARCHAR(255) NOT NULL,
	directory VARCHAR(255) NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (packageId),
	KEY (packageId)
) ;


CREATE TABLE prv_cnf_Policy
(
	cPolicyId MEDIUMINT NOT NULL,
	policyId MEDIUMINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (cPolicyId),
	KEY (policyId)
) ;


CREATE TABLE aux_Source
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_IR_FPA_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Science_FPA_SpectraExposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Flat_FPA_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Dark_FPA_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Calibration_FPA_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Bias_FPA_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE TemplateImage
(
	templateImageId INTEGER NOT NULL,
	PRIMARY KEY (templateImageId)
) ;


CREATE TABLE PostageStampJpegs
(
	ra DOUBLE NOT NULL,
	decl DOUBLE NULL,
	sizeRa FLOAT(0) NOT NULL,
	sizeDecl FLOAT(0) NOT NULL,
	url VARCHAR(255) NULL
) ;


CREATE TABLE Fringe_FPA_CMExposure
(
	cdFringeExposureId INTEGER NOT NULL,
	PRIMARY KEY (cdFringeExposureId)
) ;


CREATE TABLE Flat_FPA_CMExposure
(
	cmFlatExposureId INTEGER NOT NULL,
	PRIMARY KEY (cmFlatExposureId)
) ;


CREATE TABLE Dark_FPA_CMExposure
(
	cmDarkExposureId INTEGER NOT NULL,
	PRIMARY KEY (cmDarkExposureId)
) ;


CREATE TABLE CalibType
(
	calibTypeId TINYINT NOT NULL,
	descr VARCHAR(255) NULL,
	PRIMARY KEY (calibTypeId)
) ;


CREATE TABLE Bias_FPA_CMExposure
(
	cmBiasExposureId INTEGER NOT NULL,
	PRIMARY KEY (cmBiasExposureId)
) ;


CREATE TABLE mops_SSMDesc
(
	ssmDescId SMALLINT NOT NULL AUTO_INCREMENT,
	prefix CHAR(4) NULL,
	description VARCHAR(100) NULL,
	PRIMARY KEY (ssmDescId)
) ;


CREATE TABLE _tmpl_mops_Prediction
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INTEGER NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	mjd DOUBLE NOT NULL,
	smia DOUBLE NOT NULL,
	smaa DOUBLE NOT NULL,
	pa DOUBLE NOT NULL,
	mag DOUBLE NOT NULL,
	magErr FLOAT(0) NOT NULL
) TYPE=MyISAM;


CREATE TABLE _tmpl_mops_Ephemeris
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INTEGER NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	mjd DOUBLE NOT NULL,
	smia DOUBLE NULL,
	smaa DOUBLE NULL,
	pa DOUBLE NULL,
	mag DOUBLE NULL,
	INDEX idx_mopsEphemeris_movingObjectId (movingObjectId ASC)
) TYPE=MyISAM;


CREATE TABLE _mops_Config
(
	configId BIGINT NOT NULL AUTO_INCREMENT,
	configText TEXT NULL,
	PRIMARY KEY (configId)
) ;


CREATE TABLE sdqa_Metric
(
	sdqa_metricId SMALLINT NOT NULL AUTO_INCREMENT,
	metricName VARCHAR(30) NOT NULL,
	physicalUnits VARCHAR(30) NOT NULL,
	dataType CHAR(1) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_metricId),
	UNIQUE UQ_sdqa_Metric_metricName(metricName)
) ;


CREATE TABLE sdqa_ImageStatus
(
	sdqa_imageStatusId SMALLINT NOT NULL AUTO_INCREMENT,
	statusName VARCHAR(30) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_imageStatusId)
) ;


CREATE TABLE SourceClassifDescr
(
	scDescrId SMALLINT NOT NULL,
	scDescr VARCHAR(255) NOT NULL,
	PRIMARY KEY (scDescrId)
) ;


CREATE TABLE SourceClassifAttr
(
	scAttrId SMALLINT NOT NULL,
	scAttrDescr VARCHAR(255) NOT NULL,
	PRIMARY KEY (scAttrId)
) ;


CREATE TABLE SourceClassif
(
	scId INTEGER NOT NULL,
	PRIMARY KEY (scId)
) ;


CREATE TABLE ObjectType
(
	typeId SMALLINT NOT NULL,
	description VARCHAR(255) NULL,
	PRIMARY KEY (typeId)
) ;


CREATE TABLE DIASourceIDTonight
(
	DIASourceId BIGINT NOT NULL
) ;


CREATE TABLE AlertType
(
	alertTypeId SMALLINT NOT NULL,
	alertTypeDescr VARCHAR(50) NULL,
	PRIMARY KEY (alertTypeId)
) TYPE=MyISAM;


CREATE TABLE _tmpl_MatchPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL,
	distance DOUBLE NOT NULL
) ;


CREATE TABLE _tmpl_IdPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL
) ;


CREATE TABLE _tmpl_Id
(
	id BIGINT NOT NULL
) ;


CREATE TABLE prv_UpdatableTable
(
	tableId SMALLINT NOT NULL,
	tableName VARCHAR(64) NOT NULL,
	PRIMARY KEY (tableId)
) ;


CREATE TABLE prv_FocalPlane
(
	focalPlaneId TINYINT NOT NULL,
	PRIMARY KEY (focalPlaneId)
) ;


CREATE TABLE prv_SoftwarePackage
(
	packageId INTEGER NOT NULL,
	packageName VARCHAR(64) NOT NULL,
	PRIMARY KEY (packageId)
) ;


CREATE TABLE prv_Slice
(
	sliceId MEDIUMINT NOT NULL,
	PRIMARY KEY (sliceId)
) ;


CREATE TABLE prv_PolicyFile
(
	policyFileId INTEGER NOT NULL,
	pathName VARCHAR(255) NOT NULL,
	hashValue CHAR(32) NOT NULL,
	modifiedDate BIGINT NOT NULL,
	PRIMARY KEY (policyFileId)
) ;


CREATE TABLE prv_Policy
(
	policyId MEDIUMINT NOT NULL,
	policyName VARCHAR(80) NOT NULL,
	PRIMARY KEY (policyId)
) ;


CREATE TABLE prv_cnf_StageToUpdatableColumn
(
	c_stageToUpdatableColumn SMALLINT NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (c_stageToUpdatableColumn)
) ;


CREATE TABLE placeholder_SQLLog
(
	sqlLogId BIGINT NOT NULL,
	tstamp DATETIME NOT NULL,
	elapsed FLOAT(0) NOT NULL,
	userId INTEGER NOT NULL,
	domain VARCHAR(80) NOT NULL,
	ipaddr VARCHAR(80) NOT NULL,
	query TEXT NOT NULL,
	PRIMARY KEY (sqlLogId)
) TYPE=MyISAM;


CREATE TABLE placeholder_Source
(
	moment0 FLOAT(0) NULL,
	moment1_x FLOAT(0) NULL,
	moment1_y FLOAT(0) NULL,
	moment2_xx FLOAT(0) NULL,
	moment2_xy FLOAT(0) NULL,
	moment2_yy FLOAT(0) NULL,
	moment3_xxx FLOAT(0) NULL,
	moment3_xxy FLOAT(0) NULL,
	moment3_xyy FLOAT(0) NULL,
	moment3_yyy FLOAT(0) NULL,
	moment4_xxxx FLOAT(0) NULL,
	moment4_xxxy FLOAT(0) NULL,
	moment4_xxyy FLOAT(0) NULL,
	moment4_xyyy FLOAT(0) NULL,
	moment4_yyyy FLOAT(0) NULL
) ;


CREATE TABLE placeholder_Object
(
	uScalegram01 FLOAT(0) NULL,
	uScalegram02 FLOAT(0) NULL,
	uScalegram03 FLOAT(0) NULL,
	uScalegram04 FLOAT(0) NULL,
	uScalegram05 FLOAT(0) NULL,
	uScalegram06 FLOAT(0) NULL,
	uScalegram07 FLOAT(0) NULL,
	uScalegram08 FLOAT(0) NULL,
	uScalegram09 FLOAT(0) NULL,
	uScalegram10 FLOAT(0) NULL,
	uScalegram11 FLOAT(0) NULL,
	uScalegram12 FLOAT(0) NULL,
	uScalegram13 FLOAT(0) NULL,
	uScalegram14 FLOAT(0) NULL,
	uScalegram15 FLOAT(0) NULL,
	uScalegram16 FLOAT(0) NULL,
	uScalegram17 FLOAT(0) NULL,
	uScalegram18 FLOAT(0) NULL,
	uScalegram19 FLOAT(0) NULL,
	uScalegram20 FLOAT(0) NULL,
	uScalegram21 FLOAT(0) NULL,
	uScalegram22 FLOAT(0) NULL,
	uScalegram23 FLOAT(0) NULL,
	uScalegram24 FLOAT(0) NULL,
	uScalegram25 FLOAT(0) NULL,
	gScalegram01 FLOAT(0) NULL,
	gScalegram02 FLOAT(0) NULL,
	gScalegram03 FLOAT(0) NULL,
	gScalegram04 FLOAT(0) NULL,
	gScalegram05 FLOAT(0) NULL,
	gScalegram06 FLOAT(0) NULL,
	gScalegram07 FLOAT(0) NULL,
	gScalegram08 FLOAT(0) NULL,
	gScalegram09 FLOAT(0) NULL,
	gScalegram10 FLOAT(0) NULL,
	gScalegram11 FLOAT(0) NULL,
	gScalegram12 FLOAT(0) NULL,
	gScalegram13 FLOAT(0) NULL,
	gScalegram14 FLOAT(0) NULL,
	gScalegram15 FLOAT(0) NULL,
	gScalegram16 FLOAT(0) NULL,
	gScalegram17 FLOAT(0) NULL,
	gScalegram18 FLOAT(0) NULL,
	gScalegram19 FLOAT(0) NULL,
	gScalegram20 FLOAT(0) NULL,
	gScalegram21 FLOAT(0) NULL,
	gScalegram22 FLOAT(0) NULL,
	gScalegram23 FLOAT(0) NULL,
	gScalegram24 FLOAT(0) NULL,
	gScalegram25 FLOAT(0) NULL,
	rScalegram01 FLOAT(0) NULL,
	rScalegram02 FLOAT(0) NULL,
	rScalegram03 FLOAT(0) NULL,
	rScalegram04 FLOAT(0) NULL,
	rScalegram05 FLOAT(0) NULL,
	rScalegram06 FLOAT(0) NULL,
	rScalegram07 FLOAT(0) NULL,
	rScalegram08 FLOAT(0) NULL,
	rScalegram09 FLOAT(0) NULL,
	rScalegram10 FLOAT(0) NULL,
	rScalegram11 FLOAT(0) NULL,
	rScalegram12 FLOAT(0) NULL,
	rScalegram13 FLOAT(0) NULL,
	rScalegram14 FLOAT(0) NULL,
	rScalegram15 FLOAT(0) NULL,
	rScalegram16 FLOAT(0) NULL,
	rScalegram17 FLOAT(0) NULL,
	rScalegram18 FLOAT(0) NULL,
	rScalegram19 FLOAT(0) NULL,
	rScalegram20 FLOAT(0) NULL,
	rScalegram21 FLOAT(0) NULL,
	rScalegram22 FLOAT(0) NULL,
	rScalegram23 FLOAT(0) NULL,
	rScalegram24 FLOAT(0) NULL,
	rScalegram25 FLOAT(0) NULL,
	iScalegram01 FLOAT(0) NULL,
	iScalegram02 FLOAT(0) NULL,
	iScalegram03 FLOAT(0) NULL,
	iScalegram04 FLOAT(0) NULL,
	iScalegram05 FLOAT(0) NULL,
	iScalegram06 FLOAT(0) NULL,
	iScalegram07 FLOAT(0) NULL,
	iScalegram08 FLOAT(0) NULL,
	iScalegram09 FLOAT(0) NULL,
	iScalegram10 FLOAT(0) NULL,
	iScalegram11 FLOAT(0) NULL,
	iScalegram12 FLOAT(0) NULL,
	iScalegram13 FLOAT(0) NULL,
	iScalegram14 FLOAT(0) NULL,
	iScalegram15 FLOAT(0) NULL,
	iScalegram16 FLOAT(0) NULL,
	iScalegram17 FLOAT(0) NULL,
	iScalegram18 FLOAT(0) NULL,
	iScalegram19 FLOAT(0) NULL,
	iScalegram20 FLOAT(0) NULL,
	iScalegram21 FLOAT(0) NULL,
	iScalegram22 FLOAT(0) NULL,
	iScalegram23 FLOAT(0) NULL,
	iScalegram24 FLOAT(0) NULL,
	iScalegram25 FLOAT(0) NULL,
	zScalegram01 FLOAT(0) NULL,
	zScalegram02 FLOAT(0) NULL,
	zScalegram03 FLOAT(0) NULL,
	zScalegram04 FLOAT(0) NULL,
	zScalegram05 FLOAT(0) NULL,
	zScalegram06 FLOAT(0) NULL,
	zScalegram07 FLOAT(0) NULL,
	zScalegram08 FLOAT(0) NULL,
	zScalegram09 FLOAT(0) NULL,
	zScalegram10 FLOAT(0) NULL,
	zScalegram11 FLOAT(0) NULL,
	zScalegram12 FLOAT(0) NULL,
	zScalegram13 FLOAT(0) NULL,
	zScalegram14 FLOAT(0) NULL,
	zScalegram15 FLOAT(0) NULL,
	zScalegram16 FLOAT(0) NULL,
	zScalegram17 FLOAT(0) NULL,
	zScalegram18 FLOAT(0) NULL,
	zScalegram19 FLOAT(0) NULL,
	zScalegram20 FLOAT(0) NULL,
	zScalegram21 FLOAT(0) NULL,
	zScalegram22 FLOAT(0) NULL,
	zScalegram23 FLOAT(0) NULL,
	zScalegram24 FLOAT(0) NULL,
	zScalegram25 FLOAT(0) NULL,
	yScalegram01 FLOAT(0) NULL,
	yScalegram02 FLOAT(0) NULL,
	yScalegram03 FLOAT(0) NULL,
	yScalegram04 FLOAT(0) NULL,
	yScalegram05 FLOAT(0) NULL,
	yScalegram06 FLOAT(0) NULL,
	yScalegram07 FLOAT(0) NULL,
	yScalegram08 FLOAT(0) NULL,
	yScalegram09 FLOAT(0) NULL,
	yScalegram10 FLOAT(0) NULL,
	yScalegram11 FLOAT(0) NULL,
	yScalegram12 FLOAT(0) NULL,
	yScalegram13 FLOAT(0) NULL,
	yScalegram14 FLOAT(0) NULL,
	yScalegram15 FLOAT(0) NULL,
	yScalegram16 FLOAT(0) NULL,
	yScalegram17 FLOAT(0) NULL,
	yScalegram18 FLOAT(0) NULL,
	yScalegram19 FLOAT(0) NULL,
	yScalegram20 FLOAT(0) NULL,
	yScalegram21 FLOAT(0) NULL,
	yScalegram22 FLOAT(0) NULL,
	yScalegram23 FLOAT(0) NULL,
	yScalegram24 FLOAT(0) NULL,
	yScalegram25 FLOAT(0) NULL
) ;


CREATE TABLE placeholder_Alert
(
	__voEventId BIGINT NULL
) ;


CREATE TABLE aux_Object
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_SED
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_LIDARshot
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_FPA_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_CloudMap
(
	dummy INTEGER NULL
) ;


CREATE TABLE aux_Amp_Exposure
(
	dummy INTEGER NULL
) ;


CREATE TABLE _aux_Science_FPA_SpectraExposure_Group
(
	dummy INTEGER NULL
) ;





ALTER TABLE _mops_MoidQueue ADD CONSTRAINT FK__mops_MoidQueue_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE _mops_EonQueue ADD CONSTRAINT FK__mopsEonQueue_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE DIASource ADD CONSTRAINT FK_DIASource_Raw_Amp_Exposure 
	FOREIGN KEY (ampExposureId) REFERENCES Raw_Amp_Exposure (rawAmpExposureId);

ALTER TABLE Alert ADD CONSTRAINT FK_Alert_Object 
	FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Calibration_CCD_Exposure ADD CONSTRAINT FK_Calibration_CCD_Exposure_Calibration_FPA_Exposure 
	FOREIGN KEY (exposureId) REFERENCES Calibration_FPA_Exposure (calibrationFPAExposureId);

ALTER TABLE Calibration_CCD_Exposure ADD CONSTRAINT FK_Calibration_CCD_Exposure_Raw_CCD_Exposure 
	FOREIGN KEY (ccdExposureId) REFERENCES Raw_CCD_Exposure (rawCCDExposureId);

ALTER TABLE Calibration_Amp_Exposure ADD CONSTRAINT FK_Calibration_Amp_Exposure_Calibration_CCD_Exposure 
	FOREIGN KEY (ccdExposureId) REFERENCES Calibration_CCD_Exposure (ccdExposureId);

ALTER TABLE Calibration_Amp_Exposure ADD CONSTRAINT FK_Calibration_Amp_Exposure_Raw_Amp_Exposure 
	FOREIGN KEY (ampExposureId) REFERENCES Raw_Amp_Exposure (rawAmpExposureId);

ALTER TABLE placeholder_VarObject ADD CONSTRAINT FK_VarObject_Object_objectId 
	FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE placeholder_ObjectPhotoZ ADD CONSTRAINT FK_ObjectPhotoZ_Object_objectId 
	FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Science_CCD_Exposure ADD CONSTRAINT FK_Science_CCD_Exposure_Raw_CCD_Exposure 
	FOREIGN KEY (scienceCCDExposureId) REFERENCES Raw_CCD_Exposure (rawCCDExposureId);

ALTER TABLE Science_CCD_Exposure ADD CONSTRAINT FK_Science_CCD_Exposure_Science_FPA_Exposure 
	FOREIGN KEY (scienceFPAExposureId) REFERENCES Science_FPA_Exposure (scienceFPAExposureId);

ALTER TABLE Raw_CCD_Exposure ADD CONSTRAINT FK_CCDExposure_FPAExposure_exposureId 
	FOREIGN KEY (rawFPAExposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE Raw_Amp_Exposure ADD CONSTRAINT FK_AmpExposure_CCDExposure_ccdExposureId 
	FOREIGN KEY (rawCCDExposureId) REFERENCES Raw_CCD_Exposure (rawCCDExposureId);

ALTER TABLE prv_Snapshot ADD CONSTRAINT FK_Snapshot_ProcessingHistory 
	FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE prv_cnf_MaskAmpImage ADD CONSTRAINT FK_Config_MaskAmpImage_Amplifier 
	FOREIGN KEY (amplifierId) REFERENCES prv_Amplifier (amplifierId);

ALTER TABLE prv_cnf_Amplifier ADD CONSTRAINT FK_Config_Amplifier_Amplifier 
	FOREIGN KEY (amplifierId) REFERENCES prv_Amplifier (amplifierId);

ALTER TABLE Visit ADD CONSTRAINT FK_Visit_Raw_FPA_Exposure 
	FOREIGN KEY (rawFPAExposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE Calibration_FPA_Exposure ADD CONSTRAINT FK_CalibrationFPAExposure_FPAExposure_exposureId 
	FOREIGN KEY (calibrationFPAExposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE prv_cnf_CCD ADD CONSTRAINT FK_Config_CCD_CCD 
	FOREIGN KEY (ccdId) REFERENCES prv_CCD (ccdId);

ALTER TABLE prv_Amplifier ADD CONSTRAINT FK_Amplifier_CCD 
	FOREIGN KEY (ccdId) REFERENCES prv_CCD (ccdId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_RawAmpExposure_ampExposureId 
	FOREIGN KEY (ampExposureId) REFERENCES Raw_Amp_Exposure (rawAmpExposureId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_Object_objectId 
	FOREIGN KEY (objectId) REFERENCES Object (latestObsTime);

ALTER TABLE Raw_FPA_Exposure ADD CONSTRAINT FK_FPAExposure_Filter_filterId 
	FOREIGN KEY (filterId) REFERENCES prv_Filter (filterId);

ALTER TABLE mops_Tracklet ADD CONSTRAINT FK_mopsTracklets_mopsSSM 
	FOREIGN KEY (ssmId) REFERENCES mops_SSM (ssmId);

ALTER TABLE mops_Tracklet ADD CONSTRAINT FK_mopsTracklets_ScienceCCDExposure 
	FOREIGN KEY (ccdExposureId) REFERENCES Science_CCD_Exposure (scienceCCDExposureId);

ALTER TABLE prv_cnf_Telescope ADD CONSTRAINT FK_Config_Telescope_Telescope 
	FOREIGN KEY (telescopeId) REFERENCES prv_Telescope (telescopeId);

ALTER TABLE prv_cnf_Raft ADD CONSTRAINT FK_Config_Raft_Raft 
	FOREIGN KEY (raftId) REFERENCES prv_Raft (raftId);

ALTER TABLE prv_cnf_Filter ADD CONSTRAINT FK_Config_Filter_Filter 
	FOREIGN KEY (filterId) REFERENCES prv_Filter (filterId);

ALTER TABLE prv_CCD ADD CONSTRAINT FK_CCD_Raft 
	FOREIGN KEY (raftId) REFERENCES prv_Raft (raftId);

ALTER TABLE prv_cnf_Slice ADD CONSTRAINT FK_Config_Slice_Node 
	FOREIGN KEY (nodeId) REFERENCES prv_Node (nodeId);

ALTER TABLE prv_cnf_Slice ADD CONSTRAINT FK_Config_Slice_Slice 
	FOREIGN KEY (sliceId) REFERENCES prv_Slice (sliceId);

ALTER TABLE prv_cnf_PolicyKey ADD CONSTRAINT FK_prv_cnf_PolicyKey_prv_PolicyKey 
	FOREIGN KEY (policyKeyId) REFERENCES prv_PolicyKey (policyKeyId);

ALTER TABLE prv_cnf_Node ADD CONSTRAINT FK_Config_Node_Node 
	FOREIGN KEY (nodeId) REFERENCES prv_Node (nodeId);

ALTER TABLE Science_Amp_Exposure ADD CONSTRAINT FK_Science_Amp_Exposure_Raw_Amp_Exposure 
	FOREIGN KEY (scienceAmpExposureId) REFERENCES Raw_Amp_Exposure (rawAmpExposureId);

ALTER TABLE Science_Amp_Exposure ADD CONSTRAINT FK_Science_Amp_Exposure_Science_CCD_Exposure 
	FOREIGN KEY (scienceCCDExposureId) REFERENCES Science_CCD_Exposure (scienceCCDExposureId);

ALTER TABLE Science_Amp_Exposure ADD CONSTRAINT FK_ScienceAmpExposure_sdqaImageStatus 
	FOREIGN KEY (sdqa_imageStatusId) REFERENCES sdqa_ImageStatus (sdqa_imageStatusId);

ALTER TABLE _Science_FPA_Exposure_Group ADD CONSTRAINT FK_CalibratedScienceExposure_Group_CMBiasExposure 
	FOREIGN KEY (cmBiasExposureId) REFERENCES Bias_FPA_CMExposure (cmBiasExposureId);

ALTER TABLE _Science_FPA_Exposure_Group ADD CONSTRAINT FK_CalibratedScienceExposure_Group_CMDarkExposure 
	FOREIGN KEY (cmDarkExposureId) REFERENCES Dark_FPA_CMExposure (cmDarkExposureId);

ALTER TABLE mops_SSM ADD CONSTRAINT FK_mopsSSM_mopsSSMDesc 
	FOREIGN KEY (ssmDescId) REFERENCES mops_SSMDesc (ssmDescId);

ALTER TABLE sdqa_Threshold ADD CONSTRAINT FK_sdqa_Threshold_sdqa_Metric 
	FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);

ALTER TABLE _SourceClassifToDescr ADD CONSTRAINT FK_SourceClassif2Descr_SourceClassif 
	FOREIGN KEY (scId) REFERENCES SourceClassif (scId);

ALTER TABLE _SourceClassifToDescr ADD CONSTRAINT FK_SourceClassif2Descr_SourceClassifAttr 
	FOREIGN KEY (scAttrId) REFERENCES SourceClassifAttr (scAttrId);

ALTER TABLE _SourceClassifToDescr ADD CONSTRAINT FK_SourceClassif2Descr_SourceClassifDescr 
	FOREIGN KEY (scDescrId) REFERENCES SourceClassifDescr (scDescrId);

ALTER TABLE prv_UpdatableColumn ADD CONSTRAINT FK_UpdatableColumn_UpdatableTable 
	FOREIGN KEY (tableId) REFERENCES prv_UpdatableTable (tableId);

ALTER TABLE prv_Telescope ADD CONSTRAINT FK_Telescope_FocalPlane 
	FOREIGN KEY (focalPlaneId) REFERENCES prv_FocalPlane (focalPlaneId);

ALTER TABLE prv_Raft ADD CONSTRAINT FK_Raft_FocalPlane 
	FOREIGN KEY (focalPlaneId) REFERENCES prv_FocalPlane (focalPlaneId);

ALTER TABLE prv_Filter ADD CONSTRAINT FK_Filter_FocalPlane 
	FOREIGN KEY (focalPlaneId) REFERENCES prv_FocalPlane (focalPlaneId);

ALTER TABLE prv_cnf_FocalPlane ADD CONSTRAINT FK_Config_FocalPlane_FocalPlane 
	FOREIGN KEY (focalPlaneId) REFERENCES prv_FocalPlane (focalPlaneId);

ALTER TABLE prv_Stage ADD CONSTRAINT FK_Stage_Policy 
	FOREIGN KEY (policyId) REFERENCES prv_Policy (policyId);

ALTER TABLE prv_Run ADD CONSTRAINT FK_Run_Policy 
	FOREIGN KEY (policyId) REFERENCES prv_Policy (policyId);

ALTER TABLE prv_PolicyKey ADD CONSTRAINT FK_prv_PolicyKey_prv_PolicyFile 
	FOREIGN KEY (policyFileId) REFERENCES prv_PolicyFile (policyFileId);

ALTER TABLE prv_Pipeline ADD CONSTRAINT FK_Pipeline_Policy 
	FOREIGN KEY (policyId) REFERENCES prv_Policy (policyId);

ALTER TABLE prv_Node ADD CONSTRAINT FK_Node_Policy 
	FOREIGN KEY (policyId) REFERENCES prv_Policy (policyId);

ALTER TABLE prv_cnf_SoftwarePackage ADD CONSTRAINT FK_prv_cnf_SoftwarePackage_prv_SoftwarePackage 
	FOREIGN KEY (packageId) REFERENCES prv_SoftwarePackage (packageId);
