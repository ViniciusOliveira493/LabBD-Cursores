use bdEntrega
GO
CREATE PROCEDURE sp_organizarDados
AS
BEGIN
	DECLARE 
		@cliCPF VARCHAR(20)
	
	DECLARE envios CURSOR 
		FOR SELECT DISTINCT CPF from envio  
	OPEN envios
	FETCH NEXT FROM envios INTO @cliCPF
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sp_updateEnderecos @cliCPF
		FETCH NEXT FROM envios INTO @cliCPF
	END
	CLOSE envios
	DEALLOCATE envios
END
--====================================
GO
CREATE PROCEDURE sp_updateEnderecos(@cliCPF VARCHAR(20))
AS
BEGIN
	DECLARE 
		@cep 		VARCHAR(10)
		, @porta 	INT
		, @ende		varchar(200)
		, @comple	varchar(100)
		, @bairro	varchar(100)
		, @cidade	varchar(100)
		, @uf		varchar(2)
		, @numlinha int

	SET @numlinha = 1;

	DECLARE enderecos CURSOR FOR
		SELECT	CEP
				,PORTA
				,ENDERECO
				,COMPLEMENTO
				,BAIRRO
				,CIDADE
				,UF
		from endereco WHERE CPF = @cliCPF

	OPEN enderecos
	FETCH NEXT FROM enderecos INTO @cep, @porta, @ende, @comple, @bairro, @cidade, @uf
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @cliCPF

		UPDATE envio
		SET 
			NR_CEP = @cep
			, NR_ENDERECO = @porta
			, NM_ENDERECO = @ende
			, NM_COMPLEMENTO = @comple
			, NM_BAIRRO = @bairro
			, NM_CIDADE = @cidade
			, NM_UF = @uf
		WHERE 
			CPF = @cliCPF
			AND 
			NR_LINHA_ARQUIV = @numlinha

		SET @numLinha = @numLinha + 1;
		FETCH NEXT FROM enderecos INTO @cep, @porta, @ende, @comple, @bairro, @cidade, @uf
	END
	CLOSE enderecos
	DEALLOCATE enderecos
END
--====================================
exec sp_organizarDados