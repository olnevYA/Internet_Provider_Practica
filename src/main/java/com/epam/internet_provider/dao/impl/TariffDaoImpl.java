package com.epam.internet_provider.dao.impl;

import com.epam.internet_provider.connection.DbConnectionPool;
import com.epam.internet_provider.dao.TariffDao;
import com.epam.internet_provider.model.Tariff;
import io.vavr.control.Try;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jooq.impl.DSL;

import java.util.List;

public class TariffDaoImpl implements TariffDao {

  private static final Logger LOG = LogManager.getLogger(TariffDaoImpl.class);
  private DbConnectionPool connectionPool = DbConnectionPool.getInstance();
  private static final String SELECT_TARIFFS = "SELECT * FROM internet_provider.tariff";
  private static final String SELECT_TARIFF =
      "SELECT * FROM internet_provider.tariff WHERE title = ?";
  private static final String INSERT_TARIFF =
      "INSERT INTO internet_provider.tariff "
          + "(title, cost, download_speed, upload_speed, traffic, img_url) VALUES (?,?,?,?,?,?)";
  private static final String DELETE_TARIFF_BY_ID =
      "delete from internet_provider.tariff where tariff_id = ?";
  private static final String DELETE_TARIFF_BY_TITLE =
      "delete from internet_provider.tariff where title = ?";
  private static final String UPDATE_TARIFF =
      "update internet_provider.tariff "
          + "set title = ?, cost = ?, download_speed = ?, upload_speed = ?, traffic = ?, img_url = ?"
          + "where tariff_id = ?";

  @Override
  public List<Tariff> getTariffs() {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(connection -> DSL.using(connection).fetch(SELECT_TARIFFS).into(Tariff.class))
        .getOrElseGet(
            e -> {
              LOG.error("Runtime exception was throw in process of getTariffs: ", e);
              return null;
            });
  }

  @Override
  public Tariff getTariff(String title) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(connection -> DSL.using(connection).fetchOne(SELECT_TARIFF, title).into(Tariff.class))
        .getOrNull();
  }

  @Override
  public boolean createTariff(Tariff tariff) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            connection ->
                DSL.using(connection)
                    .fetch(
                        INSERT_TARIFF,
                        tariff.getTitle(),
                        tariff.getCost(),
                        tariff.getDownloadSpeed(),
                        tariff.getUploadSpeed(),
                        tariff.getTraffic(),
                        tariff.getImgUrl())
                    .isNotEmpty())
        .getOrElse(false);
  }

  @Override
  public boolean updateTariff(Tariff tariff) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            connection ->
                DSL.using(connection)
                    .fetch(
                        UPDATE_TARIFF,
                        tariff.getTitle(),
                        tariff.getCost(),
                        tariff.getDownloadSpeed(),
                        tariff.getUploadSpeed(),
                        tariff.getTraffic(),
                        tariff.getImgUrl(),
                        tariff.getId())
                    .isNotEmpty())
        .getOrElse(false);
  }

  @Override
  public boolean deleteTariff(int id) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(connection -> DSL.using(connection).fetch(DELETE_TARIFF_BY_ID, id).isNotEmpty())
        .getOrElse(false);
  }

  @Override
  public boolean deleteTariff(String title) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(connection -> DSL.using(connection).fetch(DELETE_TARIFF_BY_TITLE, title).isNotEmpty())
        .getOrElse(false);
  }
}
