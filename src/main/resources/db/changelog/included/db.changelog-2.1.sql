--liquibase formatted sql

--changeSet check_tariff:1; endDelimiter:/
CREATE TRIGGER `check_tariff` BEFORE update ON internet_provider.user
FOR EACH ROW
  begin
    IF NEW.tariff_id is not null and (NEW.status = 0 or NEW.status = 1)  THEN
      set NEW.traffic = (select traffic from internet_provider.tariff where tariff_id = NEW.tariff_id),
      NEW.status = 1;
	  elseif NEW.tariff_id is null and NEW.status = 1 THEN
      set NEW.traffic = null,
      NEW.status = 0;
	  END IF;
  end;

--changeSet check_cash:2; endDelimiter:/
CREATE TRIGGER `check_cash` BEFORE update ON internet_provider.user
FOR EACH ROW
  begin
    IF NEW.cash < 0 and NEW.status = 1 THEN
			set NEW.status = 2;
	  elseif NEW.cash > 0 and NEW.status = 2 and NEW.tariff_id is not null THEN
			set NEW.status = 1;
		elseif NEW.cash > 0 and NEW.status = 2 and NEW.tariff_id is null THEN
		  set NEW.status = 0;
	  END IF;
  end;

--changeSet check_status:3; endDelimiter:/
CREATE TRIGGER `check_status` BEFORE update ON internet_provider.user
FOR EACH ROW
  begin
    IF NEW.cash < OLD.cash and OLD.status = 2 THEN
			set @msg = "User is blocked";
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
	  END IF;
  end;

--changeSet check_bonus:4; endDelimiter:/
CREATE TRIGGER `check_bonus` BEFORE update ON internet_provider.user
FOR EACH ROW
  begin
    IF (NEW.cash - OLD.cash) > 20 THEN
			set NEW.bonus_amount = OLD.bonus_amount + 10;
	  elseif NEW.tariff_id != OLD.tariff_id or (OLD.tariff_id is null and NEW.tariff_id is not null) THEN
			set NEW.bonus_amount = OLD.bonus_amount + 50;
	  END IF;
  end;