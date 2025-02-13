--LAB-7 EXCEPTION HANDLING
CREATE TABLE CUSTOMERS(
	CUSTOMER_ID INT PRIMARY KEY,
	CUSTOMER_NAME VARCHAR(250) NOT NULL,
	EMAIL VARCHAR(250) UNIQUE
);

CREATE TABLE ORDERS(
	ORDER_ID INT PRIMARY KEY,
	CUSTOMER_ID INT FOREIGN KEY REFERENCES CUSTOMERS(CUSTOMER_ID),
	ORDER_DATE DATE NOT NULL
);
--Part – A 
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error. 
CREATE PROCEDURE PR_HANDLING_ZERO_EXCEPTION
AS BEGIN
	BEGIN TRY
		DECLARE @A INT;
		DECLARE @B INT;
		DECLARE @C INT;
		SET @A = 30
		SET @B = 0
		SET @C = @A/@B
	END TRY
	BEGIN CATCH
		PRINT 'CANNOT DIVIDE BY ZERO'
	END CATCH
END
EXEC PR_HANDLING_ZERO_EXCEPTION; 
--2. Try to convert string to integer and handle the error using try…catch block. 
CREATE PROCEDURE PR_CONV_STR_INT
AS BEGIN 
	BEGIN TRY
		DECLARE @STR VARCHAR(100);
		DECLARE @I INT;

		SET @STR = 'RAM'
		SET @I = CAST(@STR AS INT)
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END
EXEC PR_CONV_STR_INT;
--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result. (Doubt)
Alter PROCEDURE PR_SUM_ERROR(
	@n1 int,@n2 int
)
AS BEGIN
	DECLARE @ANS INT;
	BEGIN TRY
		SET @ANS = @N1 + @N2
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() as errormsg
		Select ERROR_LINE() as errorline
		select ERROR_PROCEDURE() as errorproc
		select ERROR_SEVERITY() as errorsever
	END CATCH
END 
exec PR_SUM_ERROR '2',3
--4. Handle a Primary Key Violation while inserting data into customers table and print the error details 
--such as the error message, error number, severity, and state. 
ALTER PROCEDURE PR_PK_VIOLATION(
	@CUSTID INT,
	@CUSTNAME VARCHAR(100),
	@CUSTEMAIL VARCHAR(100)
)
AS BEGIN 
	BEGIN TRY
		INSERT INTO CUSTOMERS VALUES(@CUSTID, @CUSTNAME,@CUSTEMAIL)
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERRORMSG
	END CATCH
END;
SELECT * FROM CUSTOMERS
EXEC PR_PK_VIOLATION 1,'RAM','R@R.COM';
EXEC PR_PK_VIOLATION 1,'SHIV','S@S.COM';

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws 
--Error like no Customer_id is available in database.(DOUBT)
ALTER PROCEDURE PR_CUSTID_INPUT(
	@CUSTID INT,
	@CUSTNAME VARCHAR(100),
	@CUSTEMAIL VARCHAR(100)
)
AS BEGIN 
	INSERT INTO CUSTOMERS VALUES(@CUSTID,@CUSTNAME,@CUSTEMAIL)
	BEGIN TRY
		SELECT @CUSTID FROM CUSTOMERS
	END TRY
	BEGIN CATCH
		IF @CUSTID NOT IN CUSTOMERS
		BEGIN
			PRINT 'CUSTOMER ID DOES NOT EXIST'
		END
	END CATCH
END;
SELECT * FROM CUSTOMERS
EXEC PR_CUSTID_INPUT 3,'SHIV','s@s.com'
