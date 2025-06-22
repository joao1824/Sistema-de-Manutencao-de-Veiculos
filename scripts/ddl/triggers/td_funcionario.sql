CREATE OR ALTER TRIGGER td_funcionarios ON funcionarios FOR DELETE AS
BEGIN
		ROLLBACK TRANSACTION;
        THROW 50002, 'Nao usar delete, Mudar status do funcionario.', 1;

    END
GO
