CREATE OR ALTER TRIGGER td_funcionarios ON funcionarios FOR DELETE AS
BEGIN
    IF DELETE(cd_funcionario)
    BEGIN
        THROW 50002, 'Nao usar delete, Mudar status do funcionario.', 1;
        ROLLBACK TRANSACTION;
    END
END
GO
