package com.epam.internet_provider.dao.impl;

import com.epam.internet_provider.connection.DbConnectionPool;
import com.epam.internet_provider.dao.UserDao;
import com.epam.internet_provider.model.*;
import io.vavr.control.Try;
import org.jooq.impl.DSL;

import java.util.List;

public class UserDaoImpl implements UserDao {

  private static final String INSERT_NEW =
      "INSERT INTO internet_provider.user "
          + "(login, password, email, role, status, bonus_amount, cash) "
          + "VALUES(?,?,?,?,?,?,?)";
  private static final String SELECT_USER =
      "SELECT email, login, bonus_amount, role, status, cash, "
          + "user.tariff_id, title, cost, download_speed, upload_speed, tariff.traffic, img_url "
          + "FROM internet_provider.user "
          + "LEFT join internet_provider.tariff on user.tariff_id = tariff.tariff_id "
          + "where login = ?";
  private static final String SELECT_CREDENTIALS =
      "SELECT password, login, role, status FROM internet_provider.user where login = ? ";
  private static final String UPDATE_CASH =
      "UPDATE internet_provider.user set cash = cash + ? WHERE login = ?";
  private static final String UPDATE_TARIFF =
      "UPDATE internet_provider.user "
          + "inner JOIN internet_provider.tariff ON tariff.tariff_id = ? "
          + "set user.tariff_id = tariff.tariff_id, cash =  cash - cast(cost as signed) "
          + "WHERE user.login = ?";
  private static final String DELETE_TARIFF =
      "UPDATE internet_provider.user set tariff_id = null where login = ?";
  private static final String SELECT_REWARDS =
      "select reward.reward_id, title, bonus_points, img_href "
          + "from ((user_2reward inner join reward on reward.reward_id = user_2reward.reward_id) "
          + "inner join user on user.user_id = user_2reward.user_id) "
          + "where login = ?";
  private static final String SELECT_USERS =
      "SELECT * FROM internet_provider.user left join tariff on user.tariff_id = tariff.tariff_id "
          + "where role != 1";
  private static final String UPDATE_STATUS =
      "UPDATE internet_provider.user set status = ? where login = ? ";
  private static String GET_USER_DATA = "SELECT %s from user where %s = ?";

  private DbConnectionPool connectionPool = DbConnectionPool.getInstance();

  @Override
  public boolean registerUser(User user) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            connection -> {
              DSL.using(connection)
                  .execute(
                      INSERT_NEW,
                      user.getLogin(),
                      user.getPassword(),
                      user.getEmail(),
                      user.getRole().getValue(),
                      user.getStatus().getValue(),
                      user.getBonusAmount(),
                      user.getCash());
              return true;
            })
        .getOrElse(false);
  }

  @Override
  public List<User> getUsers() {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            connection ->
                DSL.using(connection)
                    .fetch(SELECT_USERS)
                    .map(
                        record -> {
                          User user = record.into(User.class);
                          user.setTariff(record.into(Tariff.class));
                          user.setStatus(
                              Status.getStatus(record.getValue("status", Integer.class)));
                          return user;
                        }))
        .getOrNull();
  }

  @Override
  public User getUser(String login) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            connection ->
                DSL.using(connection)
                    .fetchOne(SELECT_USER, login)
                    .map(
                        record -> {
                          User user = record.into(User.class);
                          user.setTariff(record.into(Tariff.class));
                          user.setRewards(
                              DSL.using(connection)
                                  .fetch(SELECT_REWARDS, login)
                                  .into(Reward.class));
                          user.setStatus(
                              Status.getStatus(record.getValue("status", Integer.class)));
                          user.setRole(Role.getRole(record.getValue("role", Integer.class)));
                          return user;
                        }))
        .getOrNull();
  }

  @Override
  public Credentials getCredentials(String login) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            (connection) ->
                DSL.using(connection)
                    .fetchOne(SELECT_CREDENTIALS, login)
                    .map(
                        record -> {
                          Credentials credentials = record.into(Credentials.class);
                          credentials.setRole(Role.getRole(record.getValue("role", Integer.class)));
                          credentials.setStatus(
                              Status.getStatus(record.getValue("status", Integer.class)));
                          return credentials;
                        }))
        .getOrNull();
  }

  @Override
  public String getData(String value, String field) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            connection ->
                DSL.using(connection)
                    .fetchOne(String.format(GET_USER_DATA, field, field), value)
                    .map(record -> record.getValue(field, String.class)))
        .get();
  }

  @Override
  public boolean updateCash(String login, int cash) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            (connection) -> {
              DSL.using(connection).execute(UPDATE_CASH, cash, login);
              return true;
            })
        .getOrElse(false);
  }

  @Override
  public boolean updateTariff(String login, int tariff_id) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(
            (connection) -> {
              if (tariff_id < 0) {
                DSL.using(connection).execute(DELETE_TARIFF, login);
              } else {
                DSL.using(connection).execute(UPDATE_TARIFF, tariff_id, login);
              }
              return true;
            })
        .getOrElse(false);
  }

  @Override
  public boolean changeStatus(String login, int status) {
    return Try.withResources(() -> connectionPool.getConnection())
        .of(connection -> DSL.using(connection).fetch(UPDATE_STATUS, status, login).isNotEmpty())
        .getOrElse(false);
  }
}
