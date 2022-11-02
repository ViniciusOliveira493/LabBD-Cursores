create database bdEntrega
GO
USE bdEntrega


create table envio (
    CPF varchar(20),
    NR_LINHA_ARQUIV	int,
    CD_FILIAL int,
    DT_ENVIO datetime,
    NR_DDD int,
    NR_TELEFONE	varchar(10),
    NR_RAMAL varchar(10),
    DT_PROCESSAMENT	datetime,
    NM_ENDERECO varchar(200),
    NR_ENDERECO int,
    NM_COMPLEMENTO	varchar(50),
    NM_BAIRRO varchar(100),
    NR_CEP varchar(10),
    NM_CIDADE varchar(100),
    NM_UF varchar(2)
);
GO
create table endereco(
    CPF varchar(20),
    CEP	varchar(10),
    PORTA	int,
    ENDERECO	varchar(200),
    COMPLEMENTO	varchar(100),
    BAIRRO	varchar(100),
    CIDADE	varchar(100),
    UF Varchar(2)
)
GO
create procedure sp_insereenvio
as
declare @cpf as int
declare @cont1 as int
declare @cont2 as int
declare @conttotal as int
set @cpf = 11111
set @cont1 = 1
set @cont2 = 1
set @conttotal = 1
	while @cont1 <= @cont2 and @cont2 < = 100
			begin
				insert into envio (CPF, NR_LINHA_ARQUIV, DT_ENVIO)
				values (cast(@cpf as varchar(20)), @cont1,GETDATE())
				insert into endereco (CPF,PORTA,ENDERECO)
				values (@cpf,@conttotal,CAST(@cont2 as varchar(3))+'Rua '+CAST(@conttotal as varchar(5)))
				set @cont1 = @cont1 + 1
				set @conttotal = @conttotal + 1
				if @cont1 > = @cont2
					begin
						set @cont1 = 1
						set @cont2 = @cont2 + 1
						set @cpf = @cpf + 1
					end
	end

exec sp_insereenvio