CREATE PROCEDURE LastSixMonthTransactions(AccountId_Par INT)
BEGIN
	DECLARE AccountType_var VARCHAR(20);
	DECLARE Name_var CHAR(20);
	DECLARE CurrentBalance_var INT;
	DECLARE DateAndTime DATETIME DEFAULT(NOW());
    IF EXISTS (SELECT AccountId FROM AccountDetails WHERE AccountId=AccountId_par) THEN
	SELECT AccountType, Name, CurrentBalance INTO AccountType_var, Name_var, CurrentBalance_var FROM AccountDetails WHERE AccountId = AccountId_Par;
    SELECT CONCAT('Account Id :',AccountId_par);
    SELECT CONCAT('Name :',Name_var);
    SELECT CONCAT('Account Type :',AccountType_var);
    SELECT CONCAT('Date & Time :',DateAndTime);
    SELECT * FROM TransactionDetails WHERE AccountId = AccountId_Par AND TIMESTAMPDIFF(Month,Transactiontime,NOW())<=6;
    SELECT CONCAT('Current Balance :',CurrentBalance_var);
    ELSE
		SELECT 'Account Id is Invalid';
	END IF;
END