package com.epam.internet_provider.dao;

import com.epam.internet_provider.model.Tariff;

import java.util.List;

public interface TariffDao {

  List<Tariff> getTariffs();

  Tariff getTariff(String title);

  boolean createTariff(Tariff tariff);

  boolean updateTariff(Tariff tariff);

  boolean deleteTariff(int id);

  boolean deleteTariff(String title);
}
