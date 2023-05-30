CREATE DEFINER=`root`@`localhost` PROCEDURE `ExceptionHandler`()
BEGIN
	DECLARE CONTINUE HANDLER FOR 1146
    BEGIN 
		SELECT 'Check Table Name' AS message;
	END;
		SELECT * FROM AcDtls;
		SELECT * FROM TransactionDetails;
END